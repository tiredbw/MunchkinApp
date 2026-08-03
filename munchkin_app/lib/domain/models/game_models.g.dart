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
  peakLevel: (json['peakLevel'] as num).toInt(),
  strength: (json['strength'] as num).toInt(),
  isLocalToHost: json['isLocalToHost'] as bool? ?? false,
  localControllerPlayerId: json['localControllerPlayerId'] as String?,
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
  'peakLevel': instance.peakLevel,
  'strength': instance.strength,
  'isLocalToHost': instance.isLocalToHost,
  'localControllerPlayerId': instance.localControllerPlayerId,
  'isConnected': instance.isConnected,
  'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
};

_ControlAssignment _$ControlAssignmentFromJson(Map<String, dynamic> json) =>
    _ControlAssignment(
      playerId: json['playerId'] as String,
      controllerPlayerId: json['controllerPlayerId'] as String,
      status:
          $enumDecodeNullable(
            _$ControlAssignmentStatusEnumMap,
            json['status'],
          ) ??
          ControlAssignmentStatus.pending,
    );

Map<String, dynamic> _$ControlAssignmentToJson(_ControlAssignment instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'controllerPlayerId': instance.controllerPlayerId,
      'status': _$ControlAssignmentStatusEnumMap[instance.status]!,
    };

const _$ControlAssignmentStatusEnumMap = {
  ControlAssignmentStatus.pending: 'pending',
  ControlAssignmentStatus.active: 'active',
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
  levelRewardClaimed: json['levelRewardClaimed'] as bool? ?? false,
);

Map<String, dynamic> _$BattleStateToJson(_BattleState instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'status': _$BattleStatusEnumMap[instance.status]!,
      'endsAt': instance.endsAt?.toIso8601String(),
      'intervenedBy': instance.intervenedBy,
      'levelRewardClaimed': instance.levelRewardClaimed,
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
  originalValue: (json['originalValue'] as num).toInt(),
  sides: (json['sides'] as num?)?.toInt() ?? 6,
  source: $enumDecode(_$DiceRollSourceEnumMap, json['source']),
  cheatedBy: json['cheatedBy'] as String?,
  finalized: json['finalized'] as bool? ?? false,
  rolledAt: DateTime.parse(json['rolledAt'] as String),
);

Map<String, dynamic> _$DiceRollToJson(_DiceRoll instance) => <String, dynamic>{
  'id': instance.id,
  'playerId': instance.playerId,
  'value': instance.value,
  'originalValue': instance.originalValue,
  'sides': instance.sides,
  'source': _$DiceRollSourceEnumMap[instance.source]!,
  'cheatedBy': instance.cheatedBy,
  'finalized': instance.finalized,
  'rolledAt': instance.rolledAt.toIso8601String(),
};

const _$DiceRollSourceEnumMap = {
  DiceRollSource.virtual: 'virtual',
  DiceRollSource.physical: 'physical',
};

_DiceAppeal _$DiceAppealFromJson(Map<String, dynamic> json) => _DiceAppeal(
  rollId: json['rollId'] as String,
  requestedBy: json['requestedBy'] as String,
  status:
      $enumDecodeNullable(_$DiceAppealStatusEnumMap, json['status']) ??
      DiceAppealStatus.pending,
  resolvedBy: json['resolvedBy'] as String?,
);

Map<String, dynamic> _$DiceAppealToJson(_DiceAppeal instance) =>
    <String, dynamic>{
      'rollId': instance.rollId,
      'requestedBy': instance.requestedBy,
      'status': _$DiceAppealStatusEnumMap[instance.status]!,
      'resolvedBy': instance.resolvedBy,
    };

const _$DiceAppealStatusEnumMap = {
  DiceAppealStatus.pending: 'pending',
  DiceAppealStatus.accepted: 'accepted',
  DiceAppealStatus.rejected: 'rejected',
};

_GameState _$GameStateFromJson(Map<String, dynamic> json) => _GameState(
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 6,
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
  controlAssignments:
      (json['controlAssignments'] as List<dynamic>?)
          ?.map((e) => ControlAssignment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ControlAssignment>[],
  activePlayerId: json['activePlayerId'] as String?,
  battleStartedThisTurn: json['battleStartedThisTurn'] as bool? ?? false,
  battle: json['battle'] == null
      ? null
      : BattleState.fromJson(json['battle'] as Map<String, dynamic>),
  lastDiceRoll: json['lastDiceRoll'] == null
      ? null
      : DiceRoll.fromJson(json['lastDiceRoll'] as Map<String, dynamic>),
  diceAppeal: json['diceAppeal'] == null
      ? null
      : DiceAppeal.fromJson(json['diceAppeal'] as Map<String, dynamic>),
  startedAt: json['startedAt'] == null
      ? null
      : DateTime.parse(json['startedAt'] as String),
  endedAt: json['endedAt'] == null
      ? null
      : DateTime.parse(json['endedAt'] as String),
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
      'controlAssignments': instance.controlAssignments,
      'activePlayerId': instance.activePlayerId,
      'battleStartedThisTurn': instance.battleStartedThisTurn,
      'battle': instance.battle,
      'lastDiceRoll': instance.lastDiceRoll,
      'diceAppeal': instance.diceAppeal,
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
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
