import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/network/game_connection.dart';
import '../core/network/local_address.dart';
import '../core/network/network_protocol.dart';
import '../data/network/local_game_client.dart';
import '../data/network/local_game_server.dart';
import '../data/storage/game_snapshot_store.dart';
import '../domain/commands/game_command.dart';
import '../domain/game_engine.dart';
import '../domain/models/game_models.dart';

class SessionState {
  const SessionState({
    this.game,
    this.status = ConnectionStatus.disconnected,
    this.invite,
    this.error,
    this.busy = false,
    this.hasRecovery = false,
  });

  final GameState? game;
  final ConnectionStatus status;
  final RoomInvite? invite;
  final String? error;
  final bool busy;
  final bool hasRecovery;

  SessionState copyWith({
    GameState? game,
    ConnectionStatus? status,
    RoomInvite? invite,
    String? error,
    bool clearError = false,
    bool? busy,
    bool? hasRecovery,
  }) => SessionState(
    game: game ?? this.game,
    status: status ?? this.status,
    invite: invite ?? this.invite,
    error: clearError ? null : error ?? this.error,
    busy: busy ?? this.busy,
    hasRecovery: hasRecovery ?? this.hasRecovery,
  );
}

final sessionControllerProvider =
    NotifierProvider<SessionController, SessionState>(SessionController.new);

class SessionController extends Notifier<SessionState> {
  final Uuid _uuid = const Uuid();
  final GameSnapshotStore _snapshotStore = JsonFileGameSnapshotStore();
  GameConnection? _connection;
  StreamSubscription<GameState>? _stateSubscription;
  StreamSubscription<ConnectionStatus>? _statusSubscription;

  @override
  SessionState build() {
    ref.onDispose(_dispose);
    unawaited(_checkRecovery());
    return const SessionState();
  }

  String? get playerId => _connection?.playerId;
  bool get isHost => state.game?.playerById(playerId)?.isHost ?? false;

  Future<void> createRoom({
    required String hostName,
    required RoomSettings settings,
  }) async {
    state = state.copyWith(busy: true, clearError: true);
    try {
      final server = await LocalGameServer.create(
        roomId: _uuid.v4(),
        hostPlayerId: _uuid.v4(),
        hostName: hostName,
        settings: settings,
        snapshotStore: _snapshotStore,
      );
      final addresses = await localIpv4Addresses();
      final invite = server.inviteFor(addresses.firstOrNull ?? '127.0.0.1');
      await _attach(LocalHostConnection(server), invite: invite);
      state = state.copyWith(busy: false, hasRecovery: true);
    } on Object catch (error) {
      state = state.copyWith(busy: false, error: '$error');
      rethrow;
    }
  }

  Future<void> joinRoom({
    required RoomInvite invite,
    required String playerName,
  }) async {
    state = state.copyWith(busy: true, clearError: true);
    final client = LocalGameClient(invite: invite, name: playerName);
    try {
      await client.connect();
      await _attach(client, invite: invite);
      state = state.copyWith(busy: false);
    } on Object catch (error) {
      await client.disconnect();
      state = state.copyWith(busy: false, error: '$error');
      rethrow;
    }
  }

  Future<void> restoreRoom() async {
    state = state.copyWith(busy: true, clearError: true);
    final snapshot = await _snapshotStore.load();
    if (snapshot == null) {
      state = state.copyWith(busy: false, error: 'No saved game found.');
      return;
    }
    try {
      final server = await LocalGameServer.restore(
        snapshot: snapshot,
        snapshotStore: _snapshotStore,
      );
      await server.connectHost();
      final addresses = await localIpv4Addresses();
      await _attach(
        LocalHostConnection(server),
        invite: server.inviteFor(addresses.firstOrNull ?? '127.0.0.1'),
      );
      state = state.copyWith(busy: false, hasRecovery: true);
    } on Object catch (error) {
      state = state.copyWith(busy: false, error: '$error');
      rethrow;
    }
  }

  Future<CommandReply> send(GameCommand command) async {
    final connection = _connection;
    if (connection == null || state.busy) {
      return const CommandRejected(
        GameErrorCode.invalidState,
        'No active connection.',
      );
    }
    state = state.copyWith(busy: true, clearError: true);
    final reply = await connection.send(command);
    if (reply is CommandRejected) {
      state = state.copyWith(busy: false, error: reply.message);
    } else {
      state = state.copyWith(busy: false);
    }
    return reply;
  }

  Future<void> leave() async {
    final connection = _connection;
    final me = state.game?.playerById(connection?.playerId);
    if (connection != null &&
        me != null &&
        !me.isHost &&
        state.status == ConnectionStatus.connected) {
      await connection.send(const GameCommand.leaveRoom());
    }
    await _stateSubscription?.cancel();
    await _statusSubscription?.cancel();
    await connection?.disconnect();
    _connection = null;
    state = SessionState(hasRecovery: await _snapshotStore.load() != null);
  }

  void clearError() => state = state.copyWith(clearError: true);

  Future<void> _attach(
    GameConnection connection, {
    required RoomInvite invite,
  }) async {
    await _stateSubscription?.cancel();
    await _statusSubscription?.cancel();
    _connection = connection;
    state = state.copyWith(
      game: connection.currentState,
      invite: invite,
      status: ConnectionStatus.connected,
    );
    _stateSubscription = connection.snapshots.listen((game) {
      state = state.copyWith(game: game);
    });
    _statusSubscription = connection.statuses.listen((status) {
      state = state.copyWith(status: status);
    });
  }

  Future<void> _checkRecovery() async {
    try {
      final available = await _snapshotStore.load() != null;
      state = state.copyWith(hasRecovery: available);
    } on Object {
      state = state.copyWith(hasRecovery: false);
    }
  }

  void _dispose() {
    unawaited(_stateSubscription?.cancel());
    unawaited(_statusSubscription?.cancel());
  }
}
