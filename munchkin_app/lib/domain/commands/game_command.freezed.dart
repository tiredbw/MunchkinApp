// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
GameCommand _$GameCommandFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'UpdateSettings':
          return UpdateSettings.fromJson(
            json
          );
                case 'CloseLobby':
          return CloseLobby.fromJson(
            json
          );
                case 'ReopenLobby':
          return ReopenLobby.fromJson(
            json
          );
                case 'SetTurnOrder':
          return SetTurnOrder.fromJson(
            json
          );
                case 'ShuffleTurnOrder':
          return ShuffleTurnOrder.fromJson(
            json
          );
                case 'ConfirmOrder':
          return ConfirmOrder.fromJson(
            json
          );
                case 'StartGame':
          return StartGame.fromJson(
            json
          );
                case 'AdjustStats':
          return AdjustStats.fromJson(
            json
          );
                case 'AdjustPlayerLevel':
          return AdjustPlayerLevel.fromJson(
            json
          );
                case 'EndTurn':
          return EndTurn.fromJson(
            json
          );
                case 'StartBattle':
          return StartBattle.fromJson(
            json
          );
                case 'DeclareVictory':
          return DeclareVictory.fromJson(
            json
          );
                case 'Intervene':
          return Intervene.fromJson(
            json
          );
                case 'RequestHelp':
          return RequestHelp.fromJson(
            json
          );
                case 'ResumeBattle':
          return ResumeBattle.fromJson(
            json
          );
                case 'StartEscape':
          return StartEscape.fromJson(
            json
          );
                case 'ResolveEscape':
          return ResolveEscape.fromJson(
            json
          );
                case 'RaiseLevel':
          return RaiseLevel.fromJson(
            json
          );
                case 'FinishBattle':
          return FinishBattle.fromJson(
            json
          );
                case 'RollDice':
          return RollDice.fromJson(
            json
          );
                case 'RecordPhysicalRoll':
          return RecordPhysicalRoll.fromJson(
            json
          );
                case 'UseCheatDie':
          return UseCheatDie.fromJson(
            json
          );
                case 'AppealCheatDie':
          return AppealCheatDie.fromJson(
            json
          );
                case 'ResolveDiceAppeal':
          return ResolveDiceAppeal.fromJson(
            json
          );
                case 'OfferControl':
          return OfferControl.fromJson(
            json
          );
                case 'RespondControl':
          return RespondControl.fromJson(
            json
          );
                case 'RevokeControl':
          return RevokeControl.fromJson(
            json
          );
                case 'RemovePlayer':
          return RemovePlayer.fromJson(
            json
          );
                case 'LeaveRoom':
          return LeaveRoom.fromJson(
            json
          );
                case 'EndGame':
          return EndGame.fromJson(
            json
          );

          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'GameCommand',
  'Invalid union type "${json['type']}"!'
);
        }

}

/// @nodoc
mixin _$GameCommand {



  /// Serializes this GameCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameCommand);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand()';
}


}

/// @nodoc
class $GameCommandCopyWith<$Res>  {
$GameCommandCopyWith(GameCommand _, $Res Function(GameCommand) __);
}


