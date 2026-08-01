import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/core/network/game_connection.dart';
import 'package:munchkin_app/core/network/network_protocol.dart';
import 'package:munchkin_app/data/network/local_game_server.dart';
import 'package:munchkin_app/data/storage/game_snapshot_store.dart';
import 'package:munchkin_app/domain/commands/game_command.dart';

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

  test('client cannot send internal player-management commands', () async {
    final store = MemoryGameSnapshotStore();
    final server = await LocalGameServer.create(
      roomId: 'room',
      hostPlayerId: 'host',
      hostName: 'Host',
      snapshotStore: store,
    );
    addTearDown(server.stop);
    final client = await _TestClient.connect(
      server.inviteFor('127.0.0.1'),
      'Alice',
    );
    addTearDown(client.close);

    final reply = await client.sendRawCommand(<String, Object?>{
      'type': 'JoinPlayer',
      'playerId': 'fake-host',
      'name': 'Fake host',
      'isHost': true,
    });

    expect(reply.type, 'error');
    expect(server.state.players.length, 2);
    expect(server.state.playerById('fake-host'), isNull);
  });

  test(
    'disconnect after end game does not recreate recovery snapshot',
    () async {
      final store = MemoryGameSnapshotStore();
      final server = await LocalGameServer.create(
        roomId: 'room',
        hostPlayerId: 'host',
        hostName: 'Host',
        snapshotStore: store,
      );
      addTearDown(server.stop);
      final client = await _TestClient.connect(
        server.inviteFor('127.0.0.1'),
        'Alice',
      );

      expect(
        await server.sendAsHost(const GameCommand.endGame()),
        isA<CommandAccepted>(),
      );
      expect(store.value, isNull);
      await client.close();
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(store.value, isNull);
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

  Future<NetworkEnvelope> sendRawCommand(Map<String, Object?> command) async {
    final response = (_externalMessages ?? _messages)
        .where((data) => data is String)
        .map((data) => NetworkEnvelope.decode(data as String))
        .firstWhere((message) => message.type == 'error')
        .timeout(const Duration(seconds: 3));
    socket.add(
      NetworkEnvelope(
        messageId: 'raw-${DateTime.now().microsecondsSinceEpoch}',
        type: 'command',
        roomId: 'room',
        senderId: playerId,
        payload: <String, Object?>{'command': command},
      ).encode(),
    );
    return response;
  }

  Future<void> close() => socket.close();
}
