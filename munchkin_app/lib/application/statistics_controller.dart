import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/storage/statistics_store.dart';
import '../domain/models/game_models.dart';

final statisticsStoreProvider = Provider<StatisticsStore>(
  (ref) => JsonFileStatisticsStore(),
);

final statisticsControllerProvider =
    AsyncNotifierProvider<StatisticsController, StatisticsData>(
      StatisticsController.new,
    );

class ProfileStatistics {
  const ProfileStatistics({
    required this.gamesPlayed,
    required this.wins,
    required this.maxLevel,
    required this.averageDuration,
  });

  final int gamesPlayed;
  final int wins;
  final int maxLevel;
  final Duration averageDuration;
}

class StatisticsController extends AsyncNotifier<StatisticsData> {
  static const _uuid = Uuid();

  StatisticsStore get _store => ref.read(statisticsStoreProvider);

  @override
  Future<StatisticsData> build() async {
    final loaded = await _store.load();
    final history = _limitHistory(loaded.history);
    if (history.length == loaded.history.length) return loaded;
    final trimmed = StatisticsData(
      profiles: loaded.profiles,
      history: history,
      activeProfileId: loaded.activeProfileId,
    );
    await _store.save(trimmed);
    return trimmed;
  }

  Future<UserProfile> ensureProfile(String name, {String? preferredId}) async {
    final current = await future;
    UserProfile? profile;
    for (final candidate in current.profiles) {
      if ((preferredId != null && candidate.id == preferredId) ||
          candidate.name.toLowerCase() == name.trim().toLowerCase()) {
        profile = candidate;
        break;
      }
    }
    profile ??= UserProfile(
      id: _uuid.v4(),
      name: name.trim(),
      createdAt: DateTime.now().toUtc(),
    );
    final profiles = current.profiles.any((value) => value.id == profile!.id)
        ? current.profiles
        : <UserProfile>[...current.profiles, profile];
    final next = StatisticsData(
      profiles: profiles,
      history: current.history,
      activeProfileId: profile.id,
    );
    await _save(next);
    return profile;
  }

  Future<void> selectProfile(String profileId) async {
    final current = await future;
    if (!current.profiles.any((profile) => profile.id == profileId)) return;
    await _save(
      StatisticsData(
        profiles: current.profiles,
        history: current.history,
        activeProfileId: profileId,
      ),
    );
  }

  Future<void> recordCompletedGame({
    required GameState game,
    required String profileId,
    required String localPlayerId,
  }) async {
    final startedAt = game.startedAt ?? game.createdAt;
    final endedAt = game.endedAt;
    if (endedAt == null) return;
    if (game.playerById(localPlayerId) == null) return;
    final current = await future;
    final id = '${game.roomId}:$profileId';
    if (current.history.any((record) => record.id == id)) return;
    final participants = game.players
        .map(
          (player) => GameParticipantRecord(
            playerId: player.id,
            name: player.name,
            finalLevel: player.level,
            peakLevel: player.peakLevel,
            finalStrength: player.strength,
          ),
        )
        .toList(growable: false);
    final winners = game.players
        .where((player) => player.peakLevel >= game.settings.maxLevel)
        .map((player) => player.id)
        .toList(growable: false);
    final record = GameHistoryRecord(
      id: id,
      roomId: game.roomId,
      localProfileId: profileId,
      localPlayerId: localPlayerId,
      startedAt: startedAt,
      endedAt: endedAt,
      participants: participants,
      winnerPlayerIds: winners,
    );
    final localParticipant = record.localParticipant!;
    final profiles = current.profiles
        .map((profile) {
          if (profile.id != profileId) return profile;
          return profile.copyWith(
            gamesPlayed: profile.gamesPlayed + 1,
            wins: profile.wins + (record.localPlayerWon ? 1 : 0),
            maxLevel: localParticipant.peakLevel > profile.maxLevel
                ? localParticipant.peakLevel
                : profile.maxLevel,
            totalDurationSeconds:
                profile.totalDurationSeconds + record.duration.inSeconds,
          );
        })
        .toList(growable: false);
    await _save(
      StatisticsData(
        profiles: profiles,
        history: _limitHistory(<GameHistoryRecord>[record, ...current.history]),
        activeProfileId: current.activeProfileId,
      ),
    );
  }

  ProfileStatistics statisticsFor(UserProfile profile) {
    final latest =
        state.value?.profiles.firstWhere(
          (candidate) => candidate.id == profile.id,
          orElse: () => profile,
        ) ??
        profile;
    return ProfileStatistics(
      gamesPlayed: latest.gamesPlayed,
      wins: latest.wins,
      maxLevel: latest.maxLevel,
      averageDuration: latest.gamesPlayed == 0
          ? Duration.zero
          : Duration(
              seconds: latest.totalDurationSeconds ~/ latest.gamesPlayed,
            ),
    );
  }

  Future<void> _save(StatisticsData data) async {
    await _store.save(data);
    state = AsyncData(data);
  }

  List<GameHistoryRecord> _limitHistory(List<GameHistoryRecord> history) {
    final counts = <String, int>{};
    return history
        .where((record) {
          final count = counts[record.localProfileId] ?? 0;
          if (count >= 10) return false;
          counts[record.localProfileId] = count + 1;
          return true;
        })
        .toList(growable: false);
  }
}
