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