/// Adds pattern-matching-related methods to [GameCommand].
extension GameCommandPatterns on GameCommand {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UpdateSettings value)?  updateSettings,TResult Function( CloseLobby value)?  closeLobby,TResult Function( ReopenLobby value)?  reopenLobby,TResult Function( SetTurnOrder value)?  setTurnOrder,TResult Function( ShuffleTurnOrder value)?  shuffleTurnOrder,TResult Function( ConfirmOrder value)?  confirmOrder,TResult Function( StartGame value)?  startGame,TResult Function( AdjustStats value)?  adjustStats,TResult Function( AdjustPlayerLevel value)?  adjustPlayerLevel,TResult Function( EndTurn value)?  endTurn,TResult Function( StartBattle value)?  startBattle,TResult Function( DeclareVictory value)?  declareVictory,TResult Function( Intervene value)?  intervene,TResult Function( RequestHelp value)?  requestHelp,TResult Function( ResumeBattle value)?  resumeBattle,TResult Function( StartEscape value)?  startEscape,TResult Function( ResolveEscape value)?  resolveEscape,TResult Function( RaiseLevel value)?  raiseLevel,TResult Function( FinishBattle value)?  finishBattle,TResult Function( RollDice value)?  rollDice,TResult Function( RecordPhysicalRoll value)?  recordPhysicalRoll,TResult Function( UseCheatDie value)?  useCheatDie,TResult Function( AppealCheatDie value)?  appealCheatDie,TResult Function( ResolveDiceAppeal value)?  resolveDiceAppeal,TResult Function( OfferControl value)?  offerControl,TResult Function( RespondControl value)?  respondControl,TResult Function( RevokeControl value)?  revokeControl,TResult Function( RemovePlayer value)?  removePlayer,TResult Function( LeaveRoom value)?  leaveRoom,TResult Function( EndGame value)?  endGame,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UpdateSettings() when updateSettings != null:
return updateSettings(_that);case CloseLobby() when closeLobby != null:
return closeLobby(_that);case ReopenLobby() when reopenLobby != null:
return reopenLobby(_that);case SetTurnOrder() when setTurnOrder != null:
return setTurnOrder(_that);case ShuffleTurnOrder() when shuffleTurnOrder != null:
return shuffleTurnOrder(_that);case ConfirmOrder() when confirmOrder != null:
return confirmOrder(_that);case StartGame() when startGame != null:
return startGame(_that);case AdjustStats() when adjustStats != null:
return adjustStats(_that);case AdjustPlayerLevel() when adjustPlayerLevel != null:
return adjustPlayerLevel(_that);case EndTurn() when endTurn != null:
return endTurn(_that);case StartBattle() when startBattle != null:
return startBattle(_that);case DeclareVictory() when declareVictory != null:
return declareVictory(_that);case Intervene() when intervene != null:
return intervene(_that);case RequestHelp() when requestHelp != null:
return requestHelp(_that);case ResumeBattle() when resumeBattle != null:
return resumeBattle(_that);case StartEscape() when startEscape != null:
return startEscape(_that);case ResolveEscape() when resolveEscape != null:
return resolveEscape(_that);case RaiseLevel() when raiseLevel != null:
return raiseLevel(_that);case FinishBattle() when finishBattle != null:
return finishBattle(_that);case RollDice() when rollDice != null:
return rollDice(_that);case RecordPhysicalRoll() when recordPhysicalRoll != null:
return recordPhysicalRoll(_that);case UseCheatDie() when useCheatDie != null:
return useCheatDie(_that);case AppealCheatDie() when appealCheatDie != null:
return appealCheatDie(_that);case ResolveDiceAppeal() when resolveDiceAppeal != null:
return resolveDiceAppeal(_that);case OfferControl() when offerControl != null:
return offerControl(_that);case RespondControl() when respondControl != null:
return respondControl(_that);case RevokeControl() when revokeControl != null:
return revokeControl(_that);case RemovePlayer() when removePlayer != null:
return removePlayer(_that);case LeaveRoom() when leaveRoom != null:
return leaveRoom(_that);case EndGame() when endGame != null:
return endGame(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UpdateSettings value)  updateSettings,required TResult Function( CloseLobby value)  closeLobby,required TResult Function( ReopenLobby value)  reopenLobby,required TResult Function( SetTurnOrder value)  setTurnOrder,required TResult Function( ShuffleTurnOrder value)  shuffleTurnOrder,required TResult Function( ConfirmOrder value)  confirmOrder,required TResult Function( StartGame value)  startGame,required TResult Function( AdjustStats value)  adjustStats,required TResult Function( AdjustPlayerLevel value)  adjustPlayerLevel,required TResult Function( EndTurn value)  endTurn,required TResult Function( StartBattle value)  startBattle,required TResult Function( DeclareVictory value)  declareVictory,required TResult Function( Intervene value)  intervene,required TResult Function( RequestHelp value)  requestHelp,required TResult Function( ResumeBattle value)  resumeBattle,required TResult Function( StartEscape value)  startEscape,required TResult Function( ResolveEscape value)  resolveEscape,required TResult Function( RaiseLevel value)  raiseLevel,required TResult Function( FinishBattle value)  finishBattle,required TResult Function( RollDice value)  rollDice,required TResult Function( RecordPhysicalRoll value)  recordPhysicalRoll,required TResult Function( UseCheatDie value)  useCheatDie,required TResult Function( AppealCheatDie value)  appealCheatDie,required TResult Function( ResolveDiceAppeal value)  resolveDiceAppeal,required TResult Function( OfferControl value)  offerControl,required TResult Function( RespondControl value)  respondControl,required TResult Function( RevokeControl value)  revokeControl,required TResult Function( RemovePlayer value)  removePlayer,required TResult Function( LeaveRoom value)  leaveRoom,required TResult Function( EndGame value)  endGame,}){
final _that = this;
switch (_that) {
case UpdateSettings():
return updateSettings(_that);case CloseLobby():
return closeLobby(_that);case ReopenLobby():
return reopenLobby(_that);case SetTurnOrder():
return setTurnOrder(_that);case ShuffleTurnOrder():
return shuffleTurnOrder(_that);case ConfirmOrder():
return confirmOrder(_that);case StartGame():
return startGame(_that);case AdjustStats():
return adjustStats(_that);case AdjustPlayerLevel():
return adjustPlayerLevel(_that);case EndTurn():
return endTurn(_that);case StartBattle():
return startBattle(_that);case DeclareVictory():
return declareVictory(_that);case Intervene():
return intervene(_that);case RequestHelp():
return requestHelp(_that);case ResumeBattle():
return resumeBattle(_that);case StartEscape():
return startEscape(_that);case ResolveEscape():
return resolveEscape(_that);case RaiseLevel():
return raiseLevel(_that);case FinishBattle():
return finishBattle(_that);case RollDice():
return rollDice(_that);case RecordPhysicalRoll():
return recordPhysicalRoll(_that);case UseCheatDie():
return useCheatDie(_that);case AppealCheatDie():
return appealCheatDie(_that);case ResolveDiceAppeal():
return resolveDiceAppeal(_that);case OfferControl():
return offerControl(_that);case RespondControl():
return respondControl(_that);case RevokeControl():
return revokeControl(_that);case RemovePlayer():
return removePlayer(_that);case LeaveRoom():
return leaveRoom(_that);case EndGame():
return endGame(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UpdateSettings value)?  updateSettings,TResult? Function( CloseLobby value)?  closeLobby,TResult? Function( ReopenLobby value)?  reopenLobby,TResult? Function( SetTurnOrder value)?  setTurnOrder,TResult? Function( ShuffleTurnOrder value)?  shuffleTurnOrder,TResult? Function( ConfirmOrder value)?  confirmOrder,TResult? Function( StartGame value)?  startGame,TResult? Function( AdjustStats value)?  adjustStats,TResult? Function( AdjustPlayerLevel value)?  adjustPlayerLevel,TResult? Function( EndTurn value)?  endTurn,TResult? Function( StartBattle value)?  startBattle,TResult? Function( DeclareVictory value)?  declareVictory,TResult? Function( Intervene value)?  intervene,TResult? Function( RequestHelp value)?  requestHelp,TResult? Function( ResumeBattle value)?  resumeBattle,TResult? Function( StartEscape value)?  startEscape,TResult? Function( ResolveEscape value)?  resolveEscape,TResult? Function( RaiseLevel value)?  raiseLevel,TResult? Function( FinishBattle value)?  finishBattle,TResult? Function( RollDice value)?  rollDice,TResult? Function( RecordPhysicalRoll value)?  recordPhysicalRoll,TResult? Function( UseCheatDie value)?  useCheatDie,TResult? Function( AppealCheatDie value)?  appealCheatDie,TResult? Function( ResolveDiceAppeal value)?  resolveDiceAppeal,TResult? Function( OfferControl value)?  offerControl,TResult? Function( RespondControl value)?  respondControl,TResult? Function( RevokeControl value)?  revokeControl,TResult? Function( RemovePlayer value)?  removePlayer,TResult? Function( LeaveRoom value)?  leaveRoom,TResult? Function( EndGame value)?  endGame,}){
final _that = this;
switch (_that) {
case UpdateSettings() when updateSettings != null:
return updateSettings(_that);case CloseLobby() when closeLobby != null:
return closeLobby(_that);case ReopenLobby() when reopenLobby != null:
return reopenLobby(_that);case SetTurnOrder() when setTurnOrder != null:
return setTurnOrder(_that);case ShuffleTurnOrder() when shuffleTurnOrder != null:
return shuffleTurnOrder(_that);case ConfirmOrder() when confirmOrder != null:
return confirmOrder(_that);case StartGame() when startGame != null:
return startGame(_that);case AdjustStats() when adjustStats != null:
return adjustStats(_that);case AdjustPlayerLevel() when adjustPlayerLevel != null:
return adjustPlayerLevel(_that);case EndTurn() when endTurn != null:
return endTurn(_that);case StartBattle() when startBattle != null:
return startBattle(_that);case DeclareVictory() when declareVictory != null:
return declareVictory(_that);case Intervene() when intervene != null:
return intervene(_that);case RequestHelp() when requestHelp != null:
return requestHelp(_that);case ResumeBattle() when resumeBattle != null:
return resumeBattle(_that);case StartEscape() when startEscape != null:
return startEscape(_that);case ResolveEscape() when resolveEscape != null:
return resolveEscape(_that);case RaiseLevel() when raiseLevel != null:
return raiseLevel(_that);case FinishBattle() when finishBattle != null:
return finishBattle(_that);case RollDice() when rollDice != null:
return rollDice(_that);case RecordPhysicalRoll() when recordPhysicalRoll != null:
return recordPhysicalRoll(_that);case UseCheatDie() when useCheatDie != null:
return useCheatDie(_that);case AppealCheatDie() when appealCheatDie != null:
return appealCheatDie(_that);case ResolveDiceAppeal() when resolveDiceAppeal != null:
return resolveDiceAppeal(_that);case OfferControl() when offerControl != null:
return offerControl(_that);case RespondControl() when respondControl != null:
return respondControl(_that);case RevokeControl() when revokeControl != null:
return revokeControl(_that);case RemovePlayer() when removePlayer != null:
return removePlayer(_that);case LeaveRoom() when leaveRoom != null:
return leaveRoom(_that);case EndGame() when endGame != null:
return endGame(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RoomSettings settings)?  updateSettings,TResult Function()?  closeLobby,TResult Function()?  reopenLobby,TResult Function( List<String> playerIds)?  setTurnOrder,TResult Function()?  shuffleTurnOrder,TResult Function()?  confirmOrder,TResult Function()?  startGame,TResult Function( int strengthDelta)?  adjustStats,TResult Function( String playerId,  int delta)?  adjustPlayerLevel,TResult Function()?  endTurn,TResult Function()?  startBattle,TResult Function()?  declareVictory,TResult Function()?  intervene,TResult Function()?  requestHelp,TResult Function()?  resumeBattle,TResult Function()?  startEscape,TResult Function()?  resolveEscape,TResult Function()?  raiseLevel,TResult Function()?  finishBattle,TResult Function()?  rollDice,TResult Function( int value)?  recordPhysicalRoll,TResult Function( int value)?  useCheatDie,TResult Function()?  appealCheatDie,TResult Function( bool accepted)?  resolveDiceAppeal,TResult Function( String playerId,  String controllerPlayerId)?  offerControl,TResult Function( String playerId,  bool accepted)?  respondControl,TResult Function( String playerId)?  revokeControl,TResult Function( String playerId)?  removePlayer,TResult Function()?  leaveRoom,TResult Function()?  endGame,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UpdateSettings() when updateSettings != null:
return updateSettings(_that.settings);case CloseLobby() when closeLobby != null:
return closeLobby();case ReopenLobby() when reopenLobby != null:
return reopenLobby();case SetTurnOrder() when setTurnOrder != null:
return setTurnOrder(_that.playerIds);case ShuffleTurnOrder() when shuffleTurnOrder != null:
return shuffleTurnOrder();case ConfirmOrder() when confirmOrder != null:
return confirmOrder();case StartGame() when startGame != null:
return startGame();case AdjustStats() when adjustStats != null:
return adjustStats(_that.strengthDelta);case AdjustPlayerLevel() when adjustPlayerLevel != null:
return adjustPlayerLevel(_that.playerId,_that.delta);case EndTurn() when endTurn != null:
return endTurn();case StartBattle() when startBattle != null:
return startBattle();case DeclareVictory() when declareVictory != null:
return declareVictory();case Intervene() when intervene != null:
return intervene();case RequestHelp() when requestHelp != null:
return requestHelp();case ResumeBattle() when resumeBattle != null:
return resumeBattle();case StartEscape() when startEscape != null:
return startEscape();case ResolveEscape() when resolveEscape != null:
return resolveEscape();case RaiseLevel() when raiseLevel != null:
return raiseLevel();case FinishBattle() when finishBattle != null:
return finishBattle();case RollDice() when rollDice != null:
return rollDice();case RecordPhysicalRoll() when recordPhysicalRoll != null:
return recordPhysicalRoll(_that.value);case UseCheatDie() when useCheatDie != null:
return useCheatDie(_that.value);case AppealCheatDie() when appealCheatDie != null:
return appealCheatDie();case ResolveDiceAppeal() when resolveDiceAppeal != null:
return resolveDiceAppeal(_that.accepted);case OfferControl() when offerControl != null:
return offerControl(_that.playerId,_that.controllerPlayerId);case RespondControl() when respondControl != null:
return respondControl(_that.playerId,_that.accepted);case RevokeControl() when revokeControl != null:
return revokeControl(_that.playerId);case RemovePlayer() when removePlayer != null:
return removePlayer(_that.playerId);case LeaveRoom() when leaveRoom != null:
return leaveRoom();case EndGame() when endGame != null:
return endGame();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RoomSettings settings)  updateSettings,required TResult Function()  closeLobby,required TResult Function()  reopenLobby,required TResult Function( List<String> playerIds)  setTurnOrder,required TResult Function()  shuffleTurnOrder,required TResult Function()  confirmOrder,required TResult Function()  startGame,required TResult Function( int strengthDelta)  adjustStats,required TResult Function( String playerId,  int delta)  adjustPlayerLevel,required TResult Function()  endTurn,required TResult Function()  startBattle,required TResult Function()  declareVictory,required TResult Function()  intervene,required TResult Function()  requestHelp,required TResult Function()  resumeBattle,required TResult Function()  startEscape,required TResult Function()  resolveEscape,required TResult Function()  raiseLevel,required TResult Function()  finishBattle,required TResult Function()  rollDice,required TResult Function( int value)  recordPhysicalRoll,required TResult Function( int value)  useCheatDie,required TResult Function()  appealCheatDie,required TResult Function( bool accepted)  resolveDiceAppeal,required TResult Function( String playerId,  String controllerPlayerId)  offerControl,required TResult Function( String playerId,  bool accepted)  respondControl,required TResult Function( String playerId)  revokeControl,required TResult Function( String playerId)  removePlayer,required TResult Function()  leaveRoom,required TResult Function()  endGame,}) {final _that = this;
switch (_that) {
case UpdateSettings():
return updateSettings(_that.settings);case CloseLobby():
return closeLobby();case ReopenLobby():
return reopenLobby();case SetTurnOrder():
return setTurnOrder(_that.playerIds);case ShuffleTurnOrder():
return shuffleTurnOrder();case ConfirmOrder():
return confirmOrder();case StartGame():
return startGame();case AdjustStats():
return adjustStats(_that.strengthDelta);case AdjustPlayerLevel():
return adjustPlayerLevel(_that.playerId,_that.delta);case EndTurn():
return endTurn();case StartBattle():
return startBattle();case DeclareVictory():
return declareVictory();case Intervene():
return intervene();case RequestHelp():
return requestHelp();case ResumeBattle():
return resumeBattle();case StartEscape():
return startEscape();case ResolveEscape():
return resolveEscape();case RaiseLevel():
return raiseLevel();case FinishBattle():
return finishBattle();case RollDice():
return rollDice();case RecordPhysicalRoll():
return recordPhysicalRoll(_that.value);case UseCheatDie():
return useCheatDie(_that.value);case AppealCheatDie():
return appealCheatDie();case ResolveDiceAppeal():
return resolveDiceAppeal(_that.accepted);case OfferControl():
return offerControl(_that.playerId,_that.controllerPlayerId);case RespondControl():
return respondControl(_that.playerId,_that.accepted);case RevokeControl():
return revokeControl(_that.playerId);case RemovePlayer():
return removePlayer(_that.playerId);case LeaveRoom():
return leaveRoom();case EndGame():
return endGame();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RoomSettings settings)?  updateSettings,TResult? Function()?  closeLobby,TResult? Function()?  reopenLobby,TResult? Function( List<String> playerIds)?  setTurnOrder,TResult? Function()?  shuffleTurnOrder,TResult? Function()?  confirmOrder,TResult? Function()?  startGame,TResult? Function( int strengthDelta)?  adjustStats,TResult? Function( String playerId,  int delta)?  adjustPlayerLevel,TResult? Function()?  endTurn,TResult? Function()?  startBattle,TResult? Function()?  declareVictory,TResult? Function()?  intervene,TResult? Function()?  requestHelp,TResult? Function()?  resumeBattle,TResult? Function()?  startEscape,TResult? Function()?  resolveEscape,TResult? Function()?  raiseLevel,TResult? Function()?  finishBattle,TResult? Function()?  rollDice,TResult? Function( int value)?  recordPhysicalRoll,TResult? Function( int value)?  useCheatDie,TResult? Function()?  appealCheatDie,TResult? Function( bool accepted)?  resolveDiceAppeal,TResult? Function( String playerId,  String controllerPlayerId)?  offerControl,TResult? Function( String playerId,  bool accepted)?  respondControl,TResult? Function( String playerId)?  revokeControl,TResult? Function( String playerId)?  removePlayer,TResult? Function()?  leaveRoom,TResult? Function()?  endGame,}) {final _that = this;
switch (_that) {
case UpdateSettings() when updateSettings != null:
return updateSettings(_that.settings);case CloseLobby() when closeLobby != null:
return closeLobby();case ReopenLobby() when reopenLobby != null:
return reopenLobby();case SetTurnOrder() when setTurnOrder != null:
return setTurnOrder(_that.playerIds);case ShuffleTurnOrder() when shuffleTurnOrder != null:
return shuffleTurnOrder();case ConfirmOrder() when confirmOrder != null:
return confirmOrder();case StartGame() when startGame != null:
return startGame();case AdjustStats() when adjustStats != null:
return adjustStats(_that.strengthDelta);case AdjustPlayerLevel() when adjustPlayerLevel != null:
return adjustPlayerLevel(_that.playerId,_that.delta);case EndTurn() when endTurn != null:
return endTurn();case StartBattle() when startBattle != null:
return startBattle();case DeclareVictory() when declareVictory != null:
return declareVictory();case Intervene() when intervene != null:
return intervene();case RequestHelp() when requestHelp != null:
return requestHelp();case ResumeBattle() when resumeBattle != null:
return resumeBattle();case StartEscape() when startEscape != null:
return startEscape();case ResolveEscape() when resolveEscape != null:
return resolveEscape();case RaiseLevel() when raiseLevel != null:
return raiseLevel();case FinishBattle() when finishBattle != null:
return finishBattle();case RollDice() when rollDice != null:
return rollDice();case RecordPhysicalRoll() when recordPhysicalRoll != null:
return recordPhysicalRoll(_that.value);case UseCheatDie() when useCheatDie != null:
return useCheatDie(_that.value);case AppealCheatDie() when appealCheatDie != null:
return appealCheatDie();case ResolveDiceAppeal() when resolveDiceAppeal != null:
return resolveDiceAppeal(_that.accepted);case OfferControl() when offerControl != null:
return offerControl(_that.playerId,_that.controllerPlayerId);case RespondControl() when respondControl != null:
return respondControl(_that.playerId,_that.accepted);case RevokeControl() when revokeControl != null:
return revokeControl(_that.playerId);case RemovePlayer() when removePlayer != null:
return removePlayer(_that.playerId);case LeaveRoom() when leaveRoom != null:
return leaveRoom();case EndGame() when endGame != null:
return endGame();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class UpdateSettings implements GameCommand {
  const UpdateSettings(this.settings, {final  String? $type}): $type = $type ?? 'UpdateSettings';
  factory UpdateSettings.fromJson(Map<String, dynamic> json) => _$UpdateSettingsFromJson(json);

 final  RoomSettings settings;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateSettingsCopyWith<UpdateSettings> get copyWith => _$UpdateSettingsCopyWithImpl<UpdateSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateSettings&&(identical(other.settings, settings) || other.settings == settings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,settings);

@override
String toString() {
  return 'GameCommand.updateSettings(settings: $settings)';
}


}

/// @nodoc
abstract mixin class $UpdateSettingsCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $UpdateSettingsCopyWith(UpdateSettings value, $Res Function(UpdateSettings) _then) = _$UpdateSettingsCopyWithImpl;
@useResult
$Res call({
 RoomSettings settings
});


$RoomSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$UpdateSettingsCopyWithImpl<$Res>
    implements $UpdateSettingsCopyWith<$Res> {
  _$UpdateSettingsCopyWithImpl(this._self, this._then);

  final UpdateSettings _self;
  final $Res Function(UpdateSettings) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(UpdateSettings(
null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as RoomSettings,
  ));
}

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomSettingsCopyWith<$Res> get settings {

  return $RoomSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class CloseLobby implements GameCommand {
  const CloseLobby({final  String? $type}): $type = $type ?? 'CloseLobby';
  factory CloseLobby.fromJson(Map<String, dynamic> json) => _$CloseLobbyFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$CloseLobbyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloseLobby);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.closeLobby()';
}


}




/// @nodoc
@JsonSerializable()

class ReopenLobby implements GameCommand {
  const ReopenLobby({final  String? $type}): $type = $type ?? 'ReopenLobby';
  factory ReopenLobby.fromJson(Map<String, dynamic> json) => _$ReopenLobbyFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ReopenLobbyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReopenLobby);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.reopenLobby()';
}


}




