import '../core/clock.dart';
import 'commands/game_command.dart';
import 'models/game_models.dart';

enum GameErrorCode {
  forbidden,
  invalidState,
  invalidValue,
  playerNotFound,
  duplicateName,
  roomFull,
  staleRevision,
}

sealed class GameResult {
  const GameResult();
}

class GameAccepted extends GameResult {
  const GameAccepted(this.state);

  final GameState state;
}

class GameRejected extends GameResult {
  const GameRejected(this.code, this.message);

  final GameErrorCode code;
  final String message;
}

class GameEngine {
  GameEngine({required Clock clock, required RandomSource random})
    : this._(clock, random);

  GameEngine._(this._clock, this._random);

  final Clock _clock;
  final RandomSource _random;

  GameState createRoom({
    required String roomId,
    required String hostPlayerId,
    required String hostName,
    RoomSettings settings = const RoomSettings(),
  }) {
    final now = _clock.now();
    _validateSettings(settings);
    final normalizedHostName = _normalizeName(hostName);
    _validatePlayerName(normalizedHostName);
    return GameState(
      roomId: roomId,
      settings: settings,
      players: <Player>[
        Player(
          id: hostPlayerId,
          name: normalizedHostName,
          isHost: true,
          level: settings.initialLevel,
          peakLevel: settings.initialLevel,
          strength: settings.initialStrength,
          lastSeenAt: now,
        ),
      ],
      createdAt: now,
      updatedAt: now,
    );
  }

  GameResult apply(
    GameState state,
    GameCommand command, {
    required String actorId,
  }) {
    try {
      _require(
        state.phase != RoomPhase.ended,
        GameErrorCode.invalidState,
        'The game has ended.',
      );
      final next = command.map(
        updateSettings: (value) =>
            _updateSettings(state, actorId, value.settings),
        closeLobby: (_) => _closeLobby(state, actorId),
        reopenLobby: (_) => _reopenLobby(state, actorId),
        setTurnOrder: (value) => _setTurnOrder(state, actorId, value.playerIds),
        shuffleTurnOrder: (_) => _shuffle(state, actorId),
        confirmOrder: (_) => _confirmOrder(state, actorId),
        startGame: (_) => _startGame(state, actorId),
        adjustStats: (value) =>
            _adjustStats(state, actorId, strengthDelta: value.strengthDelta),
        adjustPlayerLevel: (value) =>
            _adjustPlayerLevel(state, actorId, value.playerId, value.delta),
        endTurn: (_) => _endTurn(state, actorId),
        startBattle: (_) => _startBattle(state, actorId),
        declareVictory: (_) => _declareVictory(state, actorId),
        intervene: (_) => _intervene(state, actorId),
        requestHelp: (_) => _requestHelp(state, actorId),
        resumeBattle: (_) => _resumeBattle(state, actorId),
        startEscape: (_) => _startEscape(state, actorId),
        resolveEscape: (_) => _resolveEscape(state, actorId),
        raiseLevel: (_) => _raiseLevel(state, actorId),
        finishBattle: (_) => _finishBattle(state, actorId),
        rollDice: (_) => _rollDice(state, actorId),
        recordPhysicalRoll: (value) =>
            _recordPhysicalRoll(state, actorId, value.value),
        useCheatDie: (value) => _useCheatDie(state, actorId, value.value),
        appealCheatDie: (_) => _appealCheatDie(state, actorId),
        resolveDiceAppeal: (value) =>
            _resolveDiceAppeal(state, actorId, value.accepted),
        offerControl: (value) => _offerControl(
          state,
          actorId,
          value.playerId,
          value.controllerPlayerId,
        ),
        respondControl: (value) =>
            _respondControl(state, actorId, value.playerId, value.accepted),
        revokeControl: (value) =>
            _revokeControl(state, actorId, value.playerId),
        removePlayer: (value) => _removePlayer(state, actorId, value.playerId),
        leaveRoom: (_) => _leaveRoom(state, actorId),
        endGame: (_) => _endGame(state, actorId),
      );
      return GameAccepted(_commit(next));
    } on _RuleViolation catch (error) {
      return GameRejected(error.code, error.message);
    }
  }

