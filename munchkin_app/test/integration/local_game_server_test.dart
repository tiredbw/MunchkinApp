import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/core/network/game_connection.dart';
import 'package:munchkin_app/core/network/network_protocol.dart';
import 'package:munchkin_app/data/network/local_game_server.dart';
import 'package:munchkin_app/data/storage/game_snapshot_store.dart';
import 'package:munchkin_app/domain/commands/game_command.dart';
import 'package:munchkin_app/domain/models/game_models.dart';

void main() {
  test(
    'client joins, receives snapshots and sends an authoritative command',
    () async {
      final store = MemoryGameSnapshotStore();
      final server = await LocalGameServer.create(
        roomId: 'room',
        hostPlayerId: 'host',
        hostName: 'Host',
        snapshotStore: store,
      );
      addTearDown(server.stop);
      final invite = server.inviteFor('127.0.0.1');
      final client = await _TestClient.connect(invite, 'Alice');
      addTearDown(client.close);

      expect(server.state.players.length, 2);
      expect(client.playerId, isNotEmpty);

      expect(
        await server.sendAsHost(const GameCommand.closeLobby()),
        isA<CommandAccepted>(),
      );
      expect(
        await server.sendAsHost(const GameCommand.confirmOrder()),
        isA<CommandAccepted>(),
      );
      expect(
        await server.sendAsHost(const GameCommand.startGame()),
        isA<CommandAccepted>(),
      );
      expect(
        await server.sendAsHost(const GameCommand.endTurn()),
        isA<CommandAccepted>(),
      );
      expect(server.state.activePlayerId, client.playerId);

      final reply = await client.send(
        const GameCommand.adjustStats(strengthDelta: 5),
        revision: server.state.revision,
      );
      expect(reply.type, 'accepted');
      expect(server.state.playerById(client.playerId)?.strength, 5);
      expect(store.value?.state.revision, server.state.revision);
    },
  );

  test(
    'saved resume secret reclaims the same player after host restore',
    () async {
      final store = MemoryGameSnapshotStore();
      var server = await LocalGameServer.create(
        roomId: 'room',
        hostPlayerId: 'host',
        hostName: 'Host',
        snapshotStore: store,
      );
      final client = await _TestClient.connect(
        server.inviteFor('127.0.0.1'),
        'Alice',
      );
      final playerId = client.playerId;
      final secret = client.resumeSecret;
      await client.close();
      await Future<void>.delayed(const Duration(milliseconds: 30));
      await server.stop();

      server = await LocalGameServer.restore(
        snapshot: store.value!,
        snapshotStore: store,
      );
      addTearDown(server.stop);
      final resumed = await _TestClient.connect(
        server.inviteFor('127.0.0.1'),
        'Ignored',
        playerId: playerId,
        resumeSecret: secret,
      );
      addTearDown(resumed.close);
      expect(resumed.playerId, playerId);
      expect(server.state.players.length, 2);
      expect(server.state.playerById(playerId)?.isConnected, isTrue);
    },
  );

  test(
    "battle timer expiry does not race a concurrent command's snapshot write",
    () async {
      final store = _HoldableSnapshotStore();
      final server = await LocalGameServer.create(
        roomId: 'room',
        hostPlayerId: 'host',
        hostName: 'Host',
        snapshotStore: store,
        settings: const RoomSettings(victoryCountdownSeconds: 3),
      );
      addTearDown(server.stop);

      await server.sendAsHost(const GameCommand.closeLobby());
      await server.sendAsHost(const GameCommand.confirmOrder());
      await server.sendAsHost(const GameCommand.startGame());
      await server.sendAsHost(const GameCommand.startBattle());
      await server.sendAsHost(const GameCommand.declareVictory());
      expect(server.state.battle?.status, BattleStatus.countdown);

      // Hold the next persisted write in flight while the real 3s countdown
      // elapses in the background, so the battle timer's own resolution
      // races the still-pending write instead of being serialized after it.
      store.holdNextSave();
      final adjust = server.sendAsHost(
        const GameCommand.adjustStats(strengthDelta: 1),
      );
      await Future<void>.delayed(const Duration(milliseconds: 3300));
      store.release();
      await adjust;
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(server.state.battle?.status, BattleStatus.won);
      expect(store.value?.state.revision, server.state.revision);
    },
  );
}

class _TestClient {
  _TestClient(this.socket, this.playerId, this.resumeSecret)
    : _messages = socket.asBroadcastStream();

  final WebSocket socket;
  final String playerId;
  final String resumeSecret;
  final Stream<dynamic> _messages;

  static Future<_TestClient> connect(
    RoomInvite invite,
    String name, {
    String? playerId,
    String? resumeSecret,
  }) async {
    final socket = await WebSocket.connect(
      'ws://${invite.host}:${invite.port}/ws',
    );
    final messages = socket.asBroadcastStream();
    socket.add(
      NetworkEnvelope(
        messageId: 'hello-${DateTime.now().microsecondsSinceEpoch}',
        type: 'hello',
        roomId: invite.roomId,
        payload: <String, Object?>{
          'token': invite.token,
          'pin': invite.pin,
          'name': name,
          'playerId': playerId,
          'resumeSecret': resumeSecret,
        },
      ).encode(),
    );
    final welcome = await messages
        .where((data) => data is String)
        .map((data) => NetworkEnvelope.decode(data as String))
        .firstWhere((message) => message.type == 'welcome')
        .timeout(const Duration(seconds: 3));
    final result = _TestClient(
      socket,
      welcome.payload['playerId'] as String,
      welcome.payload['resumeSecret'] as String,
    );
    result._externalMessages = messages;
    return result;
  }

  Stream<dynamic>? _externalMessages;

  Future<NetworkEnvelope> send(
    GameCommand command, {
    required int revision,
  }) async {
    final messageId = 'command-${DateTime.now().microsecondsSinceEpoch}';
    socket.add(
      NetworkEnvelope(
        messageId: messageId,
        type: 'command',
        roomId: 'room',
        senderId: playerId,
        expectedRevision: revision,
        payload: <String, Object?>{'command': command.toJson()},
      ).encode(),
    );
    return (_externalMessages ?? _messages)
        .where((data) => data is String)
        .map((data) => NetworkEnvelope.decode(data as String))
        .firstWhere((message) => message.messageId == messageId)
        .timeout(const Duration(seconds: 3));
  }

  Future<void> close() => socket.close();
}

/// A snapshot store whose next [save] call can be held open on demand, to
/// deterministically reproduce writes completing out of call order.
class _HoldableSnapshotStore implements GameSnapshotStore {
  RecoverySnapshot? value;
  Completer<void>? _hold;
  bool _claimed = false;

  void holdNextSave() {
    _hold = Completer<void>();
    _claimed = false;
  }

  void release() => _hold?.complete();

  @override
  Future<void> save(RecoverySnapshot snapshot) async {
    if (_hold != null && !_claimed) {
      _claimed = true;
      await _hold!.future;
    }
    value = snapshot;
  }

  @override
  Future<RecoverySnapshot?> load() async => value;

  @override
  Future<void> clear() async => value = null;
}