/// @nodoc
@JsonSerializable()

class SetTurnOrder implements GameCommand {
  const SetTurnOrder(final  List<String> playerIds, {final  String? $type}): _playerIds = playerIds,$type = $type ?? 'SetTurnOrder';
  factory SetTurnOrder.fromJson(Map<String, dynamic> json) => _$SetTurnOrderFromJson(json);

 final  List<String> _playerIds;
 List<String> get playerIds {
  if (_playerIds is EqualUnmodifiableListView) return _playerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playerIds);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetTurnOrderCopyWith<SetTurnOrder> get copyWith => _$SetTurnOrderCopyWithImpl<SetTurnOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetTurnOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetTurnOrder&&const DeepCollectionEquality().equals(other._playerIds, _playerIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_playerIds));

@override
String toString() {
  return 'GameCommand.setTurnOrder(playerIds: $playerIds)';
}


}

/// @nodoc
abstract mixin class $SetTurnOrderCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $SetTurnOrderCopyWith(SetTurnOrder value, $Res Function(SetTurnOrder) _then) = _$SetTurnOrderCopyWithImpl;
@useResult
$Res call({
 List<String> playerIds
});




}
/// @nodoc
class _$SetTurnOrderCopyWithImpl<$Res>
    implements $SetTurnOrderCopyWith<$Res> {
  _$SetTurnOrderCopyWithImpl(this._self, this._then);

  final SetTurnOrder _self;
  final $Res Function(SetTurnOrder) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerIds = null,}) {
  return _then(SetTurnOrder(
null == playerIds ? _self._playerIds : playerIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ShuffleTurnOrder implements GameCommand {
  const ShuffleTurnOrder({final  String? $type}): $type = $type ?? 'ShuffleTurnOrder';
  factory ShuffleTurnOrder.fromJson(Map<String, dynamic> json) => _$ShuffleTurnOrderFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ShuffleTurnOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShuffleTurnOrder);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.shuffleTurnOrder()';
}


}




/// @nodoc
@JsonSerializable()

class ConfirmOrder implements GameCommand {
  const ConfirmOrder({final  String? $type}): $type = $type ?? 'ConfirmOrder';
  factory ConfirmOrder.fromJson(Map<String, dynamic> json) => _$ConfirmOrderFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ConfirmOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmOrder);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.confirmOrder()';
}


}




