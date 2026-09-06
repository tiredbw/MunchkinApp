import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/statistics_controller.dart';
import 'package:munchkin_app/data/storage/statistics_store.dart';
import 'package:munchkin_app/domain/models/game_models.dart';

void main() {
  test(
    'profiles accumulate wins, games, peak level and average duration',
    () async {
      final store = MemoryStatisticsStore();
      final container = ProviderContainer(
        overrides: [statisticsStoreProvider.overrideWithValue(store)],
      );
      addTearDown(container.dispose);
      await container.read(statisticsControllerProvider.future);
      final controller = container.read(statisticsControllerProvider.notifier);
      final profile = await controller.ensureProfile('Alice');

      await controller.recordCompletedGame(
        game: _completedGame(
          roomId: 'room-1',
          duration: const Duration(minutes: 60),
          alicePeakLevel: 10,
        ),
        profileId: profile.id,
        localPlayerId: 'alice',
      );
      await controller.recordCompletedGame(
        game: _completedGame(
          roomId: 'room-2',
          duration: const Duration(minutes: 30),
          alicePeakLevel: 7,
        ),
        profileId: profile.id,
        localPlayerId: 'alice',
      );
      await controller.recordCompletedGame(
        game: _completedGame(
          roomId: 'room-2',
          duration: const Duration(minutes: 30),
          alicePeakLevel: 7,
        ),
        profileId: profile.id,
        localPlayerId: 'alice',
      );

      final stats = controller.statisticsFor(profile);
      expect(stats.gamesPlayed, 2);
      expect(stats.wins, 1);
      expect(stats.maxLevel, 10);
      expect(stats.averageDuration, const Duration(minutes: 45));
      expect(store.value.history, hasLength(2));
    },
  );

  test('statistics JSON round trip preserves profiles and history', () {
    final data = StatisticsData(
      profiles: <UserProfile>[
        UserProfile(
          id: 'profile',
          name: 'Alice',
          createdAt: DateTime.utc(2026, 8, 3),
        ),
      ],
      history: <GameHistoryRecord>[
        GameHistoryRecord(
          id: 'room:profile',
          roomId: 'room',
          localProfileId: 'profile',
          localPlayerId: 'alice',
          startedAt: DateTime.utc(2026, 8, 3, 10),
          endedAt: DateTime.utc(2026, 8, 3, 11),
          participants: const <GameParticipantRecord>[
            GameParticipantRecord(
              playerId: 'alice',
              name: 'Alice',
              finalLevel: 10,
              peakLevel: 10,
              finalStrength: 5,
            ),
          ],
          winnerPlayerIds: const <String>['alice'],
        ),
      ],
      activeProfileId: 'profile',
    );

    final restored = StatisticsData.fromJson(data.toJson());
    expect(restored.activeProfile?.name, 'Alice');
    expect(restored.history.single.localPlayerWon, isTrue);
    expect(restored.history.single.duration, const Duration(hours: 1));
  });

  test('keeps only the ten latest games for each profile', () async {
    final store = MemoryStatisticsStore();
    final container = ProviderContainer(
      overrides: [statisticsStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);
    await container.read(statisticsControllerProvider.future);
    final controller = container.read(statisticsControllerProvider.notifier);
    final profile = await controller.ensureProfile('Alice');

    for (var index = 0; index < 12; index++) {
      await controller.recordCompletedGame(
        game: _completedGame(
          roomId: 'room-$index',
          duration: Duration(minutes: index + 1),
          alicePeakLevel: index == 11 ? 10 : 5,
        ),
        profileId: profile.id,
        localPlayerId: 'alice',
      );
    }

    final records = store.value.history
        .where((record) => record.localProfileId == profile.id)
        .toList(growable: false);
    expect(records, hasLength(10));
    expect(records.first.roomId, 'room-11');
    expect(records.last.roomId, 'room-2');
    expect(records.any((record) => record.roomId == 'room-0'), isFalse);
    expect(records.any((record) => record.roomId == 'room-1'), isFalse);
    final updatedProfile = store.value.profiles.single;
    expect(updatedProfile.gamesPlayed, 12);
    expect(updatedProfile.wins, 1);
  });
}

GameState _completedGame({
  required String roomId,
  required Duration duration,
  required int alicePeakLevel,
}) {
  final started = DateTime.utc(2026, 8, 3, 10);
  return GameState(
    roomId: roomId,
    settings: const RoomSettings(),
    phase: RoomPhase.ended,
    players: <Player>[
      Player(
        id: 'alice',
        name: 'Alice',
        isHost: false,
        level: alicePeakLevel,
        peakLevel: alicePeakLevel,
        strength: 5,
      ),
      const Player(
        id: 'bob',
        name: 'Bob',
        isHost: true,
        level: 5,
        peakLevel: 5,
        strength: 3,
      ),
    ],
    startedAt: started,
    endedAt: started.add(duration),
    createdAt: started.subtract(const Duration(minutes: 5)),
    updatedAt: started.add(duration),
  );
}
