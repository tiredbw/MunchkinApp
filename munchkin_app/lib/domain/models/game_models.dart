import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_models.freezed.dart';
part 'game_models.g.dart';

Map<String, Object?> _migrateDiceRollJson(Map<String, Object?> json) {
  final migrated = <String, Object?>{...json};
  migrated['originalValue'] ??= migrated['value'];
  migrated['source'] ??= DiceRollSource.virtual.name;
  return migrated;
}

Map<String, Object?> _migrateGameStateJson(Map<String, Object?> json) {
  final migrated = <String, Object?>{...json};
  migrated['schemaVersion'] = 4;
  migrated['controlAssignments'] ??= <Object?>[];
  return migrated;
}

Map<String, Object?> _migratePlayerJson(Map<String, Object?> json) {
  final migrated = <String, Object?>{...json};
  migrated['peakLevel'] ??= migrated['level'];
  return migrated;
}

enum DiceMode { physical, virtual }

enum RoomPhase { lobby, ordering, ready, playing, ended }

enum BattleStatus {
  fighting,
  countdown,
  intervention,
  helpRequested,
  escaping,
  won,
  endedWithoutVictory,
}

enum DiceRollSource { virtual, physical }

enum DiceAppealStatus { pending, accepted, rejected }

enum ControlAssignmentStatus { pending, active }

@freezed
abstract class RoomSettings with _$RoomSettings {
  const factory RoomSettings({
    @Default(DiceMode.virtual) DiceMode diceMode,
    @Default(1) int minLevel,
    @Default(10) int maxLevel,
    @Default(1) int initialLevel,
    @Default(-99) int minStrength,
    @Default(99) int maxStrength,
    @Default(0) int initialStrength,
    @Default(5) int victoryCountdownSeconds,
  }) = _RoomSettings;

  factory RoomSettings.fromJson(Map<String, Object?> json) =>
      _$RoomSettingsFromJson(json);
}

@freezed
abstract class Player with _$Player {
  const Player._();

  const factory Player({
    required String id,
    required String name,
    required bool isHost,
    required int level,
    required int peakLevel,
    required int strength,
    @Default(true) bool isConnected,
    DateTime? lastSeenAt,
  }) = _Player;

  factory Player.fromJson(Map<String, Object?> json) =>
      _$PlayerFromJson(_migratePlayerJson(json));

  int get totalPower => level + strength;
}

@freezed
abstract class ControlAssignment with _$ControlAssignment {
  const factory ControlAssignment({
    required String playerId,
    required String controllerPlayerId,
    @Default(ControlAssignmentStatus.pending) ControlAssignmentStatus status,
  }) = _ControlAssignment;

  factory ControlAssignment.fromJson(Map<String, Object?> json) =>
      _$ControlAssignmentFromJson(json);
}

@freezed
abstract class BattleState with _$BattleState {
  const factory BattleState({
    required String playerId,
    @Default(BattleStatus.fighting) BattleStatus status,
    DateTime? endsAt,
    String? intervenedBy,
    @Default(false) bool levelRewardClaimed,
  }) = _BattleState;

  factory BattleState.fromJson(Map<String, Object?> json) =>
      _$BattleStateFromJson(json);
}

@freezed
abstract class DiceRoll with _$DiceRoll {
  const factory DiceRoll({
    required String id,
    required String playerId,
    required int value,
    required int originalValue,
    @Default(6) int sides,
    required DiceRollSource source,
    String? cheatedBy,
    @Default(false) bool finalized,
    required DateTime rolledAt,
  }) = _DiceRoll;

  factory DiceRoll.fromJson(Map<String, Object?> json) =>
      _$DiceRollFromJson(_migrateDiceRollJson(json));
}

@freezed
abstract class DiceAppeal with _$DiceAppeal {
  const factory DiceAppeal({
    required String rollId,
    required String requestedBy,
    @Default(DiceAppealStatus.pending) DiceAppealStatus status,
    String? resolvedBy,
  }) = _DiceAppeal;

  factory DiceAppeal.fromJson(Map<String, Object?> json) =>
      _$DiceAppealFromJson(json);
}

@freezed
abstract class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    @Default(4) int schemaVersion,
    required String roomId,
    @Default(0) int revision,
    required RoomSettings settings,
    @Default(RoomPhase.lobby) RoomPhase phase,
    @Default(<Player>[]) List<Player> players,
    @Default(<String>[]) List<String> turnOrder,
    @Default(<ControlAssignment>[]) List<ControlAssignment> controlAssignments,
    String? activePlayerId,
    @Default(false) bool battleStartedThisTurn,
    BattleState? battle,
    DiceRoll? lastDiceRoll,
    DiceAppeal? diceAppeal,
    DateTime? startedAt,
    DateTime? endedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GameState;

  factory GameState.fromJson(Map<String, Object?> json) =>
      _$GameStateFromJson(_migrateGameStateJson(json));

  Player? playerById(String? id) {
    if (id == null) return null;
    for (final player in players) {
      if (player.id == id) return player;
    }
    return null;
  }

  Player? get activePlayer => playerById(activePlayerId);

  ControlAssignment? assignmentFor(String? playerId) {
    if (playerId == null) return null;
    for (final assignment in controlAssignments) {
      if (assignment.playerId == playerId) return assignment;
    }
    return null;
  }

  List<String> controlledPlayerIds(String? controllerPlayerId) {
    if (controllerPlayerId == null) return const <String>[];
    return controlAssignments
        .where(
          (assignment) =>
              assignment.controllerPlayerId == controllerPlayerId &&
              assignment.status == ControlAssignmentStatus.active,
        )
        .map((assignment) => assignment.playerId)
        .toList(growable: false);
  }
}