  GameResult addPlayer(
    GameState state, {
    required String playerId,
    required String name,
  }) {
    try {
      return GameAccepted(
        _commit(_join(state, playerId: playerId, name: name)),
      );
    } on _RuleViolation catch (error) {
      return GameRejected(error.code, error.message);
    }
  }

  GameResult setPlayerConnection(
    GameState state, {
    required String playerId,
    required bool connected,
  }) {
    try {
      _require(
        state.phase != RoomPhase.ended,
        GameErrorCode.invalidState,
        'The game has ended.',
      );
      return GameAccepted(
        _commit(
          _setConnection(state, playerId: playerId, connected: connected),
        ),
      );
    } on _RuleViolation catch (error) {
      return GameRejected(error.code, error.message);
    }
  }

  GameState resolveExpiredTimers(GameState state) {
    final battle = state.battle;
    if (battle?.status != BattleStatus.countdown || battle?.endsAt == null) {
      return state;
    }
    if (_clock.now().isBefore(battle!.endsAt!)) return state;
    return _commit(
      state.copyWith(
        battle: battle.copyWith(status: BattleStatus.won, endsAt: null),
      ),
    );
  }

  GameState _join(
    GameState state, {
    required String playerId,
    required String name,
  }) {
    _require(
      state.phase == RoomPhase.lobby,
      GameErrorCode.invalidState,
      'The room is closed.',
    );
    _require(
      state.players.length < 12,
      GameErrorCode.roomFull,
      'The room is full.',
    );
    final normalizedName = _normalizeName(name);
    _validatePlayerName(normalizedName);
    _require(
      state.players.every(
        (player) => player.name.toLowerCase() != normalizedName.toLowerCase(),
      ),
      GameErrorCode.duplicateName,
      'This name is already in use.',
    );
    final player = Player(
      id: playerId,
      name: normalizedName,
      isHost: false,
      level: state.settings.initialLevel,
      peakLevel: state.settings.initialLevel,
      strength: state.settings.initialStrength,
      lastSeenAt: _clock.now(),
    );
    return state.copyWith(players: <Player>[...state.players, player]);
  }

  GameState _setConnection(
    GameState state, {
    required String playerId,
    required bool connected,
  }) {
    final index = state.players.indexWhere((player) => player.id == playerId);
    _require(index >= 0, GameErrorCode.playerNotFound, 'Player was not found.');
    final players = [...state.players];
    players[index] = players[index].copyWith(
      isConnected: connected,
      lastSeenAt: _clock.now(),
    );
    final assignments = state.controlAssignments
        .where((assignment) {
          if (connected && assignment.playerId == playerId) return false;
          if (!connected &&
              assignment.controllerPlayerId == playerId &&
              assignment.status == ControlAssignmentStatus.pending) {
            return false;
          }
          return true;
        })
        .toList(growable: false);
    return state.copyWith(players: players, controlAssignments: assignments);
  }

  GameState _updateSettings(
    GameState state,
    String actorId,
    RoomSettings settings,
  ) {
    _requireHost(state, actorId);
    _require(
      state.phase == RoomPhase.lobby,
      GameErrorCode.invalidState,
      'Settings are locked after the lobby closes.',
    );
    _validateSettings(settings);
    final players = state.players
        .map(
          (player) => player.copyWith(
            level: player.level.clamp(settings.minLevel, settings.maxLevel),
            peakLevel: player.peakLevel.clamp(
              settings.minLevel,
              settings.maxLevel,
            ),
            strength: player.strength.clamp(
              settings.minStrength,
              settings.maxStrength,
            ),
          ),
        )
        .toList(growable: false);
    return state.copyWith(settings: settings, players: players);
  }

  GameState _closeLobby(GameState state, String actorId) {
    _requireHost(state, actorId);
    _require(
      state.phase == RoomPhase.lobby,
      GameErrorCode.invalidState,
      'Lobby is not open.',
    );
    _require(
      state.players.isNotEmpty,
      GameErrorCode.invalidState,
      'No players.',
    );
    return state.copyWith(
      phase: RoomPhase.ordering,
      turnOrder: state.players
          .map((player) => player.id)
          .toList(growable: false),
    );
  }

  GameState _reopenLobby(GameState state, String actorId) {
    _requireHost(state, actorId);
    _require(
      state.phase == RoomPhase.ordering || state.phase == RoomPhase.ready,
      GameErrorCode.invalidState,
      'The game has already started.',
    );
    return state.copyWith(phase: RoomPhase.lobby, turnOrder: const <String>[]);
  }