/// @nodoc
@JsonSerializable()

class StartGame implements GameCommand {
  const StartGame({final  String? $type}): $type = $type ?? 'StartGame';
  factory StartGame.fromJson(Map<String, dynamic> json) => _$StartGameFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$StartGameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartGame);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.startGame()';
}


}




/// @nodoc
@JsonSerializable()

class AdjustStats implements GameCommand {
  const AdjustStats({this.strengthDelta = 0, final  String? $type}): $type = $type ?? 'AdjustStats';
  factory AdjustStats.fromJson(Map<String, dynamic> json) => _$AdjustStatsFromJson(json);

@JsonKey() final  int strengthDelta;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdjustStatsCopyWith<AdjustStats> get copyWith => _$AdjustStatsCopyWithImpl<AdjustStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdjustStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdjustStats&&(identical(other.strengthDelta, strengthDelta) || other.strengthDelta == strengthDelta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strengthDelta);

@override
String toString() {
  return 'GameCommand.adjustStats(strengthDelta: $strengthDelta)';
}


}

/// @nodoc
abstract mixin class $AdjustStatsCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $AdjustStatsCopyWith(AdjustStats value, $Res Function(AdjustStats) _then) = _$AdjustStatsCopyWithImpl;
@useResult
$Res call({
 int strengthDelta
});




}
/// @nodoc
class _$AdjustStatsCopyWithImpl<$Res>
    implements $AdjustStatsCopyWith<$Res> {
  _$AdjustStatsCopyWithImpl(this._self, this._then);

  final AdjustStats _self;
  final $Res Function(AdjustStats) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? strengthDelta = null,}) {
  return _then(AdjustStats(
strengthDelta: null == strengthDelta ? _self.strengthDelta : strengthDelta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AdjustPlayerLevel implements GameCommand {
  const AdjustPlayerLevel({required this.playerId, required this.delta, final  String? $type}): $type = $type ?? 'AdjustPlayerLevel';
  factory AdjustPlayerLevel.fromJson(Map<String, dynamic> json) => _$AdjustPlayerLevelFromJson(json);

 final  String playerId;
 final  int delta;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdjustPlayerLevelCopyWith<AdjustPlayerLevel> get copyWith => _$AdjustPlayerLevelCopyWithImpl<AdjustPlayerLevel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdjustPlayerLevelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdjustPlayerLevel&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,delta);

@override
String toString() {
  return 'GameCommand.adjustPlayerLevel(playerId: $playerId, delta: $delta)';
}


}

/// @nodoc
abstract mixin class $AdjustPlayerLevelCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $AdjustPlayerLevelCopyWith(AdjustPlayerLevel value, $Res Function(AdjustPlayerLevel) _then) = _$AdjustPlayerLevelCopyWithImpl;
@useResult
$Res call({
 String playerId, int delta
});




}
/// @nodoc
class _$AdjustPlayerLevelCopyWithImpl<$Res>
    implements $AdjustPlayerLevelCopyWith<$Res> {
  _$AdjustPlayerLevelCopyWithImpl(this._self, this._then);

  final AdjustPlayerLevel _self;
  final $Res Function(AdjustPlayerLevel) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? delta = null,}) {
  return _then(AdjustPlayerLevel(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EndTurn implements GameCommand {
  const EndTurn({final  String? $type}): $type = $type ?? 'EndTurn';
  factory EndTurn.fromJson(Map<String, dynamic> json) => _$EndTurnFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EndTurnToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EndTurn);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.endTurn()';
}


}




/// @nodoc
@JsonSerializable()

class StartBattle implements GameCommand {
  const StartBattle({final  String? $type}): $type = $type ?? 'StartBattle';
  factory StartBattle.fromJson(Map<String, dynamic> json) => _$StartBattleFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$StartBattleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartBattle);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.startBattle()';
}


}




