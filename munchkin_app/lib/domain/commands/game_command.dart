import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/game_models.dart';

part 'game_command.freezed.dart';
part 'game_command.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
sealed class GameCommand with _$GameCommand {
  const factory GameCommand.joinPlayer({
    required String playerId,
    required String name,
    @Default(false) bool isHost,
  }) = JoinPlayer;

  const factory GameCommand.setConnection({
    required String playerId,
    required bool connected,
  }) = SetConnection;

  const factory GameCommand.updateSettings(RoomSettings settings) =
      UpdateSettings;
  const factory GameCommand.closeLobby() = CloseLobby;
  const factory GameCommand.reopenLobby() = ReopenLobby;
  const factory GameCommand.setTurnOrder(List<String> playerIds) = SetTurnOrder;
  const factory GameCommand.shuffleTurnOrder() = ShuffleTurnOrder;
  const factory GameCommand.confirmOrder() = ConfirmOrder;
  const factory GameCommand.startGame() = StartGame;
  const factory GameCommand.adjustStats({
    @Default(0) int levelDelta,
    @Default(0) int strengthDelta,
  }) = AdjustStats;
  const factory GameCommand.adjustEquipment({
    required EquipmentSlot slot,
    required int delta,
  }) = AdjustEquipment;
  const factory GameCommand.endTurn() = EndTurn;
  const factory GameCommand.startBattle() = StartBattle;
  const factory GameCommand.declareVictory() = DeclareVictory;
  const factory GameCommand.intervene() = Intervene;
  const factory GameCommand.requestHelp() = RequestHelp;
  const factory GameCommand.resumeBattle() = ResumeBattle;
  const factory GameCommand.startEscape() = StartEscape;
  const factory GameCommand.resolveEscape() = ResolveEscape;
  const factory GameCommand.raiseLevel() = RaiseLevel;
  const factory GameCommand.finishBattle() = FinishBattle;
  const factory GameCommand.rollDice() = RollDice;
  const factory GameCommand.removePlayer(String playerId) = RemovePlayer;
  const factory GameCommand.leaveRoom() = LeaveRoom;
  const factory GameCommand.endGame() = EndGame;

  factory GameCommand.fromJson(Map<String, Object?> json) =>
      _$GameCommandFromJson(json);
}