  GameState _setTurnOrder(GameState state, String actorId, List<String> ids) {
    _requireHost(state, actorId);
    _require(
      state.phase == RoomPhase.ordering,
      GameErrorCode.invalidState,
      'Turn order cannot be changed now.',
    );
    final expected = state.players.map((player) => player.id).toSet();
    _require(
      ids.length == expected.length && ids.toSet().containsAll(expected),
      GameErrorCode.invalidValue,
      'Turn order must contain every player once.',
    );
    return state.copyWith(turnOrder: List<String>.unmodifiable(ids));
  }

  GameState _shuffle(GameState state, String actorId) {
    final order = [..._setTurnOrder(state, actorId, state.turnOrder).turnOrder];
    for (var index = order.length - 1; index > 0; index--) {
      final swap = _random.nextInt(index + 1);
      final value = order[index];
      order[index] = order[swap];
      order[swap] = value;
    }
    return state.copyWith(turnOrder: order);
  }

  GameState _confirmOrder(GameState state, String actorId) {
    _requireHost(state, actorId);
    _require(
      state.phase == RoomPhase.ordering,
      GameErrorCode.invalidState,
      'Order is not being edited.',
    );
    _require(
      state.turnOrder.isNotEmpty,
      GameErrorCode.invalidState,
      'Turn order is empty.',
    );
    return state.copyWith(phase: RoomPhase.ready);
  }

  GameState _startGame(GameState state, String actorId) {
    _requireHost(state, actorId);
    _require(
      state.phase == RoomPhase.ready,
      GameErrorCode.invalidState,
      'Confirm the turn order first.',
    );
    return state.copyWith(
      phase: RoomPhase.playing,
      activePlayerId: state.turnOrder.first,
      startedAt: _clock.now(),
    );
  }

  GameState _adjustStats(
    GameState state,
    String actorId, {
    required int strengthDelta,
  }) {
    _require(
      state.battle == null,
      GameErrorCode.invalidState,
      'Character stats cannot be changed during a battle.',
    );
    _require(
      const {-5, -1, 1, 5}.contains(strengthDelta),
      GameErrorCode.invalidValue,
      'Unsupported stat adjustment.',
    );
    final index = state.players.indexWhere((player) => player.id == actorId);
    _require(index >= 0, GameErrorCode.playerNotFound, 'Player was not found.');
    final player = state.players[index];
    final strength = player.strength + strengthDelta;
    _require(
      strength >= state.settings.minStrength &&
          strength <= state.settings.maxStrength,
      GameErrorCode.invalidValue,
      'Strength is outside the room limits.',
    );
    final players = [...state.players];
    players[index] = player.copyWith(strength: strength);
    return state.copyWith(players: players);
  }

  GameState _adjustPlayerLevel(
    GameState state,
    String actorId,
    String playerId,
    int delta,
  ) {
    _requireHost(state, actorId);
    _require(
      state.battle == null,
      GameErrorCode.invalidState,
      'Character stats cannot be changed during a battle.',
    );
    _require(
      delta == -1 || delta == 1,
      GameErrorCode.invalidValue,
      'Unsupported level adjustment.',
    );
    final index = state.players.indexWhere((player) => player.id == playerId);
    _require(index >= 0, GameErrorCode.playerNotFound, 'Player was not found.');
    final player = state.players[index];
    final level = player.level + delta;
    _require(
      level >= state.settings.minLevel && level <= state.settings.maxLevel,
      GameErrorCode.invalidValue,
      'Level is outside the room limits.',
    );
    final players = [...state.players];
    players[index] = player.copyWith(
      level: level,
      peakLevel: level > player.peakLevel ? level : player.peakLevel,
    );
    return state.copyWith(players: players);
  }

  GameState _endTurn(GameState state, String actorId) {
    _requireActive(state, actorId);
    _require(
      state.phase == RoomPhase.playing && state.battle == null,
      GameErrorCode.invalidState,
      'Finish the battle first.',
    );
    _requireNoPendingDiceAppeal(state);
    final current = state.turnOrder.indexOf(actorId);
    _require(
      current >= 0,
      GameErrorCode.invalidState,
      'Active player is not in order.',
    );
    return state.copyWith(
      activePlayerId: state.turnOrder[(current + 1) % state.turnOrder.length],
      battleStartedThisTurn: false,
      lastDiceRoll: null,
      diceAppeal: null,
    );
  }

