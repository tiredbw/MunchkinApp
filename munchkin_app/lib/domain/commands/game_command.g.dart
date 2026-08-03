// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
  strengthDelta: (json['strengthDelta'] as num?)?.toInt() ?? 0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AdjustStatsToJson(AdjustStats instance) =>
    <String, dynamic>{
      'strengthDelta': instance.strengthDelta,
      'type': instance.$type,
    };

AdjustPlayerLevel _$AdjustPlayerLevelFromJson(Map<String, dynamic> json) =>
    AdjustPlayerLevel(
      playerId: json['playerId'] as String,
      delta: (json['delta'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$AdjustPlayerLevelToJson(AdjustPlayerLevel instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'delta': instance.delta,
      'type': instance.$type,
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

RecordPhysicalRoll _$RecordPhysicalRollFromJson(Map<String, dynamic> json) =>
    RecordPhysicalRoll(
      (json['value'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RecordPhysicalRollToJson(RecordPhysicalRoll instance) =>
    <String, dynamic>{'value': instance.value, 'type': instance.$type};

UseCheatDie _$UseCheatDieFromJson(Map<String, dynamic> json) =>
    UseCheatDie((json['value'] as num).toInt(), $type: json['type'] as String?);

Map<String, dynamic> _$UseCheatDieToJson(UseCheatDie instance) =>
    <String, dynamic>{'value': instance.value, 'type': instance.$type};

AppealCheatDie _$AppealCheatDieFromJson(Map<String, dynamic> json) =>
    AppealCheatDie($type: json['type'] as String?);

Map<String, dynamic> _$AppealCheatDieToJson(AppealCheatDie instance) =>
    <String, dynamic>{'type': instance.$type};

ResolveDiceAppeal _$ResolveDiceAppealFromJson(Map<String, dynamic> json) =>
    ResolveDiceAppeal(json['accepted'] as bool, $type: json['type'] as String?);

Map<String, dynamic> _$ResolveDiceAppealToJson(ResolveDiceAppeal instance) =>
    <String, dynamic>{'accepted': instance.accepted, 'type': instance.$type};

OfferControl _$OfferControlFromJson(Map<String, dynamic> json) => OfferControl(
  playerId: json['playerId'] as String,
  controllerPlayerId: json['controllerPlayerId'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$OfferControlToJson(OfferControl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'controllerPlayerId': instance.controllerPlayerId,
      'type': instance.$type,
    };

RespondControl _$RespondControlFromJson(Map<String, dynamic> json) =>
    RespondControl(
      playerId: json['playerId'] as String,
      accepted: json['accepted'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RespondControlToJson(RespondControl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'accepted': instance.accepted,
      'type': instance.$type,
    };

RevokeControl _$RevokeControlFromJson(Map<String, dynamic> json) =>
    RevokeControl(json['playerId'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$RevokeControlToJson(RevokeControl instance) =>
    <String, dynamic>{'playerId': instance.playerId, 'type': instance.$type};

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
