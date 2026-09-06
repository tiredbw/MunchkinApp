import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../../core/clock.dart';
import '../../core/network/game_connection.dart';
import '../../core/network/network_protocol.dart';
import '../../domain/commands/game_command.dart';
import '../../domain/game_engine.dart';
import '../../domain/models/game_models.dart';
import '../storage/game_snapshot_store.dart';

class LocalGameServer {
  LocalGameServer._({
    required GameEngine engine,
    required GameSnapshotStore snapshotStore,
    required GameState initialState,
    required String inviteToken,
    required String pin,
    required Map<String, String> resumeTokenHashes,
    required Clock clock,
  }) : this.__(
         engine,
         snapshotStore,
         initialState,
         inviteToken,
         pin,
         resumeTokenHashes,
         clock,
       );

  LocalGameServer.__(
    this._engine,
    this._snapshotStore,
    this._state,
    this._inviteToken,
    this._pin,
    this._resumeTokenHashes,
    this._clock,
  );

  /*
   * The private forwarding constructor keeps the public factory call sites
   * named and readable while satisfying strict initializing-formal lints.
   */

  final GameEngine _engine;
  final Clock _clock;
  final GameSnapshotStore _snapshotStore;
  final String _inviteToken;
  final String _pin;
  final Map<String, String> _resumeTokenHashes;
  final Map<String, WebSocket> _sockets = <String, WebSocket>{};
  final Set<String> _processedMessageIds = <String>{};
  final StreamController<GameState> _states = StreamController.broadcast();
  final Uuid _uuid = const Uuid();

  GameState _state;
  HttpServer? _httpServer;
  Timer? _battleTimer;
  Future<void> _queue = Future<void>.value();
  bool _stopping = false;

  GameState get state => _state;
  Stream<GameState> get states => _states.stream;
  int get port => _httpServer?.port ?? 0;
  String get pin => _pin;

  static Future<LocalGameServer> create({
    required String roomId,
    required String hostPlayerId,
    required String hostName,
    required GameSnapshotStore snapshotStore,
    RoomSettings settings = const RoomSettings(),
    Clock clock = const SystemClock(),
    RandomSource? random,
  }) async {
    final randomSource = random ?? SecureRandomSource();
    final engine = GameEngine(clock: clock, random: randomSource);
    final state = engine.createRoom(
      roomId: roomId,
      hostPlayerId: hostPlayerId,
      hostName: hostName,
      settings: settings,
    );
    final server = LocalGameServer._(
      engine: engine,
      snapshotStore: snapshotStore,
      initialState: state,
      inviteToken: _secureToken(),
      pin: _sixDigitPin(randomSource),
      resumeTokenHashes: <String, String>{},
      clock: clock,
    );
    await server._start();
    await server._persist();
    return server;
  }

  static Future<LocalGameServer> restore({
    required RecoverySnapshot snapshot,
    required GameSnapshotStore snapshotStore,
    Clock clock = const SystemClock(),
    RandomSource? random,
  }) async {
    final randomSource = random ?? SecureRandomSource();
    final engine = GameEngine(clock: clock, random: randomSource);
    var state = snapshot.state.copyWith(
      players: snapshot.state.players
          .map((player) => player.copyWith(isConnected: false))
          .toList(growable: false),
    );
    final battle = state.battle;
    if (battle?.status == BattleStatus.countdown) {
      state = state.copyWith(
        battle: battle!.copyWith(status: BattleStatus.fighting, endsAt: null),
      );
    }
    final server = LocalGameServer._(
      engine: engine,
      snapshotStore: snapshotStore,
      initialState: state,
      inviteToken: _secureToken(),
      pin: _sixDigitPin(randomSource),
      resumeTokenHashes: {...snapshot.resumeTokenHashes},
      clock: clock,
    );
    await server._start();
    await server._persist();
    return server;
  }

  RoomInvite inviteFor(String host) => RoomInvite(
    host: host,
    port: port,
    roomId: _state.roomId,
    token: _inviteToken,
    pin: _pin,
  );

