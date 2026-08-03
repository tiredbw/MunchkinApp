import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/network/game_connection.dart';
import '../core/network/local_address.dart';
import '../core/network/network_protocol.dart';
import '../data/network/local_game_client.dart';
import '../data/network/local_game_server.dart';
import '../data/storage/client_session_store.dart';
import '../data/storage/game_snapshot_store.dart';
import '../domain/commands/game_command.dart';
import '../domain/game_engine.dart';
import '../domain/models/game_models.dart';
import 'statistics_controller.dart';

class SessionState {
  const SessionState({
    this.game,
    this.status = ConnectionStatus.disconnected,
    this.invite,
    this.error,
    this.busy = false,
    this.hasRecovery = false,
    this.hasClientSession = false,
    this.selectedPlayerId,
  });

  final GameState? game;
  final ConnectionStatus status;
  final RoomInvite? invite;
  final String? error;
  final bool busy;
  final bool hasRecovery;
  final bool hasClientSession;
  final String? selectedPlayerId;

  SessionState copyWith({
    GameState? game,
    ConnectionStatus? status,
    RoomInvite? invite,
    String? error,
    bool clearError = false,
    bool? busy,
    bool? hasRecovery,
    bool? hasClientSession,
    String? selectedPlayerId,
  }) => SessionState(
    game: game ?? this.game,
    status: status ?? this.status,
    invite: invite ?? this.invite,
    error: clearError ? null : error ?? this.error,
    busy: busy ?? this.busy,
    hasRecovery: hasRecovery ?? this.hasRecovery,
    hasClientSession: hasClientSession ?? this.hasClientSession,
    selectedPlayerId: selectedPlayerId ?? this.selectedPlayerId,
  );
}

final sessionControllerProvider =
    NotifierProvider<SessionController, SessionState>(SessionController.new);

class SessionController extends Notifier<SessionState> {
  final Uuid _uuid = const Uuid();
  final GameSnapshotStore _snapshotStore = JsonFileGameSnapshotStore();
  final ClientSessionStore _clientSessionStore = ClientSessionStore();
  GameConnection? _connection;
  StreamSubscription<GameState>? _stateSubscription;
  StreamSubscription<ConnectionStatus>? _statusSubscription;
  String? _localProfileId;

  @override
  SessionState build() {
    ref.onDispose(_dispose);
    unawaited(_checkRecovery());
    return const SessionState();
  }

  String? get primaryPlayerId => _connection?.playerId;
  String? get playerId => state.selectedPlayerId ?? primaryPlayerId;
  bool get isHost => state.game?.playerById(primaryPlayerId)?.isHost ?? false;

  List<String> get controllablePlayerIds {
    final primary = primaryPlayerId;
    final game = state.game;
    if (primary == null || game == null) return const <String>[];
    return <String>[primary, ...game.controlledPlayerIds(primary)];
  }

  Future<void> createRoom({
    required String hostName,
    required RoomSettings settings,
  }) async {
    state = state.copyWith(busy: true, clearError: true);
    try {
      final profile = await ref
          .read(statisticsControllerProvider.notifier)
          .ensureProfile(hostName);
      _localProfileId = profile.id;
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
    String? preferredProfileId,
  }) async {
    state = state.copyWith(busy: true, clearError: true);
    final client = LocalGameClient(invite: invite, name: playerName);
    try {
      await client.connect();
      await _attach(client, invite: invite);
      final actualName = client.currentState?.playerById(client.playerId)?.name;
      final profile = await ref
          .read(statisticsControllerProvider.notifier)
          .ensureProfile(
            actualName ?? playerName,
            preferredId: preferredProfileId,
          );
      _localProfileId = profile.id;
      await _clientSessionStore.save(
        SavedClientSession(
          invite: invite,
          playerName: actualName ?? playerName,
          profileId: profile.id,
        ),
      );
      state = state.copyWith(busy: false, hasClientSession: true);
    } on Object catch (error) {
      await client.disconnect();
      state = state.copyWith(busy: false, error: '$error');
      rethrow;
    }
  }

  Future<void> continueRoom() async {
    final saved = await _clientSessionStore.load();
    if (saved == null) {
      state = state.copyWith(
        error: 'No saved client session found.',
        hasClientSession: false,
      );
      return;
    }
    await joinRoom(
      invite: saved.invite,
      playerName: saved.playerName,
      preferredProfileId: saved.profileId,
    );
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
      final host = server.state.playerById(
        server.state.players.firstWhere((player) => player.isHost).id,
      )!;
      final profile = await ref
          .read(statisticsControllerProvider.notifier)
          .ensureProfile(host.name);
      _localProfileId = profile.id;
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
    final actorId = _requiresPrimaryActor(command) ? primaryPlayerId : playerId;
    final reply = await connection.send(command, actorId: actorId);
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
      await connection.send(
        const GameCommand.leaveRoom(),
        actorId: primaryPlayerId,
      );
    }
    if (connection is LocalGameClient) await connection.clearIdentity();
    await _clientSessionStore.clear();
    await _stateSubscription?.cancel();
    await _statusSubscription?.cancel();
    await connection?.disconnect();
    _connection = null;
    state = SessionState(hasRecovery: await _snapshotStore.load() != null);
  }

  void selectPlayer(String playerId) {
    if (!controllablePlayerIds.contains(playerId)) return;
    state = state.copyWith(selectedPlayerId: playerId);
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
      selectedPlayerId: connection.playerId,
    );
    _stateSubscription = connection.snapshots.listen((game) {
      final primary = connection.playerId;
      final available = <String>[
        ?primary,
        ...game.controlledPlayerIds(primary),
      ];
      final selected = available.contains(state.selectedPlayerId)
          ? state.selectedPlayerId
          : primary;
      state = state.copyWith(game: game, selectedPlayerId: selected);
      if (game.phase == RoomPhase.ended) {
        final profileId = _localProfileId;
        if (profileId != null && primary != null) {
          unawaited(
            ref
                .read(statisticsControllerProvider.notifier)
                .recordCompletedGame(
                  game: game,
                  profileId: profileId,
                  localPlayerId: primary,
                ),
          );
        }
        unawaited(_clientSessionStore.clear());
        if (connection is LocalGameClient) {
          unawaited(connection.clearIdentity());
        }
        state = state.copyWith(hasClientSession: false);
      }
    });
    _statusSubscription = connection.statuses.listen((status) {
      state = state.copyWith(status: status);
    });
  }

  Future<void> _checkRecovery() async {
    var hostAvailable = false;
    var clientAvailable = false;
    try {
      hostAvailable = await _snapshotStore.load() != null;
    } on Object {
      // A corrupt host snapshot must not hide a valid client session.
    }
    try {
      clientAvailable = await _clientSessionStore.load() != null;
    } on Object {
      // A corrupt client session must not hide a valid host snapshot.
    }
    state = state.copyWith(
      hasRecovery: hostAvailable,
      hasClientSession: clientAvailable,
    );
  }

  bool _requiresPrimaryActor(GameCommand command) =>
      command is UpdateSettings ||
      command is CloseLobby ||
      command is ReopenLobby ||
      command is SetTurnOrder ||
      command is ShuffleTurnOrder ||
      command is ConfirmOrder ||
      command is StartGame ||
      command is AdjustPlayerLevel ||
      command is ResolveDiceAppeal ||
      command is OfferControl ||
      command is RespondControl ||
      command is RevokeControl ||
      command is RemovePlayer ||
      command is LeaveRoom ||
      command is EndGame;

  void _dispose() {
    unawaited(_stateSubscription?.cancel());
    unawaited(_statusSubscription?.cancel());
  }
}
