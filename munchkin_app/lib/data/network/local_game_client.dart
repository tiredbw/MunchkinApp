import 'dart:async';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../../core/network/game_connection.dart';
import '../../core/network/network_protocol.dart';
import '../../domain/commands/game_command.dart';
import '../../domain/game_engine.dart';
import '../../domain/models/game_models.dart';

class LocalGameClient implements GameConnection {
  LocalGameClient({
    required this.invite,
    required this.name,
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final RoomInvite invite;
  final String name;
  final FlutterSecureStorage _secureStorage;
  final Uuid _uuid = const Uuid();
  final StreamController<GameState> _snapshots = StreamController.broadcast();
  final StreamController<ConnectionStatus> _statuses =
      StreamController<ConnectionStatus>.broadcast();
  final Map<String, Completer<CommandReply>> _pending =
      <String, Completer<CommandReply>>{};

  WebSocket? _socket;
  GameState? _state;
  String? _playerId;
  String? _resumeSecret;
  Timer? _reconnectTimer;
  var _reconnectAttempt = 0;
  bool _manualClose = false;

  @override
  GameState? get currentState => _state;

  @override
  String? get playerId => _playerId;

  @override
  Stream<GameState> get snapshots => _snapshots.stream;

  @override
  Stream<ConnectionStatus> get statuses => _statuses.stream;

  Future<void> connect() async {
    _manualClose = false;
    _playerId = await _secureStorage.read(key: '${invite.roomId}.playerId');
    _resumeSecret = await _secureStorage.read(
      key: '${invite.roomId}.resumeSecret',
    );
    await _connectInternal(initial: true);
  }

  Future<void> _connectInternal({required bool initial}) async {
    _statuses.add(
      initial ? ConnectionStatus.connecting : ConnectionStatus.reconnecting,
    );
    final welcome = Completer<void>();
    try {
      final socket = await WebSocket.connect(
        'ws://${invite.host}:${invite.port}/ws',
      );
      _socket = socket;
      socket.listen(
        (Object? data) {
          if (data is! String) return;
          try {
            final envelope = NetworkEnvelope.decode(data);
            unawaited(
              _handleEnvelope(envelope, welcome).catchError((Object error) {
                if (!welcome.isCompleted) welcome.completeError(error);
              }),
            );
          } on Object catch (error, stackTrace) {
            if (!welcome.isCompleted) welcome.completeError(error, stackTrace);
          }
        },
        onDone: () => _handleDisconnect(),
        onError: (Object error, StackTrace stackTrace) {
          if (!welcome.isCompleted) welcome.completeError(error, stackTrace);
          _handleDisconnect();
        },
        cancelOnError: true,
      );
      socket.add(
        NetworkEnvelope(
          messageId: _uuid.v4(),
          type: 'hello',
          roomId: invite.roomId,
          senderId: _playerId,
          payload: <String, Object?>{
            'token': invite.token,
            'pin': invite.pin,
            'name': name,
            'playerId': _playerId,
            'resumeSecret': _resumeSecret,
          },
        ).encode(),
      );
      await welcome.future.timeout(const Duration(seconds: 10));
      _reconnectAttempt = 0;
      _statuses.add(ConnectionStatus.connected);
    } on Object {
      _statuses.add(ConnectionStatus.error);
      await _socket?.close();
      _socket = null;
      if (!_manualClose) _scheduleReconnect();
      rethrow;
    }
  }

  Future<void> _handleEnvelope(
    NetworkEnvelope envelope,
    Completer<void> welcome,
  ) async {
    if (envelope.protocolVersion != currentProtocolVersion ||
        envelope.roomId != invite.roomId) {
      throw const FormatException('Protocol or room mismatch.');
    }
    switch (envelope.type) {
      case 'welcome':
        _playerId = envelope.payload['playerId'] as String;
        _resumeSecret = envelope.payload['resumeSecret'] as String;
        await _storeIdentity();
        _readState(envelope.payload['state']);
        if (!welcome.isCompleted) welcome.complete();
      case 'snapshot':
        _readState(envelope.payload['state']);
      case 'accepted':
        final completer = _pending.remove(envelope.messageId);
        completer?.complete(
          CommandAccepted(
            envelope.payload['revision'] as int? ?? _state?.revision ?? 0,
          ),
        );
      case 'rejected':
        _readState(envelope.payload['state']);
        final codeName = envelope.payload['code'] as String? ?? 'invalidState';
        final code = GameErrorCode.values.firstWhere(
          (value) => value.name == codeName,
          orElse: () => GameErrorCode.invalidState,
        );
        _pending
            .remove(envelope.messageId)
            ?.complete(
              CommandRejected(
                code,
                envelope.payload['message'] as String? ?? '',
              ),
            );
      case 'error':
        final message =
            envelope.payload['message'] as String? ?? 'Connection error.';
        if (!welcome.isCompleted) welcome.completeError(StateError(message));
      default:
        break;
    }
  }

  void _readState(Object? raw) {
    if (raw is! Map<String, Object?>) return;
    _state = GameState.fromJson(raw);
    _snapshots.add(_state!);
  }

  Future<void> _storeIdentity() async {
    await _secureStorage.write(
      key: '${invite.roomId}.playerId',
      value: _playerId,
    );
    await _secureStorage.write(
      key: '${invite.roomId}.resumeSecret',
      value: _resumeSecret,
    );
  }

  @override
  Future<CommandReply> send(GameCommand command, {String? actorId}) async {
    final socket = _socket;
    final state = _state;
    final sender = _playerId;
    if (socket == null || state == null || sender == null) {
      return const CommandRejected(
        GameErrorCode.invalidState,
        'Not connected.',
      );
    }
    final messageId = _uuid.v4();
    final completer = Completer<CommandReply>();
    _pending[messageId] = completer;
    socket.add(
      NetworkEnvelope(
        messageId: messageId,
        type: 'command',
        roomId: invite.roomId,
        senderId: actorId ?? sender,
        expectedRevision: state.revision,
        payload: <String, Object?>{
          'controllerPlayerId': sender,
          'command': command.toJson(),
        },
      ).encode(),
    );
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _pending.remove(messageId);
        return const CommandRejected(
          GameErrorCode.invalidState,
          'Command timed out.',
        );
      },
    );
  }

  void _handleDisconnect() {
    _socket = null;
    if (_manualClose) return;
    _statuses.add(ConnectionStatus.reconnecting);
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    final seconds = <int>[1, 2, 4, 8, 8][_reconnectAttempt.clamp(0, 4)];
    _reconnectAttempt++;
    _reconnectTimer = Timer(Duration(seconds: seconds), () {
      unawaited(_connectInternal(initial: false).catchError((Object _) {}));
    });
  }

  @override
  Future<void> disconnect() async {
    _manualClose = true;
    _reconnectTimer?.cancel();
    await _socket?.close(WebSocketStatus.normalClosure, 'Player left.');
    _socket = null;
    _statuses.add(ConnectionStatus.disconnected);
    for (final completer in _pending.values) {
      if (!completer.isCompleted) {
        completer.complete(
          const CommandRejected(GameErrorCode.invalidState, 'Disconnected.'),
        );
      }
    }
    _pending.clear();
    await _snapshots.close();
    await _statuses.close();
  }

  Future<void> clearIdentity() async {
    await _secureStorage.delete(key: '${invite.roomId}.playerId');
    await _secureStorage.delete(key: '${invite.roomId}.resumeSecret');
  }
}