  Future<CommandReply> sendAsHost(
    GameCommand command, {
    String? actAsPlayerId,
  }) {
    final host = _state.players.firstWhere((player) => player.isHost);
    final actorId = _resolveActor(host.id, actAsPlayerId);
    if (actorId == null) {
      return Future.value(
        const CommandRejected(
          GameErrorCode.forbidden,
          'This device does not control that player.',
        ),
      );
    }
    return _enqueueCommand(
      messageId: _uuid.v4(),
      actorId: actorId,
      expectedRevision: _state.revision,
      command: command,
    );
  }

  /// Resolves who a command should be applied as: the connection's own
  /// player, or one of the local players added on their device.
  String? _resolveActor(String connectionPlayerId, String? actAsPlayerId) {
    if (actAsPlayerId == null || actAsPlayerId == connectionPlayerId) {
      return connectionPlayerId;
    }
    if (_state.controlledPlayerIds(connectionPlayerId).contains(actAsPlayerId)) {
      return actAsPlayerId;
    }
    return null;
  }

  Future<void> stop() async {
    _stopping = true;
    _battleTimer?.cancel();
    for (final socket in _sockets.values.toList(growable: false)) {
      await socket.close(WebSocketStatus.goingAway, 'Host stopped.');
    }
    _sockets.clear();
    await _httpServer?.close(force: true);
    _httpServer = null;
    await _states.close();
  }

  Future<void> _start() async {
    _httpServer = await HttpServer.bind(InternetAddress.anyIPv4, 0);
    unawaited(_serve());
    _scheduleBattleTimer();
  }

  Future<void> _serve() async {
    await for (final request in _httpServer!) {
      if (request.uri.path != '/ws' ||
          !WebSocketTransformer.isUpgradeRequest(request)) {
        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
        continue;
      }
      try {
        final socket = await WebSocketTransformer.upgrade(request);
        _handleSocket(socket);
      } on Object {
        request.response.statusCode = HttpStatus.badRequest;
        await request.response.close();
      }
    }
  }

  void _handleSocket(WebSocket socket) {
    String? boundPlayerId;
    var authenticated = false;
    final authTimer = Timer(const Duration(seconds: 10), () {
      if (!authenticated) {
        unawaited(
          socket.close(WebSocketStatus.policyViolation, 'Handshake timeout.'),
        );
      }
    });

    socket.listen(
      (Object? data) {
        if (data is! String) {
          unawaited(
            socket.close(WebSocketStatus.unsupportedData, 'Text only.'),
          );
          return;
        }
        try {
          final envelope = NetworkEnvelope.decode(data);
          if (!authenticated) {
            if (envelope.type != 'hello') {
              throw const FormatException('First message must be hello.');
            }
            unawaited(
              _authenticate(socket, envelope).then((playerId) {
                if (playerId == null) return;
                authenticated = true;
                boundPlayerId = playerId;
                authTimer.cancel();
              }),
            );
            return;
          }
          if (envelope.type != 'command' ||
              envelope.senderId != boundPlayerId) {
            throw const FormatException('Invalid command envelope.');
          }
          unawaited(_handleCommand(socket, envelope, boundPlayerId!));
        } on Object catch (error) {
          _sendError(socket, 'invalidMessage', '$error');
        }
      },
      onDone: () {
        authTimer.cancel();
        final playerId = boundPlayerId;
        if (!_stopping && playerId != null && _sockets[playerId] == socket) {
          _sockets.remove(playerId);
          unawaited(_markConnected(playerId, false));
        }
      },
      onError: (Object _) {},
      cancelOnError: true,
    );
  }