/// @nodoc
@JsonSerializable()

class DeclareVictory implements GameCommand {
  const DeclareVictory({final  String? $type}): $type = $type ?? 'DeclareVictory';
  factory DeclareVictory.fromJson(Map<String, dynamic> json) => _$DeclareVictoryFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DeclareVictoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeclareVictory);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.declareVictory()';
}


}




/// @nodoc
@JsonSerializable()

class Intervene implements GameCommand {
  const Intervene({final  String? $type}): $type = $type ?? 'Intervene';
  factory Intervene.fromJson(Map<String, dynamic> json) => _$InterveneFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$InterveneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Intervene);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.intervene()';
}


}




/// @nodoc
@JsonSerializable()

class RequestHelp implements GameCommand {
  const RequestHelp({final  String? $type}): $type = $type ?? 'RequestHelp';
  factory RequestHelp.fromJson(Map<String, dynamic> json) => _$RequestHelpFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$RequestHelpToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestHelp);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.requestHelp()';
}


}




/// @nodoc
@JsonSerializable()

class ResumeBattle implements GameCommand {
  const ResumeBattle({final  String? $type}): $type = $type ?? 'ResumeBattle';
  factory ResumeBattle.fromJson(Map<String, dynamic> json) => _$ResumeBattleFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ResumeBattleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeBattle);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.resumeBattle()';
}


}




