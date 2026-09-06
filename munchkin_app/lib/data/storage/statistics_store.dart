import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.createdAt,
    this.gamesPlayed = 0,
    this.wins = 0,
    this.maxLevel = 0,
    this.totalDurationSeconds = 0,
  });

  final String id;
  final String name;
  final DateTime createdAt;
  final int gamesPlayed;
  final int wins;
  final int maxLevel;
  final int totalDurationSeconds;

  UserProfile copyWith({
    int? gamesPlayed,
    int? wins,
    int? maxLevel,
    int? totalDurationSeconds,
  }) => UserProfile(
    id: id,
    name: name,
    createdAt: createdAt,
    gamesPlayed: gamesPlayed ?? this.gamesPlayed,
    wins: wins ?? this.wins,
    maxLevel: maxLevel ?? this.maxLevel,
    totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
  );

  Map<String, Object?> toJson() => <String, Object?>{
    'id': id,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'gamesPlayed': gamesPlayed,
    'wins': wins,
    'maxLevel': maxLevel,
    'totalDurationSeconds': totalDurationSeconds,
  };

  factory UserProfile.fromJson(Map<String, Object?> json) => UserProfile(
    id: json['id'] as String,
    name: json['name'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    gamesPlayed: json['gamesPlayed'] as int? ?? 0,
    wins: json['wins'] as int? ?? 0,
    maxLevel: json['maxLevel'] as int? ?? 0,
    totalDurationSeconds: json['totalDurationSeconds'] as int? ?? 0,
  );
}

class GameParticipantRecord {
  const GameParticipantRecord({
    required this.playerId,
    required this.name,
    required this.finalLevel,
    required this.peakLevel,
    required this.finalStrength,
  });

  final String playerId;
  final String name;
  final int finalLevel;
  final int peakLevel;
  final int finalStrength;

  Map<String, Object?> toJson() => <String, Object?>{
    'playerId': playerId,
    'name': name,
    'finalLevel': finalLevel,
    'peakLevel': peakLevel,
    'finalStrength': finalStrength,
  };

  factory GameParticipantRecord.fromJson(Map<String, Object?> json) =>
      GameParticipantRecord(
        playerId: json['playerId'] as String,
        name: json['name'] as String,
        finalLevel: json['finalLevel'] as int,
        peakLevel: json['peakLevel'] as int? ?? json['finalLevel'] as int,
        finalStrength: json['finalStrength'] as int,
      );
}

class GameHistoryRecord {
  const GameHistoryRecord({
    required this.id,
    required this.roomId,
    required this.localProfileId,
    required this.localPlayerId,
    required this.startedAt,
    required this.endedAt,
    required this.participants,
    required this.winnerPlayerIds,
  });

  final String id;
  final String roomId;
  final String localProfileId;
  final String localPlayerId;
  final DateTime startedAt;
  final DateTime endedAt;
  final List<GameParticipantRecord> participants;
  final List<String> winnerPlayerIds;

  Duration get duration => endedAt.difference(startedAt);
  bool get localPlayerWon => winnerPlayerIds.contains(localPlayerId);

  GameParticipantRecord? get localParticipant {
    for (final participant in participants) {
      if (participant.playerId == localPlayerId) return participant;
    }
    return null;
  }

  List<String> get winnerNames => participants
      .where((participant) => winnerPlayerIds.contains(participant.playerId))
      .map((participant) => participant.name)
      .toList(growable: false);

  Map<String, Object?> toJson() => <String, Object?>{
    'id': id,
    'roomId': roomId,
    'localProfileId': localProfileId,
    'localPlayerId': localPlayerId,
    'startedAt': startedAt.toIso8601String(),
    'endedAt': endedAt.toIso8601String(),
    'participants': participants.map((value) => value.toJson()).toList(),
    'winnerPlayerIds': winnerPlayerIds,
  };

