import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_models.freezed.dart';
part 'game_models.g.dart';

enum DiceMode { physical, virtual }

enum RoomPhase { lobby, ordering, ready, playing, ended }

enum EquipmentSlot { headgear, armor, weapon, footgear, other }

enum BattleStatus {
  fighting,
  countdown,
  intervention,
  helpRequested,
  escaping,
  won,
  endedWithoutVictory,
}

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
abstract class Equipment with _$Equipment {
  const Equipment._();

  const factory Equipment({
    @Default(0) int headgear,
    @Default(0) int armor,
    @Default(0) int weapon,
    @Default(0) int footgear,
    @Default(0) int other,
  }) = _Equipment;

  factory Equipment.fromJson(Map<String, Object?> json) =>
      _$EquipmentFromJson(json);

  int get total => headgear + armor + weapon + footgear + other;

  int forSlot(EquipmentSlot slot) => switch (slot) {
    EquipmentSlot.headgear => headgear,
    EquipmentSlot.armor => armor,
    EquipmentSlot.weapon => weapon,
    EquipmentSlot.footgear => footgear,
    EquipmentSlot.other => other,
  };

  Equipment withSlot(EquipmentSlot slot, int value) => switch (slot) {
    EquipmentSlot.headgear => copyWith(headgear: value),
    EquipmentSlot.armor => copyWith(armor: value),
    EquipmentSlot.weapon => copyWith(weapon: value),
    EquipmentSlot.footgear => copyWith(footgear: value),
    EquipmentSlot.other => copyWith(other: value),
  };
}

@freezed
abstract class Player with _$Player {
  const Player._();

  const factory Player({
    required String id,
    required String name,
    required bool isHost,
    required int level,
    required int strength,
    @Default(Equipment()) Equipment equipment,
    @Default(true) bool isConnected,
    DateTime? lastSeenAt,
  }) = _Player;

  factory Player.fromJson(Map<String, Object?> json) => _$PlayerFromJson(json);

  int get totalPower => level + strength + equipment.total;
}

@freezed
abstract class BattleState with _$BattleState {
  const factory BattleState({
    required String playerId,
    @Default(BattleStatus.fighting) BattleStatus status,
    DateTime? endsAt,
    String? intervenedBy,
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
    @Default(6) int sides,
    required DateTime rolledAt,
  }) = _DiceRoll;

  factory DiceRoll.fromJson(Map<String, Object?> json) =>
      _$DiceRollFromJson(json);
}

@freezed
abstract class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    @Default(1) int schemaVersion,
    required String roomId,
    @Default(0) int revision,
    required RoomSettings settings,
    @Default(RoomPhase.lobby) RoomPhase phase,
    @Default(<Player>[]) List<Player> players,
    @Default(<String>[]) List<String> turnOrder,
    String? activePlayerId,
    BattleState? battle,
    DiceRoll? lastDiceRoll,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GameState;

  factory GameState.fromJson(Map<String, Object?> json) =>
      _$GameStateFromJson(json);

  Player? playerById(String? id) {
    if (id == null) return null;
    for (final player in players) {
      if (player.id == id) return player;
    }
    return null;
  }

  Player? get activePlayer => playerById(activePlayerId);
}