/// @nodoc
@JsonSerializable()

class StartEscape implements GameCommand {
  const StartEscape({final  String? $type}): $type = $type ?? 'StartEscape';
  factory StartEscape.fromJson(Map<String, dynamic> json) => _$StartEscapeFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$StartEscapeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartEscape);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.startEscape()';
}


}




/// @nodoc
@JsonSerializable()

class ResolveEscape implements GameCommand {
  const ResolveEscape({final  String? $type}): $type = $type ?? 'ResolveEscape';
  factory ResolveEscape.fromJson(Map<String, dynamic> json) => _$ResolveEscapeFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ResolveEscapeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResolveEscape);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.resolveEscape()';
}


}




/// @nodoc
@JsonSerializable()

class RaiseLevel implements GameCommand {
  const RaiseLevel({final  String? $type}): $type = $type ?? 'RaiseLevel';
  factory RaiseLevel.fromJson(Map<String, dynamic> json) => _$RaiseLevelFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$RaiseLevelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RaiseLevel);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.raiseLevel()';
}


}




/// @nodoc
@JsonSerializable()

class FinishBattle implements GameCommand {
  const FinishBattle({final  String? $type}): $type = $type ?? 'FinishBattle';
  factory FinishBattle.fromJson(Map<String, dynamic> json) => _$FinishBattleFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$FinishBattleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinishBattle);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.finishBattle()';
}


}




