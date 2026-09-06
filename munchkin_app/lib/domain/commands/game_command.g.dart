// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinPlayer _$JoinPlayerFromJson(Map<String, dynamic> json) => JoinPlayer(
  playerId: json['playerId'] as String,
  name: json['name'] as String,
  isHost: json['isHost'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$JoinPlayerToJson(JoinPlayer instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'name': instance.name,
      'isHost': instance.isHost,
      'type': instance.$type,
    };

SetConnection _$SetConnectionFromJson(Map<String, dynamic> json) =>
    SetConnection(
      playerId: json['playerId'] as String,
      connected: json['connected'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SetConnectionToJson(SetConnection instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'connected': instance.connected,
      'type': instance.$type,
    };

UpdateSettings _$UpdateSettingsFromJson(Map<String, dynamic> json) =>
    UpdateSettings(
      RoomSettings.fromJson(json['settings'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$UpdateSettingsToJson(UpdateSettings instance) =>
    <String, dynamic>{'settings': instance.settings, 'type': instance.$type};

CloseLobby _$CloseLobbyFromJson(Map<String, dynamic> json) =>
    CloseLobby($type: json['type'] as String?);

Map<String, dynamic> _$CloseLobbyToJson(CloseLobby instance) =>
    <String, dynamic>{'type': instance.$type};

ReopenLobby _$ReopenLobbyFromJson(Map<String, dynamic> json) =>
    ReopenLobby($type: json['type'] as String?);

Map<String, dynamic> _$ReopenLobbyToJson(ReopenLobby instance) =>
    <String, dynamic>{'type': instance.$type};

SetTurnOrder _$SetTurnOrderFromJson(Map<String, dynamic> json) => SetTurnOrder(
  (json['playerIds'] as List<dynamic>).map((e) => e as String).toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SetTurnOrderToJson(SetTurnOrder instance) =>
    <String, dynamic>{'playerIds': instance.playerIds, 'type': instance.$type};

ShuffleTurnOrder _$ShuffleTurnOrderFromJson(Map<String, dynamic> json) =>
    ShuffleTurnOrder($type: json['type'] as String?);

Map<String, dynamic> _$ShuffleTurnOrderToJson(ShuffleTurnOrder instance) =>
    <String, dynamic>{'type': instance.$type};

ConfirmOrder _$ConfirmOrderFromJson(Map<String, dynamic> json) =>
    ConfirmOrder($type: json['type'] as String?);

Map<String, dynamic> _$ConfirmOrderToJson(ConfirmOrder instance) =>
    <String, dynamic>{'type': instance.$type};

StartGame _$StartGameFromJson(Map<String, dynamic> json) =>
    StartGame($type: json['type'] as String?);

Map<String, dynamic> _$StartGameToJson(StartGame instance) => <String, dynamic>{
  'type': instance.$type,
};

AdjustStats _$AdjustStatsFromJson(Map<String, dynamic> json) => AdjustStats(
  levelDelta: (json['levelDelta'] as num?)?.toInt() ?? 0,
  strengthDelta: (json['strengthDelta'] as num?)?.toInt() ?? 0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AdjustStatsToJson(AdjustStats instance) =>
    <String, dynamic>{
      'levelDelta': instance.levelDelta,
      'strengthDelta': instance.strengthDelta,
      'type': instance.$type,
    };

SetIdentity _$SetIdentityFromJson(Map<String, dynamic> json) => SetIdentity(
  race: $enumDecode(_$MunchkinRaceEnumMap, json['race']),
  charClass: $enumDecode(_$MunchkinClassEnumMap, json['charClass']),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SetIdentityToJson(SetIdentity instance) =>
    <String, dynamic>{
      'race': _$MunchkinRaceEnumMap[instance.race]!,
      'charClass': _$MunchkinClassEnumMap[instance.charClass]!,
      'type': instance.$type,
    };

const _$MunchkinRaceEnumMap = {
  MunchkinRace.none: 'none',
  MunchkinRace.human: 'human',
  MunchkinRace.elf: 'elf',
  MunchkinRace.dwarf: 'dwarf',
  MunchkinRace.halfling: 'halfling',
};

const _$MunchkinClassEnumMap = {
  MunchkinClass.none: 'none',
  MunchkinClass.warrior: 'warrior',
  MunchkinClass.wizard: 'wizard',
  MunchkinClass.cleric: 'cleric',
  MunchkinClass.thief: 'thief',
};

EndTurn _$EndTurnFromJson(Map<String, dynamic> json) =>
    EndTurn($type: json['type'] as String?);

Map<String, dynamic> _$EndTurnToJson(EndTurn instance) => <String, dynamic>{
  'type': instance.$type,
};

StartBattle _$StartBattleFromJson(Map<String, dynamic> json) =>
    StartBattle($type: json['type'] as String?);

Map<String, dynamic> _$StartBattleToJson(StartBattle instance) =>
    <String, dynamic>{'type': instance.$type};

DeclareVictory _$DeclareVictoryFromJson(Map<String, dynamic> json) =>
    DeclareVictory($type: json['type'] as String?);

Map<String, dynamic> _$DeclareVictoryToJson(DeclareVictory instance) =>
    <String, dynamic>{'type': instance.$type};

Intervene _$InterveneFromJson(Map<String, dynamic> json) =>
    Intervene($type: json['type'] as String?);

Map<String, dynamic> _$InterveneToJson(Intervene instance) => <String, dynamic>{
  'type': instance.$type,
};

RequestHelp _$RequestHelpFromJson(Map<String, dynamic> json) =>
    RequestHelp($type: json['type'] as String?);

Map<String, dynamic> _$RequestHelpToJson(RequestHelp instance) =>
    <String, dynamic>{'type': instance.$type};

ResumeBattle _$ResumeBattleFromJson(Map<String, dynamic> json) =>
    ResumeBattle($type: json['type'] as String?);

Map<String, dynamic> _$ResumeBattleToJson(ResumeBattle instance) =>
    <String, dynamic>{'type': instance.$type};

StartEscape _$StartEscapeFromJson(Map<String, dynamic> json) =>
    StartEscape($type: json['type'] as String?);

Map<String, dynamic> _$StartEscapeToJson(StartEscape instance) =>
    <String, dynamic>{'type': instance.$type};

ResolveEscape _$ResolveEscapeFromJson(Map<String, dynamic> json) =>
    ResolveEscape($type: json['type'] as String?);

Map<String, dynamic> _$ResolveEscapeToJson(ResolveEscape instance) =>
    <String, dynamic>{'type': instance.$type};

RaiseLevel _$RaiseLevelFromJson(Map<String, dynamic> json) =>
    RaiseLevel($type: json['type'] as String?);

Map<String, dynamic> _$RaiseLevelToJson(RaiseLevel instance) =>
    <String, dynamic>{'type': instance.$type};

FinishBattle _$FinishBattleFromJson(Map<String, dynamic> json) =>
    FinishBattle($type: json['type'] as String?);

Map<String, dynamic> _$FinishBattleToJson(FinishBattle instance) =>
    <String, dynamic>{'type': instance.$type};

RollDice _$RollDiceFromJson(Map<String, dynamic> json) =>
    RollDice($type: json['type'] as String?);

Map<String, dynamic> _$RollDiceToJson(RollDice instance) => <String, dynamic>{
  'type': instance.$type,
};

RemovePlayer _$RemovePlayerFromJson(Map<String, dynamic> json) =>
    RemovePlayer(json['playerId'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$RemovePlayerToJson(RemovePlayer instance) =>
    <String, dynamic>{'playerId': instance.playerId, 'type': instance.$type};

LeaveRoom _$LeaveRoomFromJson(Map<String, dynamic> json) =>
    LeaveRoom($type: json['type'] as String?);

Map<String, dynamic> _$LeaveRoomToJson(LeaveRoom instance) => <String, dynamic>{
  'type': instance.$type,
};

EndGame _$EndGameFromJson(Map<String, dynamic> json) =>
    EndGame($type: json['type'] as String?);

Map<String, dynamic> _$EndGameToJson(EndGame instance) => <String, dynamic>{
  'type': instance.$type,
};