  GameState _startBattle(GameState state, String actorId) {
    _requireActive(state, actorId);
    _requireNoPendingDiceAppeal(state);
    _require(
      state.phase == RoomPhase.playing && state.battle == null,
      GameErrorCode.invalidState,
      'A battle is already active.',
    );
    _require(
      !state.battleStartedThisTurn,
      GameErrorCode.invalidState,
      'Only one battle is allowed per turn.',
    );
    return state.copyWith(
      battle: BattleState(playerId: actorId),
      battleStartedThisTurn: true,
    );
  }

  GameState _declareVictory(GameState state, String actorId) {
    _requireActive(state, actorId);
    final battle = _requireBattle(state);
    _require(
      const {
        BattleStatus.fighting,
        BattleStatus.intervention,
        BattleStatus.helpRequested,
      }.contains(battle.status),
      GameErrorCode.invalidState,
      'Victory cannot be declared now.',
    );
    return state.copyWith(
      battle: battle.copyWith(
        status: BattleStatus.countdown,
        endsAt: _clock.now().add(
          Duration(seconds: state.settings.victoryCountdownSeconds),
        ),
        intervenedBy: null,
      ),
    );
  }

  GameState _intervene(GameState state, String actorId) {
    _require(
      actorId != state.activePlayerId,
      GameErrorCode.forbidden,
      'The active player cannot intervene.',
    );
    _requirePlayer(state, actorId);
    final battle = _requireBattle(state);
    _require(
      battle.status == BattleStatus.countdown && battle.endsAt != null,
      GameErrorCode.invalidState,
      'There is no active countdown.',
    );
    _require(
      _clock.now().isBefore(battle.endsAt!),
      GameErrorCode.invalidState,
      'The countdown has already ended.',
    );
    return state.copyWith(
      battle: battle.copyWith(
        status: BattleStatus.intervention,
        endsAt: null,
        intervenedBy: actorId,
      ),
    );
  }

  GameState _requestHelp(GameState state, String actorId) {
    _requireActive(state, actorId);
    final battle = _requireBattle(state);
    _require(
      battle.status == BattleStatus.fighting,
      GameErrorCode.invalidState,
      'Help cannot be requested now.',
    );
    return state.copyWith(
      battle: battle.copyWith(status: BattleStatus.helpRequested),
    );
  }

  GameState _resumeBattle(GameState state, String actorId) {
    _requireActive(state, actorId);
    _requireNoPendingDiceAppeal(state);
    final battle = _requireBattle(state);
    _require(
      const {
        BattleStatus.intervention,
        BattleStatus.helpRequested,
        BattleStatus.escaping,
      }.contains(battle.status),
      GameErrorCode.invalidState,
      'Battle cannot be resumed now.',
    );
    return state.copyWith(
      battle: battle.copyWith(
        status: BattleStatus.fighting,
        endsAt: null,
        intervenedBy: null,
      ),
    );
  }

  GameState _startEscape(GameState state, String actorId) {
    _requireActive(state, actorId);
    final battle = _requireBattle(state);
    _require(
      battle.status == BattleStatus.fighting ||
          battle.status == BattleStatus.helpRequested,
      GameErrorCode.invalidState,
      'Escape cannot start now.',
    );
    return state.copyWith(
      battle: battle.copyWith(status: BattleStatus.escaping),
      lastDiceRoll: null,
      diceAppeal: null,
    );
  }

  GameState _resolveEscape(GameState state, String actorId) {
    _requireActive(state, actorId);
    final battle = _requireBattle(state);
    _require(
      battle.status == BattleStatus.escaping,
      GameErrorCode.invalidState,
      'The player is not escaping.',
    );
    _requireNoPendingDiceAppeal(state);
    return state.copyWith(
      battle: battle.copyWith(status: BattleStatus.endedWithoutVictory),
      lastDiceRoll: state.lastDiceRoll?.copyWith(finalized: true),
    );
  }