  Future<String?> _authenticate(
    WebSocket socket,
    NetworkEnvelope envelope,
  ) async {
    if (envelope.protocolVersion != currentProtocolVersion ||
        envelope.roomId != _state.roomId) {
      _sendError(
        socket,
        'incompatibleRoom',
        'Room or protocol does not match.',
      );
      await socket.close(WebSocketStatus.policyViolation);
      return null;
    }
    final token = envelope.payload['token'] as String? ?? '';
    final pin = envelope.payload['pin'] as String? ?? '';
    if (token != _inviteToken && pin != _pin) {
      _sendError(socket, 'unauthorized', 'Invalid room token or PIN.');
      await socket.close(WebSocketStatus.policyViolation);
      return null;
    }

    final requestedId = envelope.payload['playerId'] as String?;
    final resumeSecret = envelope.payload['resumeSecret'] as String?;
    String playerId;
    String issuedSecret;
    if (requestedId != null &&
        resumeSecret != null &&
        _resumeTokenHashes[requestedId] == _hash(resumeSecret) &&
        _state.playerById(requestedId) != null) {
      playerId = requestedId;
      issuedSecret = resumeSecret;
      await _markConnected(playerId, true);
    } else {
      final name = envelope.payload['name'] as String? ?? '';
      playerId = _uuid.v4();
      issuedSecret = _secureToken();
      final result = _engine.apply(
        _state,
        GameCommand.joinPlayer(playerId: playerId, name: name),
        actorId: 'system',
      );
      if (result is GameRejected) {
        _sendError(socket, result.code.name, result.message);
        await socket.close(WebSocketStatus.policyViolation);
        return null;
      }
      _state = (result as GameAccepted).state;
      _resumeTokenHashes[playerId] = _hash(issuedSecret);
      await _publish();
    }

    final previous = _sockets[playerId];
    if (previous != null) {
      await previous.close(
        WebSocketStatus.normalClosure,
        'Reconnected elsewhere.',
      );
    }
    _sockets[playerId] = socket;
    socket.add(
      NetworkEnvelope(
        messageId: _uuid.v4(),
        type: 'welcome',
        roomId: _state.roomId,
        payload: <String, Object?>{
          'playerId': playerId,
          'resumeSecret': issuedSecret,
          'state': _state.toJson(),
        },
      ).encode(),
    );
    _broadcastSnapshot();
    return playerId;
  }

  Future<void> _handleCommand(
    WebSocket socket,
    NetworkEnvelope envelope,
    String actorId,
  ) async {
    final rawCommand = envelope.payload['command'];
    if (rawCommand is! Map<String, Object?>) {
      _sendError(socket, 'invalidCommand', 'Command payload is missing.');
      return;
    }
    final GameCommand command;
    try {
      command = GameCommand.fromJson(rawCommand);
    } on Object catch (error) {
      _sendError(socket, 'invalidCommand', 'Malformed command: $error');
      return;
    }
    final actAsPlayerId = envelope.payload['actAs'] as String?;
    final resolvedActorId = _resolveActor(actorId, actAsPlayerId);
    if (resolvedActorId == null) {
      socket.add(
        NetworkEnvelope(
          messageId: envelope.messageId,
          type: 'rejected',
          roomId: _state.roomId,
          payload: <String, Object?>{
            'code': GameErrorCode.forbidden.name,
            'message': 'This device does not control that player.',
            'state': _state.toJson(),
          },
        ).encode(),
      );
      return;
    }
    final reply = await _enqueueCommand(
      messageId: envelope.messageId,
      actorId: resolvedActorId,
      expectedRevision: envelope.expectedRevision,
      command: command,
    );
    if (reply is CommandAccepted) {
      socket.add(
        NetworkEnvelope(
          messageId: envelope.messageId,
          type: 'accepted',
          roomId: _state.roomId,
          payload: <String, Object?>{'revision': reply.revision},
        ).encode(),
      );
    } else if (reply is CommandRejected) {
      socket.add(
        NetworkEnvelope(
          messageId: envelope.messageId,
          type: 'rejected',
          roomId: _state.roomId,
          payload: <String, Object?>{
            'code': reply.code.name,
            'message': reply.message,
            'state': _state.toJson(),
          },
        ).encode(),
      );
    }
  }