  factory GameHistoryRecord.fromJson(
    Map<String, Object?> json,
  ) => GameHistoryRecord(
    id: json['id'] as String,
    roomId: json['roomId'] as String,
    localProfileId: json['localProfileId'] as String,
    localPlayerId: json['localPlayerId'] as String,
    startedAt: DateTime.parse(json['startedAt'] as String),
    endedAt: DateTime.parse(json['endedAt'] as String),
    participants: (json['participants'] as List<Object?>)
        .map(
          (value) =>
              GameParticipantRecord.fromJson(value! as Map<String, Object?>),
        )
        .toList(growable: false),
    winnerPlayerIds: (json['winnerPlayerIds'] as List<Object?>).cast<String>(),
  );
}

class StatisticsData {
  const StatisticsData({
    this.profiles = const <UserProfile>[],
    this.history = const <GameHistoryRecord>[],
    this.activeProfileId,
  });

  final List<UserProfile> profiles;
  final List<GameHistoryRecord> history;
  final String? activeProfileId;

  UserProfile? get activeProfile {
    for (final profile in profiles) {
      if (profile.id == activeProfileId) return profile;
    }
    return profiles.firstOrNull;
  }

  Map<String, Object?> toJson() => <String, Object?>{
    'schemaVersion': 1,
    'profiles': profiles.map((value) => value.toJson()).toList(),
    'history': history.map((value) => value.toJson()).toList(),
    'activeProfileId': activeProfileId,
  };

  factory StatisticsData.fromJson(Map<String, Object?> json) {
    final history = (json['history'] as List<Object?>? ?? const <Object?>[])
        .map(
          (value) => GameHistoryRecord.fromJson(value! as Map<String, Object?>),
        )
        .toList(growable: false);
    final profiles = (json['profiles'] as List<Object?>? ?? const <Object?>[])
        .map((value) => UserProfile.fromJson(value! as Map<String, Object?>))
        .map((profile) {
          if (profile.gamesPlayed > 0) return profile;
          var gamesPlayed = 0;
          var wins = 0;
          var maxLevel = 0;
          var totalDurationSeconds = 0;
          for (final record in history.where(
            (record) => record.localProfileId == profile.id,
          )) {
            gamesPlayed++;
            if (record.localPlayerWon) wins++;
            final peakLevel = record.localParticipant?.peakLevel ?? 0;
            if (peakLevel > maxLevel) maxLevel = peakLevel;
            totalDurationSeconds += record.duration.inSeconds;
          }
          return profile.copyWith(
            gamesPlayed: gamesPlayed,
            wins: wins,
            maxLevel: maxLevel,
            totalDurationSeconds: totalDurationSeconds,
          );
        })
        .toList(growable: false);
    return StatisticsData(
      profiles: profiles,
      history: history,
      activeProfileId: json['activeProfileId'] as String?,
    );
  }
}

abstract interface class StatisticsStore {
  Future<StatisticsData> load();
  Future<void> save(StatisticsData data);
}

class JsonFileStatisticsStore implements StatisticsStore {
  JsonFileStatisticsStore({this.fileName = 'statistics.json'});

  final String fileName;

  Future<File> _file() async {
    final directory = await getApplicationSupportDirectory();
    final folder = Directory('${directory.path}/munchkin_app');
    if (!folder.existsSync()) await folder.create(recursive: true);
    return File('${folder.path}/$fileName');
  }

  @override
  Future<StatisticsData> load() async {
    final file = await _file();
    final backup = File('${file.path}.bak');
    final source = file.existsSync() ? file : backup;
    if (!source.existsSync()) return const StatisticsData();
    final decoded = jsonDecode(await source.readAsString());
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Invalid statistics file.');
    }
    return StatisticsData.fromJson(decoded);
  }

  @override
  Future<void> save(StatisticsData data) async {
    final file = await _file();
    final temporary = File('${file.path}.tmp');
    final backup = File('${file.path}.bak');
    await temporary.writeAsString(jsonEncode(data.toJson()), flush: true);
    if (backup.existsSync()) await backup.delete();
    if (file.existsSync()) await file.rename(backup.path);
    await temporary.rename(file.path);
    if (backup.existsSync()) await backup.delete();
  }
}

class MemoryStatisticsStore implements StatisticsStore {
  StatisticsData value = const StatisticsData();

  @override
  Future<StatisticsData> load() async => value;

  @override
  Future<void> save(StatisticsData data) async => value = data;
}