  GameState _raiseLevel(GameState state, String actorId) {
    _requireActive(state, actorId);
    final battle = _requireBattle(state);
    _require(
      battle.status == BattleStatus.won,
      GameErrorCode.invalidState,
      'The battle has not been won.',
    );
    _require(
      !battle.levelRewardClaimed,
      GameErrorCode.invalidState,
      'The victory level was already claimed.',
    );
    final index = state.players.indexWhere((player) => player.id == actorId);
    final players = [...state.players];
    final player = players[index];
    if (player.level < state.settings.maxLevel) {
      final level = player.level + 1;
      players[index] = player.copyWith(
        level: level,
        peakLevel: level > player.peakLevel ? level : player.peakLevel,
      );
    }
    return state.copyWith(
      players: players,
      battle: battle.copyWith(levelRewardClaimed: true),
    );
  }

  GameState _finishBattle(GameState state, String actorId) {
    _requireActive(state, actorId);
    final battle = _requireBattle(state);
    _require(
      battle.status == BattleStatus.won ||
          battle.status == BattleStatus.endedWithoutVictory,
      GameErrorCode.invalidState,
      'Resolve the battle first.',
    );
    _requireNoPendingDiceAppeal(state);
    return state.copyWith(battle: null, lastDiceRoll: null, diceAppeal: null);
  }

  GameState _rollDice(GameState state, String actorId) {
    _requireActive(state, actorId);
    _require(
      state.phase == RoomPhase.playing,
      GameErrorCode.invalidState,
      'The game has not started.',
    );
    _require(
      state.settings.diceMode == DiceMode.virtual,
      GameErrorCode.invalidState,
      'The room uses a physical die.',
    );
    _requireNoPendingDiceAppeal(state);
    _requireDiceAttemptAvailable(state);
    final value = _random.nextInt(6) + 1;
    return state.copyWith(
      lastDiceRoll: DiceRoll(
        id: '${state.roomId}-${state.revision + 1}',
        playerId: actorId,
        value: value,
        originalValue: value,
        source: DiceRollSource.virtual,
        rolledAt: _clock.now(),
      ),
      diceAppeal: null,
    );
  }

  GameState _recordPhysicalRoll(GameState state, String actorId, int value) {
    _requireActive(state, actorId);
    _require(
      state.phase == RoomPhase.playing &&
          state.settings.diceMode == DiceMode.physical,
      GameErrorCode.invalidState,
      'The room does not use a physical die.',
    );
    _validateDiceValue(value);
    _requireNoPendingDiceAppeal(state);
    _requireDiceAttemptAvailable(state);
    return state.copyWith(
      lastDiceRoll: DiceRoll(
        id: '${state.roomId}-${state.revision + 1}',
        playerId: actorId,
        value: value,
        originalValue: value,
        source: DiceRollSource.physical,
        rolledAt: _clock.now(),
      ),
      diceAppeal: null,
    );
  }

  GameState _useCheatDie(GameState state, String actorId, int value) {
    _requireActive(state, actorId);
    _validateDiceValue(value);
    _requireNoPendingDiceAppeal(state);
    final roll = state.lastDiceRoll;
    _require(
      roll != null && roll.playerId == actorId,
      GameErrorCode.invalidState,
      'Roll the die before using the cheat die.',
    );
    _require(
      roll!.cheatedBy == null,
      GameErrorCode.invalidState,
      'The cheat die was already used for this roll.',
    );
    _require(
      !roll.finalized,
      GameErrorCode.invalidState,
      'This die result is already final.',
    );
    return state.copyWith(
      lastDiceRoll: roll.copyWith(value: value, cheatedBy: actorId),
      diceAppeal: null,
    );
  }

  GameState _appealCheatDie(GameState state, String actorId) {
    _requirePlayer(state, actorId);
    final roll = state.lastDiceRoll;
    _require(
      roll?.cheatedBy != null,
      GameErrorCode.invalidState,
      'There is no cheat die result to appeal.',
    );
    _require(
      !roll!.finalized,
      GameErrorCode.invalidState,
      'This die result is already final.',
    );
    _require(
      roll.cheatedBy != actorId,
      GameErrorCode.forbidden,
      'You cannot appeal your own cheat die.',
    );
    _require(
      state.diceAppeal == null,
      GameErrorCode.invalidState,
      'This cheat die has already been appealed.',
    );
    return state.copyWith(
      diceAppeal: DiceAppeal(rollId: roll.id, requestedBy: actorId),
    );
  }