  Future<CommandReply> _enqueueCommand({
    required String messageId,
    required String actorId,
    required int? expectedRevision,
    required GameCommand command,
  }) {
    final completer = Completer<CommandReply>();
    _queue = _queue
        .then((_) async {
          if (_processedMessageIds.contains(messageId)) {
            completer.complete(CommandAccepted(_state.revision));
            return;
          }
          final canRebase = command is AdjustStats || command is Intervene;
          if (!canRebase &&
              expectedRevision != null &&
              expectedRevision != _state.revision) {
            completer.complete(
              const CommandRejected(
                GameErrorCode.staleRevision,
                'State changed; try again.',
              ),
            );
            return;
          }
          final result = _engine.apply(_state, command, actorId: actorId);
          if (result is GameRejected) {
            completer.complete(CommandRejected(result.code, result.message));
            return;
          }
          _rememberMessage(messageId);
          _state = (result as GameAccepted).state;
          await _publish();
          if (command is EndGame) await _snapshotStore.clear();
          completer.complete(CommandAccepted(_state.revision));
        })
        .catchError((Object error, StackTrace stackTrace) {
          if (!completer.isCompleted) {
            completer.complete(
              CommandRejected(GameErrorCode.invalidState, '$error'),
            );
          }
        });
    return completer.future;
  }

  Future<void> _markConnected(String playerId, bool connected) async {
    final result = _engine.apply(
      _state,
      GameCommand.setConnection(playerId: playerId, connected: connected),
      actorId: 'system',
    );
    if (result is GameAccepted) {
      _state = result.state;
      await _publish();
    }
  }

  Future<void> _publish() async {
    await _persist();
    if (!_states.isClosed) _states.add(_state);
    _broadcastSnapshot();
    _scheduleBattleTimer();
  }

  Future<void> _persist() => _snapshotStore.save(
    RecoverySnapshot(state: _state, resumeTokenHashes: _resumeTokenHashes),
  );

  void _broadcastSnapshot() {
    final encoded = NetworkEnvelope(
      messageId: _uuid.v4(),
      type: 'snapshot',
      roomId: _state.roomId,
      payload: <String, Object?>{'state': _state.toJson()},
    ).encode();
    for (final socket in _sockets.values) {
      socket.add(encoded);
    }
  }

  void _scheduleBattleTimer() {
    _battleTimer?.cancel();
    final endsAt = _state.battle?.endsAt;
    if (_state.battle?.status != BattleStatus.countdown || endsAt == null) {
      return;
    }
    final delay = endsAt.difference(_clock.now());
    _battleTimer = Timer(delay.isNegative ? Duration.zero : delay, () {
      _queue = _queue.then((_) async {
        final resolved = _engine.resolveExpiredTimers(_state);
        if (resolved.revision != _state.revision) {
          _state = resolved;
          await _publish();
        }
      });
    });
  }

  void _rememberMessage(String id) {
    _processedMessageIds.add(id);
    if (_processedMessageIds.length > 1000) {
      _processedMessageIds.remove(_processedMessageIds.first);
    }
  }

  void _sendError(WebSocket socket, String code, String message) {
    socket.add(
      NetworkEnvelope(
        messageId: _uuid.v4(),
        type: 'error',
        roomId: _state.roomId,
        payload: <String, Object?>{'code': code, 'message': message},
      ).encode(),
    );
  }

  static String _secureToken() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  static String _sixDigitPin(RandomSource random) =>
      (random.nextInt(900000) + 100000).toString();

  static String _hash(String value) =>
      sha256.convert(utf8.encode(value)).toString();
}

class LocalHostConnection implements GameConnection {
  LocalHostConnection(this.server)
    : _hostId = server.state.players.firstWhere((player) => player.isHost).id;

  final LocalGameServer server;
  final String _hostId;
  final StreamController<ConnectionStatus> _statuses =
      StreamController<ConnectionStatus>.broadcast();

  @override
  GameState? get currentState => server.state;

  @override
  String? get playerId => _hostId;

  @override
  Stream<GameState> get snapshots => server.states;

  @override
  Stream<ConnectionStatus> get statuses async* {
    yield ConnectionStatus.connected;
    yield* _statuses.stream;
  }

  @override
  Future<CommandReply> send(GameCommand command, {String? actAsPlayerId}) =>
      server.sendAsHost(command, actAsPlayerId: actAsPlayerId);

  @override
  Future<void> disconnect() async {
    await server.stop();
    if (!_statuses.isClosed) {
      _statuses.add(ConnectionStatus.disconnected);
      await _statuses.close();
    }
  }
}
