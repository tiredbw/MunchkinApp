import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/core/clock.dart';
import 'package:munchkin_app/domain/commands/game_command.dart';
import 'package:munchkin_app/domain/game_engine.dart';
import 'package:munchkin_app/domain/models/game_models.dart';

void main() {
  late FakeClock clock;
  late FakeRandom random;
  late GameEngine engine;
  late GameState state;

  setUp(() {
    clock = FakeClock(DateTime.utc(2026, 8, 1, 12));
    random = FakeRandom(<int>[0, 4, 1, 0]);
    engine = GameEngine(clock: clock, random: random);
    state = engine.createRoom(
      roomId: 'room',
      hostPlayerId: 'host',
      hostName: 'Host',
    );
  });

  GameState accept(GameCommand command, String actor) {
    final result = engine.apply(state, command, actorId: actor);
    expect(result, isA<GameAccepted>());
    state = (result as GameAccepted).state;
    return state;
  }

  test('creates a room with a host and computed total power', () {
    expect(state.phase, RoomPhase.lobby);
    expect(state.players.single.isHost, isTrue);
    expect(state.players.single.totalPower, 1);
    expect(state.revision, 0);
  });

  test('sets multiple races and classes for the acting player', () {
    accept(
      const GameCommand.setIdentity(
        races: <MunchkinRace>[MunchkinRace.dwarf, MunchkinRace.elf],
        classes: <MunchkinClass>[MunchkinClass.warrior, MunchkinClass.wizard],
      ),
      'host',
    );
    final player = state.playerById('host')!;
    expect(player.races, <MunchkinRace>[MunchkinRace.dwarf, MunchkinRace.elf]);
    expect(player.classes, <MunchkinClass>[
      MunchkinClass.warrior,
      MunchkinClass.wizard,
    ]);
  });

  test('rejects an empty race list', () {
    final result = engine.apply(
      state,
      const GameCommand.setIdentity(
        races: <MunchkinRace>[],
        classes: <MunchkinClass>[],
      ),
      actorId: 'host',
    );
    expect(result, isA<GameRejected>());
    expect((result as GameRejected).code, GameErrorCode.invalidValue);
  });

  test('rejects setting identity when the room disabled tracking it', () {
    state = engine.createRoom(
      roomId: 'room',
      hostPlayerId: 'host',
      hostName: 'Host',
      settings: const RoomSettings(trackRaceClass: false),
    );
    final result = engine.apply(
      state,
      const GameCommand.setIdentity(
        races: <MunchkinRace>[MunchkinRace.elf],
        classes: <MunchkinClass>[MunchkinClass.thief],
      ),
      actorId: 'host',
    );
    expect(result, isA<GameRejected>());
    expect((result as GameRejected).code, GameErrorCode.invalidState);
  });

  test(
    'dying in battle after a failed escape resets to the room minimum level',
    () {
      accept(const GameCommand.closeLobby(), 'host');
      accept(const GameCommand.confirmOrder(), 'host');
      accept(const GameCommand.startGame(), 'host');
      accept(const GameCommand.adjustStats(levelDelta: 1), 'host');
      accept(const GameCommand.adjustStats(levelDelta: 1), 'host');
      expect(state.playerById('host')!.level, 3);
      accept(const GameCommand.startBattle(), 'host');
      accept(const GameCommand.startEscape(), 'host');
      accept(const GameCommand.resolveEscape(), 'host');
      expect(state.battle?.status, BattleStatus.endedWithoutVictory);
      accept(const GameCommand.dieInBattle(), 'host');
      expect(state.playerById('host')!.level, state.settings.minLevel);
      expect(state.battle, isNull);
      // The historical peak level survives death, matching statistics'
      // "maximum level reached" semantics.
      expect(state.playerById('host')!.peakLevel, 3);
    },
  );

  test('normalizes names and rejects duplicates case-insensitively', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: '  Alice  '),
      'system',
    );
    final result = engine.apply(
      state,
      const GameCommand.joinPlayer(playerId: 'p3', name: 'alice'),
      actorId: 'system',
    );
    expect(state.playerById('p2')?.name, 'Alice');
    expect(result, isA<GameRejected>());
    expect((result as GameRejected).code, GameErrorCode.duplicateName);
  });

  test('only host can prepare and start a game', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    final forbidden = engine.apply(
      state,
      const GameCommand.closeLobby(),
      actorId: 'p2',
    );
    expect(forbidden, isA<GameRejected>());

    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    expect(state.activePlayerId, 'host');
    expect(state.phase, RoomPhase.playing);
  });

  test('players can only adjust their own values within configured limits', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.adjustStats(strengthDelta: 5), 'p2');
    expect(state.playerById('p2')?.strength, 5);
    expect(state.playerById('host')?.strength, 0);

    final rejected = engine.apply(
      state,
      const GameCommand.adjustStats(levelDelta: -1),
      actorId: 'p2',
    );
    expect(rejected, isA<GameRejected>());
  });

  test('turns cycle and only the active player can end a turn', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    expect(
      engine.apply(state, const GameCommand.endTurn(), actorId: 'p2'),
      isA<GameRejected>(),
    );
    accept(const GameCommand.endTurn(), 'host');
    expect(state.activePlayerId, 'p2');
    accept(const GameCommand.endTurn(), 'p2');
    expect(state.activePlayerId, 'host');
  });

  test('battleFoughtThisTurn tracks fights and resets on end turn', () {
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    expect(state.battleFoughtThisTurn, isFalse);
    accept(const GameCommand.startBattle(), 'host');
    expect(state.battleFoughtThisTurn, isTrue);
    accept(const GameCommand.startEscape(), 'host');
    accept(const GameCommand.resolveEscape(), 'host');
    accept(const GameCommand.finishBattle(), 'host');
    expect(state.battleFoughtThisTurn, isTrue);
    accept(const GameCommand.endTurn(), 'host');
    expect(state.battleFoughtThisTurn, isFalse);
  });

  test(
    'opening a door is tracked and reset per turn; starting a battle counts as one',
    () {
      accept(const GameCommand.closeLobby(), 'host');
      accept(const GameCommand.confirmOrder(), 'host');
      accept(const GameCommand.startGame(), 'host');
      expect(state.doorOpenedThisTurn, isFalse);
      accept(const GameCommand.openDoor(), 'host');
      expect(state.doorOpenedThisTurn, isTrue);
      accept(const GameCommand.endTurn(), 'host');
      expect(state.doorOpenedThisTurn, isFalse);

      accept(const GameCommand.startBattle(), 'host');
      expect(state.doorOpenedThisTurn, isTrue);
    },
  );

  test('first intervention stops the countdown and late one is rejected', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.startBattle(), 'host');
    accept(const GameCommand.declareVictory(), 'host');
    expect(state.battle?.status, BattleStatus.countdown);
    accept(const GameCommand.intervene(), 'p2');
    expect(state.battle?.status, BattleStatus.intervention);
    expect(
      engine.apply(state, const GameCommand.intervene(), actorId: 'p2'),
      isA<GameRejected>(),
    );
  });

  test('host clock resolves a victory countdown', () {
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.startBattle(), 'host');
    accept(const GameCommand.declareVictory(), 'host');
    clock.advance(const Duration(seconds: 5));
    state = engine.resolveExpiredTimers(state);
    expect(state.battle?.status, BattleStatus.won);
  });

  test(
    'reaching the room max level by winning a battle records the winner',
    () {
      state = engine.createRoom(
        roomId: 'room2',
        hostPlayerId: 'host',
        hostName: 'Host',
        settings: const RoomSettings(maxLevel: 2, initialLevel: 1),
      );
      accept(const GameCommand.closeLobby(), 'host');
      accept(const GameCommand.confirmOrder(), 'host');
      accept(const GameCommand.startGame(), 'host');
      accept(const GameCommand.startBattle(), 'host');
      accept(const GameCommand.declareVictory(), 'host');
      clock.advance(const Duration(seconds: 5));
      state = engine.resolveExpiredTimers(state);
      expect(state.winnerPlayerId, isNull);
      accept(const GameCommand.raiseLevel(), 'host');
      expect(state.playerById('host')?.level, 2);
      expect(state.winnerPlayerId, 'host');
    },
  );

  test('removing the winner clears the dangling winnerPlayerId reference', () {
    state = engine.createRoom(
      roomId: 'room3',
      hostPlayerId: 'host',
      hostName: 'Host',
      settings: const RoomSettings(maxLevel: 2, initialLevel: 1),
    );
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.endTurn(), 'host');
    accept(const GameCommand.startBattle(), 'p2');
    accept(const GameCommand.declareVictory(), 'p2');
    clock.advance(const Duration(seconds: 5));
    state = engine.resolveExpiredTimers(state);
    accept(const GameCommand.raiseLevel(), 'p2');
    expect(state.winnerPlayerId, 'p2');

    accept(const GameCommand.removePlayer('p2'), 'host');
    expect(state.winnerPlayerId, isNull);
  });

  test('virtual die is host generated and restricted to active player', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.rollDice(), 'host');
    expect(state.lastDiceRoll?.value, 1);
    expect(
      engine.apply(state, const GameCommand.rollDice(), actorId: 'p2'),
      isA<GameRejected>(),
    );
  });

  test('removing the intervening player clears the dangling reference', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.joinPlayer(playerId: 'p3', name: 'Bob'), 'system');
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.startBattle(), 'host');
    accept(const GameCommand.declareVictory(), 'host');
    accept(const GameCommand.intervene(), 'p2');
    expect(state.battle?.intervenedBy, 'p2');
    accept(const GameCommand.removePlayer('p2'), 'host');
    expect(state.battle, isNotNull);
    expect(state.battle?.intervenedBy, isNull);
  });

  test('removing the active player cancels battle and advances turn', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.joinPlayer(playerId: 'p3', name: 'Bob'), 'system');
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.endTurn(), 'host');
    accept(const GameCommand.startBattle(), 'p2');
    accept(const GameCommand.removePlayer('p2'), 'host');
    expect(state.battle, isNull);
    expect(state.activePlayerId, 'p3');
  });

  test(
    'explicit leave removes a client but a disconnect only marks it offline',
    () {
      accept(
        const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
        'system',
      );
      accept(
        const GameCommand.setConnection(playerId: 'p2', connected: false),
        'system',
      );
      expect(state.playerById('p2')?.isConnected, isFalse);
      accept(const GameCommand.leaveRoom(), 'p2');
      expect(state.playerById('p2'), isNull);
    },
  );

  test('a connected player can add a local player controlled by them', () {
    accept(const GameCommand.addLocalPlayer(name: 'Sidekick'), 'host');
    final local = state.players.singleWhere((p) => p.id != 'host');
    expect(local.name, 'Sidekick');
    expect(local.isLocal, isTrue);
    expect(local.localControllerPlayerId, 'host');
    expect(local.isConnected, isFalse);
    expect(
      state.controlledPlayerIds('host'),
      containsAll(<String>['host', local.id]),
    );
  });

  test('an offline player cannot add a local player', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(
      const GameCommand.setConnection(playerId: 'p2', connected: false),
      'system',
    );
    final result = engine.apply(
      state,
      const GameCommand.addLocalPlayer(name: 'Ghost'),
      actorId: 'p2',
    );
    expect(result, isA<GameRejected>());
    expect((result as GameRejected).code, GameErrorCode.forbidden);
  });

  test('a local player can act once its controller is used as actor', () {
    accept(const GameCommand.addLocalPlayer(name: 'Sidekick'), 'host');
    final local = state.players.singleWhere((p) => p.id != 'host');
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    // Turn order is [host, local]; end host's turn so the local player acts.
    accept(const GameCommand.endTurn(), 'host');
    expect(state.activePlayerId, local.id);
    accept(const GameCommand.startBattle(), local.id);
    expect(state.battle?.playerId, local.id);
  });

  test('removing a player cascades to the local players they own', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.addLocalPlayer(name: 'Sidekick'), 'p2');
    final local = state.players.singleWhere((p) => p.id != 'host' && p.id != 'p2');
    accept(const GameCommand.removePlayer('p2'), 'host');
    expect(state.playerById('p2'), isNull);
    expect(state.playerById(local.id), isNull);
  });

  test('the owning device can remove its own local player', () {
    accept(
      const GameCommand.joinPlayer(playerId: 'p2', name: 'Alice'),
      'system',
    );
    accept(const GameCommand.addLocalPlayer(name: 'Sidekick'), 'p2');
    final local = state.players.singleWhere((p) => p.id != 'host' && p.id != 'p2');
    accept(GameCommand.removePlayer(local.id), 'p2');
    expect(state.playerById(local.id), isNull);
  });
}

class FakeClock implements Clock {
  FakeClock(this.value);

  DateTime value;

  void advance(Duration duration) => value = value.add(duration);

  @override
  DateTime now() => value;
}

class FakeRandom implements RandomSource {
  FakeRandom(this.values);

  final List<int> values;
  var index = 0;

  @override
  int nextInt(int max) {
    final value = values[index++ % values.length];
    return value % max;
  }
}