  GameState _resolveDiceAppeal(GameState state, String actorId, bool accepted) {
    _requireHost(state, actorId);
    final appeal = state.diceAppeal;
    final roll = state.lastDiceRoll;
    _require(
      appeal?.status == DiceAppealStatus.pending &&
          roll != null &&
          appeal!.rollId == roll.id,
      GameErrorCode.invalidState,
      'There is no pending dice appeal.',
    );
    return state.copyWith(
      lastDiceRoll: accepted ? roll!.copyWith(value: roll.originalValue) : roll,
      diceAppeal: appeal!.copyWith(
        status: accepted
            ? DiceAppealStatus.accepted
            : DiceAppealStatus.rejected,
        resolvedBy: actorId,
      ),
    );
  }

  GameState _removePlayer(GameState state, String actorId, String playerId) {
    _requireHost(state, actorId);
    return _removePlayerCore(state, playerId);
  }

  GameState _offerControl(
    GameState state,
    String actorId,
    String playerId,
    String controllerPlayerId,
  ) {
    _requireHost(state, actorId);
    _require(
      state.phase == RoomPhase.playing,
      GameErrorCode.invalidState,
      'Player control can only be assigned during a game.',
    );
    final player = _requirePlayer(state, playerId);
    final controller = _requirePlayer(state, controllerPlayerId);
    _require(
      !player.isHost && !player.isConnected,
      GameErrorCode.invalidState,
      'Only an offline non-host player can be assigned.',
    );
    _require(
      controller.isConnected && controllerPlayerId != playerId,
      GameErrorCode.invalidState,
      'The destination device is not connected.',
    );
    _require(
      state.assignmentFor(playerId) == null,
      GameErrorCode.invalidState,
      'This player already has a pending or active assignment.',
    );
    return state.copyWith(
      controlAssignments: <ControlAssignment>[
        ...state.controlAssignments,
        ControlAssignment(
          playerId: playerId,
          controllerPlayerId: controllerPlayerId,
        ),
      ],
    );
  }

  GameState _respondControl(
    GameState state,
    String actorId,
    String playerId,
    bool accepted,
  ) {
    final assignment = state.assignmentFor(playerId);
    _require(
      assignment != null &&
          assignment.status == ControlAssignmentStatus.pending,
      GameErrorCode.invalidState,
      'There is no pending control request.',
    );
    _require(
      assignment!.controllerPlayerId == actorId,
      GameErrorCode.forbidden,
      'Only the destination device can answer this request.',
    );
    if (!accepted) {
      return state.copyWith(
        controlAssignments: state.controlAssignments
            .where((value) => value.playerId != playerId)
            .toList(growable: false),
      );
    }
    final player = _requirePlayer(state, playerId);
    final controller = _requirePlayer(state, actorId);
    _require(
      !player.isConnected && controller.isConnected,
      GameErrorCode.invalidState,
      'The assignment is no longer available.',
    );
    return state.copyWith(
      controlAssignments: state.controlAssignments
          .map(
            (value) => value.playerId == playerId
                ? value.copyWith(status: ControlAssignmentStatus.active)
                : value,
          )
          .toList(growable: false),
    );
  }

  GameState _revokeControl(GameState state, String actorId, String playerId) {
    _requireHost(state, actorId);
    _require(
      state.assignmentFor(playerId) != null,
      GameErrorCode.invalidState,
      'This player is not assigned.',
    );
    return state.copyWith(
      controlAssignments: state.controlAssignments
          .where((value) => value.playerId != playerId)
          .toList(growable: false),
    );
  }

  GameState _leaveRoom(GameState state, String actorId) {
    final player = _requirePlayer(state, actorId);
    _require(
      !player.isHost,
      GameErrorCode.forbidden,
      'The host must end the game instead of leaving.',
    );
    return _removePlayerCore(state, actorId);
  }

