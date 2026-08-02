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

  GameState addPlayer(String id, String name) {
    final result = engine.addPlayer(state, playerId: id, name: name);
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

  test('normalizes names and rejects duplicates case-insensitively', () {
    addPlayer('p2', '  Alice  ');
    final result = engine.addPlayer(state, playerId: 'p3', name: 'alice');
    expect(state.playerById('p2')?.name, 'Alice');
    expect(result, isA<GameRejected>());
    expect((result as GameRejected).code, GameErrorCode.duplicateName);
  });

  test('only host can prepare and start a game', () {
    addPlayer('p2', 'Alice');
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

  test('players adjust strength but only host adjusts levels', () {
    addPlayer('p2', 'Alice');
    accept(const GameCommand.adjustStats(strengthDelta: 5), 'p2');
    expect(state.playerById('p2')?.strength, 5);
    expect(state.playerById('host')?.strength, 0);

    final rejected = engine.apply(
      state,
      const GameCommand.adjustPlayerLevel(playerId: 'p2', delta: 1),
      actorId: 'p2',
    );
    expect(rejected, isA<GameRejected>());
    accept(
      const GameCommand.adjustPlayerLevel(playerId: 'p2', delta: 1),
      'host',
    );
    expect(state.playerById('p2')?.level, 2);
  });

  test('turns cycle and only the active player can end a turn', () {
    addPlayer('p2', 'Alice');
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

  test('first intervention stops the countdown and late one is rejected', () {
    addPlayer('p2', 'Alice');
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

  test('virtual die is host generated and restricted to active player', () {
    addPlayer('p2', 'Alice');
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

  test('removing the active player cancels battle and advances turn', () {
    addPlayer('p2', 'Alice');
    addPlayer('p3', 'Bob');
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
      addPlayer('p2', 'Alice');
      final disconnected = engine.setPlayerConnection(
        state,
        playerId: 'p2',
        connected: false,
      );
      expect(disconnected, isA<GameAccepted>());
      state = (disconnected as GameAccepted).state;
      expect(state.playerById('p2')?.isConnected, isFalse);
      accept(const GameCommand.leaveRoom(), 'p2');
      expect(state.playerById('p2'), isNull);
    },
  );

  test('victory level can only be claimed once', () {
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.startBattle(), 'host');
    accept(const GameCommand.declareVictory(), 'host');
    clock.advance(const Duration(seconds: 5));
    state = engine.resolveExpiredTimers(state);
    accept(const GameCommand.raiseLevel(), 'host');
    expect(state.playerById('host')?.level, 2);
    expect(state.battle?.levelRewardClaimed, isTrue);
    expect(
      engine.apply(state, const GameCommand.raiseLevel(), actorId: 'host'),
      isA<GameRejected>(),
    );
  });

  test('cheat die can be appealed and restored by host', () {
    addPlayer('p2', 'Alice');
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.rollDice(), 'host');
    accept(const GameCommand.useCheatDie(6), 'host');
    accept(const GameCommand.appealCheatDie(), 'p2');
    expect(state.diceAppeal?.status, DiceAppealStatus.pending);
    expect(
      engine.apply(state, const GameCommand.startBattle(), actorId: 'host'),
      isA<GameRejected>(),
    );
    expect(
      engine.apply(
        state,
        const GameCommand.resolveDiceAppeal(true),
        actorId: 'p2',
      ),
      isA<GameRejected>(),
    );
    accept(const GameCommand.resolveDiceAppeal(true), 'host');
    expect(state.lastDiceRoll?.value, 1);
    expect(state.diceAppeal?.status, DiceAppealStatus.accepted);
  });

  test('escape allows one roll and blocks resolution during an appeal', () {
    addPlayer('p2', 'Alice');
    accept(const GameCommand.closeLobby(), 'host');
    accept(const GameCommand.confirmOrder(), 'host');
    accept(const GameCommand.startGame(), 'host');
    accept(const GameCommand.startBattle(), 'host');
    accept(const GameCommand.startEscape(), 'host');
    accept(const GameCommand.rollDice(), 'host');
    expect(
      engine.apply(state, const GameCommand.rollDice(), actorId: 'host'),
      isA<GameRejected>(),
    );
    accept(const GameCommand.useCheatDie(6), 'host');
    accept(const GameCommand.appealCheatDie(), 'p2');
    expect(
      engine.apply(state, const GameCommand.resolveEscape(), actorId: 'host'),
      isA<GameRejected>(),
    );
    expect(
      engine.apply(state, const GameCommand.resumeBattle(), actorId: 'host'),
      isA<GameRejected>(),
    );
  });

  test('commands are rejected after the game ends', () {
    accept(const GameCommand.endGame(), 'host');
    expect(
      engine.apply(
        state,
        const GameCommand.adjustStats(strengthDelta: 1),
        actorId: 'host',
      ),
      isA<GameRejected>(),
    );
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
