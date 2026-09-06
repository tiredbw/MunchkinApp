// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomSettings _$RoomSettingsFromJson(Map<String, dynamic> json) =>
    _RoomSettings(
      diceMode:
          $enumDecodeNullable(_$DiceModeEnumMap, json['diceMode']) ??
          DiceMode.virtual,
      minLevel: (json['minLevel'] as num?)?.toInt() ?? 1,
      maxLevel: (json['maxLevel'] as num?)?.toInt() ?? 10,
      initialLevel: (json['initialLevel'] as num?)?.toInt() ?? 1,
      minStrength: (json['minStrength'] as num?)?.toInt() ?? -99,
      maxStrength: (json['maxStrength'] as num?)?.toInt() ?? 99,
      initialStrength: (json['initialStrength'] as num?)?.toInt() ?? 0,
      victoryCountdownSeconds:
          (json['victoryCountdownSeconds'] as num?)?.toInt() ?? 5,
      trackRaceClass: json['trackRaceClass'] as bool? ?? true,
    );

Map<String, dynamic> _$RoomSettingsToJson(_RoomSettings instance) =>
    <String, dynamic>{
      'diceMode': _$DiceModeEnumMap[instance.diceMode]!,
      'minLevel': instance.minLevel,
      'maxLevel': instance.maxLevel,
      'initialLevel': instance.initialLevel,
      'minStrength': instance.minStrength,
      'maxStrength': instance.maxStrength,
      'initialStrength': instance.initialStrength,
      'victoryCountdownSeconds': instance.victoryCountdownSeconds,
      'trackRaceClass': instance.trackRaceClass,
    };

const _$DiceModeEnumMap = {
  DiceMode.physical: 'physical',
  DiceMode.virtual: 'virtual',
};

_Player _$PlayerFromJson(Map<String, dynamic> json) => _Player(
  id: json['id'] as String,
  name: json['name'] as String,
  isHost: json['isHost'] as bool,
  level: (json['level'] as num).toInt(),
  strength: (json['strength'] as num).toInt(),
  races:
      (json['races'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MunchkinRaceEnumMap, e))
          .toList() ??
      const <MunchkinRace>[MunchkinRace.human],
  classes:
      (json['classes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MunchkinClassEnumMap, e))
          .toList() ??
      const <MunchkinClass>[],
  isConnected: json['isConnected'] as bool? ?? true,
  lastSeenAt: json['lastSeenAt'] == null
      ? null
      : DateTime.parse(json['lastSeenAt'] as String),
);

Map<String, dynamic> _$PlayerToJson(_Player instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'isHost': instance.isHost,
  'level': instance.level,
  'strength': instance.strength,
  'races': instance.races.map((e) => _$MunchkinRaceEnumMap[e]!).toList(),
  'classes': instance.classes.map((e) => _$MunchkinClassEnumMap[e]!).toList(),
  'isConnected': instance.isConnected,
  'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
};

const _$MunchkinRaceEnumMap = {
  MunchkinRace.human: 'human',
  MunchkinRace.elf: 'elf',
  MunchkinRace.dwarf: 'dwarf',
  MunchkinRace.halfling: 'halfling',
  MunchkinRace.orc: 'orc',
  MunchkinRace.gnome: 'gnome',
  MunchkinRace.centaur: 'centaur',
  MunchkinRace.lizardGuy: 'lizardGuy',
};

const _$MunchkinClassEnumMap = {
  MunchkinClass.warrior: 'warrior',
  MunchkinClass.wizard: 'wizard',
  MunchkinClass.cleric: 'cleric',
  MunchkinClass.thief: 'thief',
  MunchkinClass.bard: 'bard',
  MunchkinClass.ranger: 'ranger',
};

_BattleState _$BattleStateFromJson(Map<String, dynamic> json) => _BattleState(
  playerId: json['playerId'] as String,
  status:
      $enumDecodeNullable(_$BattleStatusEnumMap, json['status']) ??
      BattleStatus.fighting,
  endsAt: json['endsAt'] == null
      ? null
      : DateTime.parse(json['endsAt'] as String),
  intervenedBy: json['intervenedBy'] as String?,
);

Map<String, dynamic> _$BattleStateToJson(_BattleState instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'status': _$BattleStatusEnumMap[instance.status]!,
      'endsAt': instance.endsAt?.toIso8601String(),
      'intervenedBy': instance.intervenedBy,
    };

const _$BattleStatusEnumMap = {
  BattleStatus.fighting: 'fighting',
  BattleStatus.countdown: 'countdown',
  BattleStatus.intervention: 'intervention',
  BattleStatus.helpRequested: 'helpRequested',
  BattleStatus.escaping: 'escaping',
  BattleStatus.won: 'won',
  BattleStatus.endedWithoutVictory: 'endedWithoutVictory',
};

_DiceRoll _$DiceRollFromJson(Map<String, dynamic> json) => _DiceRoll(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  value: (json['value'] as num).toInt(),
  sides: (json['sides'] as num?)?.toInt() ?? 6,
  rolledAt: DateTime.parse(json['rolledAt'] as String),
);

Map<String, dynamic> _$DiceRollToJson(_DiceRoll instance) => <String, dynamic>{
  'id': instance.id,
  'playerId': instance.playerId,
  'value': instance.value,
  'sides': instance.sides,
  'rolledAt': instance.rolledAt.toIso8601String(),
};

_GameState _$GameStateFromJson(Map<String, dynamic> json) => _GameState(
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
  roomId: json['roomId'] as String,
  revision: (json['revision'] as num?)?.toInt() ?? 0,
  settings: RoomSettings.fromJson(json['settings'] as Map<String, dynamic>),
  phase:
      $enumDecodeNullable(_$RoomPhaseEnumMap, json['phase']) ?? RoomPhase.lobby,
  players:
      (json['players'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Player>[],
  turnOrder:
      (json['turnOrder'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  activePlayerId: json['activePlayerId'] as String?,
  battle: json['battle'] == null
      ? null
      : BattleState.fromJson(json['battle'] as Map<String, dynamic>),
  lastDiceRoll: json['lastDiceRoll'] == null
      ? null
      : DiceRoll.fromJson(json['lastDiceRoll'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$GameStateToJson(_GameState instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'roomId': instance.roomId,
      'revision': instance.revision,
      'settings': instance.settings,
      'phase': _$RoomPhaseEnumMap[instance.phase]!,
      'players': instance.players,
      'turnOrder': instance.turnOrder,
      'activePlayerId': instance.activePlayerId,
      'battle': instance.battle,
      'lastDiceRoll': instance.lastDiceRoll,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$RoomPhaseEnumMap = {
  RoomPhase.lobby: 'lobby',
  RoomPhase.ordering: 'ordering',
  RoomPhase.ready: 'ready',
  RoomPhase.playing: 'playing',
  RoomPhase.ended: 'ended',
};