  GameState _removePlayerCore(GameState state, String playerId) {
    final removed = _requirePlayer(state, playerId);
    _require(
      !removed.isHost,
      GameErrorCode.forbidden,
      'The host must end the game instead of leaving.',
    );
    final players = state.players
        .where((player) => player.id != playerId)
        .toList();
    final order = state.turnOrder.where((id) => id != playerId).toList();
    var active = state.activePlayerId;
    BattleState? battle = state.battle;
    if (active == playerId) {
      battle = null;
      if (order.isEmpty) {
        active = null;
      } else {
        final oldIndex = state.turnOrder.indexOf(playerId);
        active = order[oldIndex % order.length];
      }
    }
    return state.copyWith(
      players: players,
      turnOrder: order,
      controlAssignments: state.controlAssignments
          .where(
            (assignment) =>
                assignment.playerId != playerId &&
                assignment.controllerPlayerId != playerId,
          )
          .toList(growable: false),
      activePlayerId: active,
      battleStartedThisTurn: active == state.activePlayerId
          ? state.battleStartedThisTurn
          : false,
      battle: battle,
      lastDiceRoll: removed.id == state.activePlayerId
          ? null
          : state.lastDiceRoll,
      diceAppeal: removed.id == state.activePlayerId ? null : state.diceAppeal,
    );
  }

  GameState _endGame(GameState state, String actorId) {
    _requireHost(state, actorId);
    return state.copyWith(
      phase: RoomPhase.ended,
      battle: null,
      activePlayerId: null,
      lastDiceRoll: null,
      diceAppeal: null,
      controlAssignments: const <ControlAssignment>[],
      endedAt: _clock.now(),
    );
  }

  void _requireDiceAttemptAvailable(GameState state) {
    if (state.battle?.status == BattleStatus.escaping) {
      _require(
        state.lastDiceRoll == null,
        GameErrorCode.invalidState,
        'The escape die was already rolled.',
      );
    }
  }

  void _requireNoPendingDiceAppeal(GameState state) {
    _require(
      state.diceAppeal?.status != DiceAppealStatus.pending,
      GameErrorCode.invalidState,
      'The host must resolve the dice appeal first.',
    );
  }

  void _validateDiceValue(int value) {
    _require(
      value >= 1 && value <= 6,
      GameErrorCode.invalidValue,
      'A D6 result must be between 1 and 6.',
    );
  }

  void _validatePlayerName(String name) {
    _require(
      name.isNotEmpty && name.length <= 24,
      GameErrorCode.invalidValue,
      'Name must contain 1 to 24 characters.',
    );
  }

  void _validateSettings(RoomSettings settings) {
    _require(
      settings.minLevel >= 1 &&
          settings.maxLevel <= 999 &&
          settings.minLevel <= settings.initialLevel &&
          settings.initialLevel <= settings.maxLevel,
      GameErrorCode.invalidValue,
      'Invalid level limits.',
    );
    _require(
      settings.minStrength >= -999 &&
          settings.maxStrength <= 999 &&
          settings.minStrength <= settings.initialStrength &&
          settings.initialStrength <= settings.maxStrength,
      GameErrorCode.invalidValue,
      'Invalid strength limits.',
    );
    _require(
      settings.victoryCountdownSeconds >= 3 &&
          settings.victoryCountdownSeconds <= 60,
      GameErrorCode.invalidValue,
      'Countdown must be between 3 and 60 seconds.',
    );
  }

  GameState _commit(GameState state) =>
      state.copyWith(revision: state.revision + 1, updatedAt: _clock.now());

  Player _requirePlayer(GameState state, String id) {
    final player = state.playerById(id);
    _require(
      player != null,
      GameErrorCode.playerNotFound,
      'Player was not found.',
    );
    return player!;
  }

  void _requireHost(GameState state, String actorId) {
    final player = _requirePlayer(state, actorId);
    _require(
      player.isHost,
      GameErrorCode.forbidden,
      'Only the host can do this.',
    );
  }

  void _requireActive(GameState state, String actorId) {
    _require(
      state.activePlayerId == actorId,
      GameErrorCode.forbidden,
      'Only the active player can do this.',
    );
  }

  BattleState _requireBattle(GameState state) {
    final battle = state.battle;
    _require(
      battle != null,
      GameErrorCode.invalidState,
      'There is no active battle.',
    );
    return battle!;
  }

  String _normalizeName(String value) =>
      value.trim().replaceAll(RegExp(r'\s+'), ' ');

  void _require(bool condition, GameErrorCode code, String message) {
    if (!condition) throw _RuleViolation(code, message);
  }
}

class _RuleViolation implements Exception {
  const _RuleViolation(this.code, this.message);

  final GameErrorCode code;
  final String message;
}