/// @nodoc
@JsonSerializable()

class RollDice implements GameCommand {
  const RollDice({final  String? $type}): $type = $type ?? 'RollDice';
  factory RollDice.fromJson(Map<String, dynamic> json) => _$RollDiceFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$RollDiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RollDice);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.rollDice()';
}


}




/// @nodoc
@JsonSerializable()

class RecordPhysicalRoll implements GameCommand {
  const RecordPhysicalRoll(this.value, {final  String? $type}): $type = $type ?? 'RecordPhysicalRoll';
  factory RecordPhysicalRoll.fromJson(Map<String, dynamic> json) => _$RecordPhysicalRollFromJson(json);

 final  int value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordPhysicalRollCopyWith<RecordPhysicalRoll> get copyWith => _$RecordPhysicalRollCopyWithImpl<RecordPhysicalRoll>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecordPhysicalRollToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordPhysicalRoll&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'GameCommand.recordPhysicalRoll(value: $value)';
}


}

/// @nodoc
abstract mixin class $RecordPhysicalRollCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $RecordPhysicalRollCopyWith(RecordPhysicalRoll value, $Res Function(RecordPhysicalRoll) _then) = _$RecordPhysicalRollCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$RecordPhysicalRollCopyWithImpl<$Res>
    implements $RecordPhysicalRollCopyWith<$Res> {
  _$RecordPhysicalRollCopyWithImpl(this._self, this._then);

  final RecordPhysicalRoll _self;
  final $Res Function(RecordPhysicalRoll) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(RecordPhysicalRoll(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UseCheatDie implements GameCommand {
  const UseCheatDie(this.value, {final  String? $type}): $type = $type ?? 'UseCheatDie';
  factory UseCheatDie.fromJson(Map<String, dynamic> json) => _$UseCheatDieFromJson(json);

 final  int value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UseCheatDieCopyWith<UseCheatDie> get copyWith => _$UseCheatDieCopyWithImpl<UseCheatDie>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UseCheatDieToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UseCheatDie&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'GameCommand.useCheatDie(value: $value)';
}


}

/// @nodoc
abstract mixin class $UseCheatDieCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $UseCheatDieCopyWith(UseCheatDie value, $Res Function(UseCheatDie) _then) = _$UseCheatDieCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$UseCheatDieCopyWithImpl<$Res>
    implements $UseCheatDieCopyWith<$Res> {
  _$UseCheatDieCopyWithImpl(this._self, this._then);

  final UseCheatDie _self;
  final $Res Function(UseCheatDie) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(UseCheatDie(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AppealCheatDie implements GameCommand {
  const AppealCheatDie({final  String? $type}): $type = $type ?? 'AppealCheatDie';
  factory AppealCheatDie.fromJson(Map<String, dynamic> json) => _$AppealCheatDieFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AppealCheatDieToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppealCheatDie);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.appealCheatDie()';
}


}




/// @nodoc
@JsonSerializable()

class ResolveDiceAppeal implements GameCommand {
  const ResolveDiceAppeal(this.accepted, {final  String? $type}): $type = $type ?? 'ResolveDiceAppeal';
  factory ResolveDiceAppeal.fromJson(Map<String, dynamic> json) => _$ResolveDiceAppealFromJson(json);

 final  bool accepted;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResolveDiceAppealCopyWith<ResolveDiceAppeal> get copyWith => _$ResolveDiceAppealCopyWithImpl<ResolveDiceAppeal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResolveDiceAppealToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResolveDiceAppeal&&(identical(other.accepted, accepted) || other.accepted == accepted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accepted);

@override
String toString() {
  return 'GameCommand.resolveDiceAppeal(accepted: $accepted)';
}


}

/// @nodoc
abstract mixin class $ResolveDiceAppealCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $ResolveDiceAppealCopyWith(ResolveDiceAppeal value, $Res Function(ResolveDiceAppeal) _then) = _$ResolveDiceAppealCopyWithImpl;
@useResult
$Res call({
 bool accepted
});




}
/// @nodoc
class _$ResolveDiceAppealCopyWithImpl<$Res>
    implements $ResolveDiceAppealCopyWith<$Res> {
  _$ResolveDiceAppealCopyWithImpl(this._self, this._then);

  final ResolveDiceAppeal _self;
  final $Res Function(ResolveDiceAppeal) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accepted = null,}) {
  return _then(ResolveDiceAppeal(
null == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OfferControl implements GameCommand {
  const OfferControl({required this.playerId, required this.controllerPlayerId, final  String? $type}): $type = $type ?? 'OfferControl';
  factory OfferControl.fromJson(Map<String, dynamic> json) => _$OfferControlFromJson(json);

 final  String playerId;
 final  String controllerPlayerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfferControlCopyWith<OfferControl> get copyWith => _$OfferControlCopyWithImpl<OfferControl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfferControlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfferControl&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.controllerPlayerId, controllerPlayerId) || other.controllerPlayerId == controllerPlayerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,controllerPlayerId);

@override
String toString() {
  return 'GameCommand.offerControl(playerId: $playerId, controllerPlayerId: $controllerPlayerId)';
}


}

/// @nodoc
abstract mixin class $OfferControlCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $OfferControlCopyWith(OfferControl value, $Res Function(OfferControl) _then) = _$OfferControlCopyWithImpl;
@useResult
$Res call({
 String playerId, String controllerPlayerId
});




}
/// @nodoc
class _$OfferControlCopyWithImpl<$Res>
    implements $OfferControlCopyWith<$Res> {
  _$OfferControlCopyWithImpl(this._self, this._then);

  final OfferControl _self;
  final $Res Function(OfferControl) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? controllerPlayerId = null,}) {
  return _then(OfferControl(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,controllerPlayerId: null == controllerPlayerId ? _self.controllerPlayerId : controllerPlayerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RespondControl implements GameCommand {
  const RespondControl({required this.playerId, required this.accepted, final  String? $type}): $type = $type ?? 'RespondControl';
  factory RespondControl.fromJson(Map<String, dynamic> json) => _$RespondControlFromJson(json);

 final  String playerId;
 final  bool accepted;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RespondControlCopyWith<RespondControl> get copyWith => _$RespondControlCopyWithImpl<RespondControl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RespondControlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RespondControl&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.accepted, accepted) || other.accepted == accepted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,accepted);

@override
String toString() {
  return 'GameCommand.respondControl(playerId: $playerId, accepted: $accepted)';
}


}

/// @nodoc
abstract mixin class $RespondControlCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $RespondControlCopyWith(RespondControl value, $Res Function(RespondControl) _then) = _$RespondControlCopyWithImpl;
@useResult
$Res call({
 String playerId, bool accepted
});




}
/// @nodoc
class _$RespondControlCopyWithImpl<$Res>
    implements $RespondControlCopyWith<$Res> {
  _$RespondControlCopyWithImpl(this._self, this._then);

  final RespondControl _self;
  final $Res Function(RespondControl) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? accepted = null,}) {
  return _then(RespondControl(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,accepted: null == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RevokeControl implements GameCommand {
  const RevokeControl(this.playerId, {final  String? $type}): $type = $type ?? 'RevokeControl';
  factory RevokeControl.fromJson(Map<String, dynamic> json) => _$RevokeControlFromJson(json);

 final  String playerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevokeControlCopyWith<RevokeControl> get copyWith => _$RevokeControlCopyWithImpl<RevokeControl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevokeControlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevokeControl&&(identical(other.playerId, playerId) || other.playerId == playerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId);

@override
String toString() {
  return 'GameCommand.revokeControl(playerId: $playerId)';
}


}

/// @nodoc
abstract mixin class $RevokeControlCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $RevokeControlCopyWith(RevokeControl value, $Res Function(RevokeControl) _then) = _$RevokeControlCopyWithImpl;
@useResult
$Res call({
 String playerId
});




}
/// @nodoc
class _$RevokeControlCopyWithImpl<$Res>
    implements $RevokeControlCopyWith<$Res> {
  _$RevokeControlCopyWithImpl(this._self, this._then);

  final RevokeControl _self;
  final $Res Function(RevokeControl) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,}) {
  return _then(RevokeControl(
null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RemovePlayer implements GameCommand {
  const RemovePlayer(this.playerId, {final  String? $type}): $type = $type ?? 'RemovePlayer';
  factory RemovePlayer.fromJson(Map<String, dynamic> json) => _$RemovePlayerFromJson(json);

 final  String playerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemovePlayerCopyWith<RemovePlayer> get copyWith => _$RemovePlayerCopyWithImpl<RemovePlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemovePlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemovePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId);

@override
String toString() {
  return 'GameCommand.removePlayer(playerId: $playerId)';
}


}

/// @nodoc
abstract mixin class $RemovePlayerCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $RemovePlayerCopyWith(RemovePlayer value, $Res Function(RemovePlayer) _then) = _$RemovePlayerCopyWithImpl;
@useResult
$Res call({
 String playerId
});




}
/// @nodoc
class _$RemovePlayerCopyWithImpl<$Res>
    implements $RemovePlayerCopyWith<$Res> {
  _$RemovePlayerCopyWithImpl(this._self, this._then);

  final RemovePlayer _self;
  final $Res Function(RemovePlayer) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,}) {
  return _then(RemovePlayer(
null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LeaveRoom implements GameCommand {
  const LeaveRoom({final  String? $type}): $type = $type ?? 'LeaveRoom';
  factory LeaveRoom.fromJson(Map<String, dynamic> json) => _$LeaveRoomFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$LeaveRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveRoom);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.leaveRoom()';
}


}




/// @nodoc
@JsonSerializable()

class EndGame implements GameCommand {
  const EndGame({final  String? $type}): $type = $type ?? 'EndGame';
  factory EndGame.fromJson(Map<String, dynamic> json) => _$EndGameFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EndGameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EndGame);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.endGame()';
}


}




// dart format on
