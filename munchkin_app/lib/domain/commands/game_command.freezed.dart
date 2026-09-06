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
                  case 'JoinPlayer':
          return JoinPlayer.fromJson(
            json
          );
                case 'SetConnection':
          return SetConnection.fromJson(
            json
          );
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
                case 'SetIdentity':
          return SetIdentity.fromJson(
            json
          );
                case 'EndTurn':
          return EndTurn.fromJson(
            json
          );
                case 'OpenDoor':
          return OpenDoor.fromJson(
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
                case 'RewardHelper':
          return RewardHelper.fromJson(
            json
          );
                case 'FinishBattle':
          return FinishBattle.fromJson(
            json
          );
                case 'DieInBattle':
          return DieInBattle.fromJson(
            json
          );
                case 'RollDice':
          return RollDice.fromJson(
            json
          );
                case 'AddLocalPlayer':
          return AddLocalPlayer.fromJson(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JoinPlayer value)?  joinPlayer,TResult Function( SetConnection value)?  setConnection,TResult Function( UpdateSettings value)?  updateSettings,TResult Function( CloseLobby value)?  closeLobby,TResult Function( ReopenLobby value)?  reopenLobby,TResult Function( SetTurnOrder value)?  setTurnOrder,TResult Function( ShuffleTurnOrder value)?  shuffleTurnOrder,TResult Function( ConfirmOrder value)?  confirmOrder,TResult Function( StartGame value)?  startGame,TResult Function( AdjustStats value)?  adjustStats,TResult Function( SetIdentity value)?  setIdentity,TResult Function( EndTurn value)?  endTurn,TResult Function( OpenDoor value)?  openDoor,TResult Function( StartBattle value)?  startBattle,TResult Function( DeclareVictory value)?  declareVictory,TResult Function( Intervene value)?  intervene,TResult Function( RequestHelp value)?  requestHelp,TResult Function( ResumeBattle value)?  resumeBattle,TResult Function( StartEscape value)?  startEscape,TResult Function( ResolveEscape value)?  resolveEscape,TResult Function( RaiseLevel value)?  raiseLevel,TResult Function( RewardHelper value)?  rewardHelper,TResult Function( FinishBattle value)?  finishBattle,TResult Function( DieInBattle value)?  dieInBattle,TResult Function( RollDice value)?  rollDice,TResult Function( AddLocalPlayer value)?  addLocalPlayer,TResult Function( RemovePlayer value)?  removePlayer,TResult Function( LeaveRoom value)?  leaveRoom,TResult Function( EndGame value)?  endGame,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JoinPlayer() when joinPlayer != null:
return joinPlayer(_that);case SetConnection() when setConnection != null:
return setConnection(_that);case UpdateSettings() when updateSettings != null:
return updateSettings(_that);case CloseLobby() when closeLobby != null:
return closeLobby(_that);case ReopenLobby() when reopenLobby != null:
return reopenLobby(_that);case SetTurnOrder() when setTurnOrder != null:
return setTurnOrder(_that);case ShuffleTurnOrder() when shuffleTurnOrder != null:
return shuffleTurnOrder(_that);case ConfirmOrder() when confirmOrder != null:
return confirmOrder(_that);case StartGame() when startGame != null:
return startGame(_that);case AdjustStats() when adjustStats != null:
return adjustStats(_that);case SetIdentity() when setIdentity != null:
return setIdentity(_that);case EndTurn() when endTurn != null:
return endTurn(_that);case OpenDoor() when openDoor != null:
return openDoor(_that);case StartBattle() when startBattle != null:
return startBattle(_that);case DeclareVictory() when declareVictory != null:
return declareVictory(_that);case Intervene() when intervene != null:
return intervene(_that);case RequestHelp() when requestHelp != null:
return requestHelp(_that);case ResumeBattle() when resumeBattle != null:
return resumeBattle(_that);case StartEscape() when startEscape != null:
return startEscape(_that);case ResolveEscape() when resolveEscape != null:
return resolveEscape(_that);case RaiseLevel() when raiseLevel != null:
return raiseLevel(_that);case RewardHelper() when rewardHelper != null:
return rewardHelper(_that);case FinishBattle() when finishBattle != null:
return finishBattle(_that);case DieInBattle() when dieInBattle != null:
return dieInBattle(_that);case RollDice() when rollDice != null:
return rollDice(_that);case AddLocalPlayer() when addLocalPlayer != null:
return addLocalPlayer(_that);case RemovePlayer() when removePlayer != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JoinPlayer value)  joinPlayer,required TResult Function( SetConnection value)  setConnection,required TResult Function( UpdateSettings value)  updateSettings,required TResult Function( CloseLobby value)  closeLobby,required TResult Function( ReopenLobby value)  reopenLobby,required TResult Function( SetTurnOrder value)  setTurnOrder,required TResult Function( ShuffleTurnOrder value)  shuffleTurnOrder,required TResult Function( ConfirmOrder value)  confirmOrder,required TResult Function( StartGame value)  startGame,required TResult Function( AdjustStats value)  adjustStats,required TResult Function( SetIdentity value)  setIdentity,required TResult Function( EndTurn value)  endTurn,required TResult Function( OpenDoor value)  openDoor,required TResult Function( StartBattle value)  startBattle,required TResult Function( DeclareVictory value)  declareVictory,required TResult Function( Intervene value)  intervene,required TResult Function( RequestHelp value)  requestHelp,required TResult Function( ResumeBattle value)  resumeBattle,required TResult Function( StartEscape value)  startEscape,required TResult Function( ResolveEscape value)  resolveEscape,required TResult Function( RaiseLevel value)  raiseLevel,required TResult Function( RewardHelper value)  rewardHelper,required TResult Function( FinishBattle value)  finishBattle,required TResult Function( DieInBattle value)  dieInBattle,required TResult Function( RollDice value)  rollDice,required TResult Function( AddLocalPlayer value)  addLocalPlayer,required TResult Function( RemovePlayer value)  removePlayer,required TResult Function( LeaveRoom value)  leaveRoom,required TResult Function( EndGame value)  endGame,}){
final _that = this;
switch (_that) {
case JoinPlayer():
return joinPlayer(_that);case SetConnection():
return setConnection(_that);case UpdateSettings():
return updateSettings(_that);case CloseLobby():
return closeLobby(_that);case ReopenLobby():
return reopenLobby(_that);case SetTurnOrder():
return setTurnOrder(_that);case ShuffleTurnOrder():
return shuffleTurnOrder(_that);case ConfirmOrder():
return confirmOrder(_that);case StartGame():
return startGame(_that);case AdjustStats():
return adjustStats(_that);case SetIdentity():
return setIdentity(_that);case EndTurn():
return endTurn(_that);case OpenDoor():
return openDoor(_that);case StartBattle():
return startBattle(_that);case DeclareVictory():
return declareVictory(_that);case Intervene():
return intervene(_that);case RequestHelp():
return requestHelp(_that);case ResumeBattle():
return resumeBattle(_that);case StartEscape():
return startEscape(_that);case ResolveEscape():
return resolveEscape(_that);case RaiseLevel():
return raiseLevel(_that);case RewardHelper():
return rewardHelper(_that);case FinishBattle():
return finishBattle(_that);case DieInBattle():
return dieInBattle(_that);case RollDice():
return rollDice(_that);case AddLocalPlayer():
return addLocalPlayer(_that);case RemovePlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JoinPlayer value)?  joinPlayer,TResult? Function( SetConnection value)?  setConnection,TResult? Function( UpdateSettings value)?  updateSettings,TResult? Function( CloseLobby value)?  closeLobby,TResult? Function( ReopenLobby value)?  reopenLobby,TResult? Function( SetTurnOrder value)?  setTurnOrder,TResult? Function( ShuffleTurnOrder value)?  shuffleTurnOrder,TResult? Function( ConfirmOrder value)?  confirmOrder,TResult? Function( StartGame value)?  startGame,TResult? Function( AdjustStats value)?  adjustStats,TResult? Function( SetIdentity value)?  setIdentity,TResult? Function( EndTurn value)?  endTurn,TResult? Function( OpenDoor value)?  openDoor,TResult? Function( StartBattle value)?  startBattle,TResult? Function( DeclareVictory value)?  declareVictory,TResult? Function( Intervene value)?  intervene,TResult? Function( RequestHelp value)?  requestHelp,TResult? Function( ResumeBattle value)?  resumeBattle,TResult? Function( StartEscape value)?  startEscape,TResult? Function( ResolveEscape value)?  resolveEscape,TResult? Function( RaiseLevel value)?  raiseLevel,TResult? Function( RewardHelper value)?  rewardHelper,TResult? Function( FinishBattle value)?  finishBattle,TResult? Function( DieInBattle value)?  dieInBattle,TResult? Function( RollDice value)?  rollDice,TResult? Function( AddLocalPlayer value)?  addLocalPlayer,TResult? Function( RemovePlayer value)?  removePlayer,TResult? Function( LeaveRoom value)?  leaveRoom,TResult? Function( EndGame value)?  endGame,}){
final _that = this;
switch (_that) {
case JoinPlayer() when joinPlayer != null:
return joinPlayer(_that);case SetConnection() when setConnection != null:
return setConnection(_that);case UpdateSettings() when updateSettings != null:
return updateSettings(_that);case CloseLobby() when closeLobby != null:
return closeLobby(_that);case ReopenLobby() when reopenLobby != null:
return reopenLobby(_that);case SetTurnOrder() when setTurnOrder != null:
return setTurnOrder(_that);case ShuffleTurnOrder() when shuffleTurnOrder != null:
return shuffleTurnOrder(_that);case ConfirmOrder() when confirmOrder != null:
return confirmOrder(_that);case StartGame() when startGame != null:
return startGame(_that);case AdjustStats() when adjustStats != null:
return adjustStats(_that);case SetIdentity() when setIdentity != null:
return setIdentity(_that);case EndTurn() when endTurn != null:
return endTurn(_that);case OpenDoor() when openDoor != null:
return openDoor(_that);case StartBattle() when startBattle != null:
return startBattle(_that);case DeclareVictory() when declareVictory != null:
return declareVictory(_that);case Intervene() when intervene != null:
return intervene(_that);case RequestHelp() when requestHelp != null:
return requestHelp(_that);case ResumeBattle() when resumeBattle != null:
return resumeBattle(_that);case StartEscape() when startEscape != null:
return startEscape(_that);case ResolveEscape() when resolveEscape != null:
return resolveEscape(_that);case RaiseLevel() when raiseLevel != null:
return raiseLevel(_that);case RewardHelper() when rewardHelper != null:
return rewardHelper(_that);case FinishBattle() when finishBattle != null:
return finishBattle(_that);case DieInBattle() when dieInBattle != null:
return dieInBattle(_that);case RollDice() when rollDice != null:
return rollDice(_that);case AddLocalPlayer() when addLocalPlayer != null:
return addLocalPlayer(_that);case RemovePlayer() when removePlayer != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String playerId,  String name,  bool isHost)?  joinPlayer,TResult Function( String playerId,  bool connected)?  setConnection,TResult Function( RoomSettings settings)?  updateSettings,TResult Function()?  closeLobby,TResult Function()?  reopenLobby,TResult Function( List<String> playerIds)?  setTurnOrder,TResult Function()?  shuffleTurnOrder,TResult Function()?  confirmOrder,TResult Function()?  startGame,TResult Function( int levelDelta,  int strengthDelta)?  adjustStats,TResult Function( List<MunchkinRace> races,  List<MunchkinClass> classes)?  setIdentity,TResult Function()?  endTurn,TResult Function()?  openDoor,TResult Function()?  startBattle,TResult Function()?  declareVictory,TResult Function()?  intervene,TResult Function()?  requestHelp,TResult Function()?  resumeBattle,TResult Function()?  startEscape,TResult Function()?  resolveEscape,TResult Function()?  raiseLevel,TResult Function( String playerId)?  rewardHelper,TResult Function()?  finishBattle,TResult Function()?  dieInBattle,TResult Function()?  rollDice,TResult Function( String name)?  addLocalPlayer,TResult Function( String playerId)?  removePlayer,TResult Function()?  leaveRoom,TResult Function()?  endGame,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JoinPlayer() when joinPlayer != null:
return joinPlayer(_that.playerId,_that.name,_that.isHost);case SetConnection() when setConnection != null:
return setConnection(_that.playerId,_that.connected);case UpdateSettings() when updateSettings != null:
return updateSettings(_that.settings);case CloseLobby() when closeLobby != null:
return closeLobby();case ReopenLobby() when reopenLobby != null:
return reopenLobby();case SetTurnOrder() when setTurnOrder != null:
return setTurnOrder(_that.playerIds);case ShuffleTurnOrder() when shuffleTurnOrder != null:
return shuffleTurnOrder();case ConfirmOrder() when confirmOrder != null:
return confirmOrder();case StartGame() when startGame != null:
return startGame();case AdjustStats() when adjustStats != null:
return adjustStats(_that.levelDelta,_that.strengthDelta);case SetIdentity() when setIdentity != null:
return setIdentity(_that.races,_that.classes);case EndTurn() when endTurn != null:
return endTurn();case OpenDoor() when openDoor != null:
return openDoor();case StartBattle() when startBattle != null:
return startBattle();case DeclareVictory() when declareVictory != null:
return declareVictory();case Intervene() when intervene != null:
return intervene();case RequestHelp() when requestHelp != null:
return requestHelp();case ResumeBattle() when resumeBattle != null:
return resumeBattle();case StartEscape() when startEscape != null:
return startEscape();case ResolveEscape() when resolveEscape != null:
return resolveEscape();case RaiseLevel() when raiseLevel != null:
return raiseLevel();case RewardHelper() when rewardHelper != null:
return rewardHelper(_that.playerId);case FinishBattle() when finishBattle != null:
return finishBattle();case DieInBattle() when dieInBattle != null:
return dieInBattle();case RollDice() when rollDice != null:
return rollDice();case AddLocalPlayer() when addLocalPlayer != null:
return addLocalPlayer(_that.name);case RemovePlayer() when removePlayer != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String playerId,  String name,  bool isHost)  joinPlayer,required TResult Function( String playerId,  bool connected)  setConnection,required TResult Function( RoomSettings settings)  updateSettings,required TResult Function()  closeLobby,required TResult Function()  reopenLobby,required TResult Function( List<String> playerIds)  setTurnOrder,required TResult Function()  shuffleTurnOrder,required TResult Function()  confirmOrder,required TResult Function()  startGame,required TResult Function( int levelDelta,  int strengthDelta)  adjustStats,required TResult Function( List<MunchkinRace> races,  List<MunchkinClass> classes)  setIdentity,required TResult Function()  endTurn,required TResult Function()  openDoor,required TResult Function()  startBattle,required TResult Function()  declareVictory,required TResult Function()  intervene,required TResult Function()  requestHelp,required TResult Function()  resumeBattle,required TResult Function()  startEscape,required TResult Function()  resolveEscape,required TResult Function()  raiseLevel,required TResult Function( String playerId)  rewardHelper,required TResult Function()  finishBattle,required TResult Function()  dieInBattle,required TResult Function()  rollDice,required TResult Function( String name)  addLocalPlayer,required TResult Function( String playerId)  removePlayer,required TResult Function()  leaveRoom,required TResult Function()  endGame,}) {final _that = this;
switch (_that) {
case JoinPlayer():
return joinPlayer(_that.playerId,_that.name,_that.isHost);case SetConnection():
return setConnection(_that.playerId,_that.connected);case UpdateSettings():
return updateSettings(_that.settings);case CloseLobby():
return closeLobby();case ReopenLobby():
return reopenLobby();case SetTurnOrder():
return setTurnOrder(_that.playerIds);case ShuffleTurnOrder():
return shuffleTurnOrder();case ConfirmOrder():
return confirmOrder();case StartGame():
return startGame();case AdjustStats():
return adjustStats(_that.levelDelta,_that.strengthDelta);case SetIdentity():
return setIdentity(_that.races,_that.classes);case EndTurn():
return endTurn();case OpenDoor():
return openDoor();case StartBattle():
return startBattle();case DeclareVictory():
return declareVictory();case Intervene():
return intervene();case RequestHelp():
return requestHelp();case ResumeBattle():
return resumeBattle();case StartEscape():
return startEscape();case ResolveEscape():
return resolveEscape();case RaiseLevel():
return raiseLevel();case RewardHelper():
return rewardHelper(_that.playerId);case FinishBattle():
return finishBattle();case DieInBattle():
return dieInBattle();case RollDice():
return rollDice();case AddLocalPlayer():
return addLocalPlayer(_that.name);case RemovePlayer():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String playerId,  String name,  bool isHost)?  joinPlayer,TResult? Function( String playerId,  bool connected)?  setConnection,TResult? Function( RoomSettings settings)?  updateSettings,TResult? Function()?  closeLobby,TResult? Function()?  reopenLobby,TResult? Function( List<String> playerIds)?  setTurnOrder,TResult? Function()?  shuffleTurnOrder,TResult? Function()?  confirmOrder,TResult? Function()?  startGame,TResult? Function( int levelDelta,  int strengthDelta)?  adjustStats,TResult? Function( List<MunchkinRace> races,  List<MunchkinClass> classes)?  setIdentity,TResult? Function()?  endTurn,TResult? Function()?  openDoor,TResult? Function()?  startBattle,TResult? Function()?  declareVictory,TResult? Function()?  intervene,TResult? Function()?  requestHelp,TResult? Function()?  resumeBattle,TResult? Function()?  startEscape,TResult? Function()?  resolveEscape,TResult? Function()?  raiseLevel,TResult? Function( String playerId)?  rewardHelper,TResult? Function()?  finishBattle,TResult? Function()?  dieInBattle,TResult? Function()?  rollDice,TResult? Function( String name)?  addLocalPlayer,TResult? Function( String playerId)?  removePlayer,TResult? Function()?  leaveRoom,TResult? Function()?  endGame,}) {final _that = this;
switch (_that) {
case JoinPlayer() when joinPlayer != null:
return joinPlayer(_that.playerId,_that.name,_that.isHost);case SetConnection() when setConnection != null:
return setConnection(_that.playerId,_that.connected);case UpdateSettings() when updateSettings != null:
return updateSettings(_that.settings);case CloseLobby() when closeLobby != null:
return closeLobby();case ReopenLobby() when reopenLobby != null:
return reopenLobby();case SetTurnOrder() when setTurnOrder != null:
return setTurnOrder(_that.playerIds);case ShuffleTurnOrder() when shuffleTurnOrder != null:
return shuffleTurnOrder();case ConfirmOrder() when confirmOrder != null:
return confirmOrder();case StartGame() when startGame != null:
return startGame();case AdjustStats() when adjustStats != null:
return adjustStats(_that.levelDelta,_that.strengthDelta);case SetIdentity() when setIdentity != null:
return setIdentity(_that.races,_that.classes);case EndTurn() when endTurn != null:
return endTurn();case OpenDoor() when openDoor != null:
return openDoor();case StartBattle() when startBattle != null:
return startBattle();case DeclareVictory() when declareVictory != null:
return declareVictory();case Intervene() when intervene != null:
return intervene();case RequestHelp() when requestHelp != null:
return requestHelp();case ResumeBattle() when resumeBattle != null:
return resumeBattle();case StartEscape() when startEscape != null:
return startEscape();case ResolveEscape() when resolveEscape != null:
return resolveEscape();case RaiseLevel() when raiseLevel != null:
return raiseLevel();case RewardHelper() when rewardHelper != null:
return rewardHelper(_that.playerId);case FinishBattle() when finishBattle != null:
return finishBattle();case DieInBattle() when dieInBattle != null:
return dieInBattle();case RollDice() when rollDice != null:
return rollDice();case AddLocalPlayer() when addLocalPlayer != null:
return addLocalPlayer(_that.name);case RemovePlayer() when removePlayer != null:
return removePlayer(_that.playerId);case LeaveRoom() when leaveRoom != null:
return leaveRoom();case EndGame() when endGame != null:
return endGame();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class JoinPlayer implements GameCommand {
  const JoinPlayer({required this.playerId, required this.name, this.isHost = false, final  String? $type}): $type = $type ?? 'JoinPlayer';
  factory JoinPlayer.fromJson(Map<String, dynamic> json) => _$JoinPlayerFromJson(json);

 final  String playerId;
 final  String name;
@JsonKey() final  bool isHost;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinPlayerCopyWith<JoinPlayer> get copyWith => _$JoinPlayerCopyWithImpl<JoinPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinPlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.isHost, isHost) || other.isHost == isHost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,isHost);

@override
String toString() {
  return 'GameCommand.joinPlayer(playerId: $playerId, name: $name, isHost: $isHost)';
}


}

/// @nodoc
abstract mixin class $JoinPlayerCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $JoinPlayerCopyWith(JoinPlayer value, $Res Function(JoinPlayer) _then) = _$JoinPlayerCopyWithImpl;
@useResult
$Res call({
 String playerId, String name, bool isHost
});




}
/// @nodoc
class _$JoinPlayerCopyWithImpl<$Res>
    implements $JoinPlayerCopyWith<$Res> {
  _$JoinPlayerCopyWithImpl(this._self, this._then);

  final JoinPlayer _self;
  final $Res Function(JoinPlayer) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? name = null,Object? isHost = null,}) {
  return _then(JoinPlayer(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isHost: null == isHost ? _self.isHost : isHost // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SetConnection implements GameCommand {
  const SetConnection({required this.playerId, required this.connected, final  String? $type}): $type = $type ?? 'SetConnection';
  factory SetConnection.fromJson(Map<String, dynamic> json) => _$SetConnectionFromJson(json);

 final  String playerId;
 final  bool connected;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetConnectionCopyWith<SetConnection> get copyWith => _$SetConnectionCopyWithImpl<SetConnection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetConnectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetConnection&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.connected, connected) || other.connected == connected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,connected);

@override
String toString() {
  return 'GameCommand.setConnection(playerId: $playerId, connected: $connected)';
}


}

/// @nodoc
abstract mixin class $SetConnectionCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $SetConnectionCopyWith(SetConnection value, $Res Function(SetConnection) _then) = _$SetConnectionCopyWithImpl;
@useResult
$Res call({
 String playerId, bool connected
});




}
/// @nodoc
class _$SetConnectionCopyWithImpl<$Res>
    implements $SetConnectionCopyWith<$Res> {
  _$SetConnectionCopyWithImpl(this._self, this._then);

  final SetConnection _self;
  final $Res Function(SetConnection) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? connected = null,}) {
  return _then(SetConnection(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
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
  const AdjustStats({this.levelDelta = 0, this.strengthDelta = 0, final  String? $type}): $type = $type ?? 'AdjustStats';
  factory AdjustStats.fromJson(Map<String, dynamic> json) => _$AdjustStatsFromJson(json);

@JsonKey() final  int levelDelta;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdjustStats&&(identical(other.levelDelta, levelDelta) || other.levelDelta == levelDelta)&&(identical(other.strengthDelta, strengthDelta) || other.strengthDelta == strengthDelta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,levelDelta,strengthDelta);

@override
String toString() {
  return 'GameCommand.adjustStats(levelDelta: $levelDelta, strengthDelta: $strengthDelta)';
}


}

/// @nodoc
abstract mixin class $AdjustStatsCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $AdjustStatsCopyWith(AdjustStats value, $Res Function(AdjustStats) _then) = _$AdjustStatsCopyWithImpl;
@useResult
$Res call({
 int levelDelta, int strengthDelta
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
@pragma('vm:prefer-inline') $Res call({Object? levelDelta = null,Object? strengthDelta = null,}) {
  return _then(AdjustStats(
levelDelta: null == levelDelta ? _self.levelDelta : levelDelta // ignore: cast_nullable_to_non_nullable
as int,strengthDelta: null == strengthDelta ? _self.strengthDelta : strengthDelta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SetIdentity implements GameCommand {
  const SetIdentity({required final  List<MunchkinRace> races, required final  List<MunchkinClass> classes, final  String? $type}): _races = races,_classes = classes,$type = $type ?? 'SetIdentity';
  factory SetIdentity.fromJson(Map<String, dynamic> json) => _$SetIdentityFromJson(json);

 final  List<MunchkinRace> _races;
 List<MunchkinRace> get races {
  if (_races is EqualUnmodifiableListView) return _races;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_races);
}

 final  List<MunchkinClass> _classes;
 List<MunchkinClass> get classes {
  if (_classes is EqualUnmodifiableListView) return _classes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_classes);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetIdentityCopyWith<SetIdentity> get copyWith => _$SetIdentityCopyWithImpl<SetIdentity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetIdentityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetIdentity&&const DeepCollectionEquality().equals(other._races, _races)&&const DeepCollectionEquality().equals(other._classes, _classes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_races),const DeepCollectionEquality().hash(_classes));

@override
String toString() {
  return 'GameCommand.setIdentity(races: $races, classes: $classes)';
}


}

/// @nodoc
abstract mixin class $SetIdentityCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $SetIdentityCopyWith(SetIdentity value, $Res Function(SetIdentity) _then) = _$SetIdentityCopyWithImpl;
@useResult
$Res call({
 List<MunchkinRace> races, List<MunchkinClass> classes
});




}
/// @nodoc
class _$SetIdentityCopyWithImpl<$Res>
    implements $SetIdentityCopyWith<$Res> {
  _$SetIdentityCopyWithImpl(this._self, this._then);

  final SetIdentity _self;
  final $Res Function(SetIdentity) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? races = null,Object? classes = null,}) {
  return _then(SetIdentity(
races: null == races ? _self._races : races // ignore: cast_nullable_to_non_nullable
as List<MunchkinRace>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<MunchkinClass>,
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

class OpenDoor implements GameCommand {
  const OpenDoor({final  String? $type}): $type = $type ?? 'OpenDoor';
  factory OpenDoor.fromJson(Map<String, dynamic> json) => _$OpenDoorFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$OpenDoorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenDoor);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.openDoor()';
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

class RewardHelper implements GameCommand {
  const RewardHelper(this.playerId, {final  String? $type}): $type = $type ?? 'RewardHelper';
  factory RewardHelper.fromJson(Map<String, dynamic> json) => _$RewardHelperFromJson(json);

 final  String playerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardHelperCopyWith<RewardHelper> get copyWith => _$RewardHelperCopyWithImpl<RewardHelper>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardHelperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardHelper&&(identical(other.playerId, playerId) || other.playerId == playerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId);

@override
String toString() {
  return 'GameCommand.rewardHelper(playerId: $playerId)';
}


}

/// @nodoc
abstract mixin class $RewardHelperCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $RewardHelperCopyWith(RewardHelper value, $Res Function(RewardHelper) _then) = _$RewardHelperCopyWithImpl;
@useResult
$Res call({
 String playerId
});




}
/// @nodoc
class _$RewardHelperCopyWithImpl<$Res>
    implements $RewardHelperCopyWith<$Res> {
  _$RewardHelperCopyWithImpl(this._self, this._then);

  final RewardHelper _self;
  final $Res Function(RewardHelper) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,}) {
  return _then(RewardHelper(
null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
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

class DieInBattle implements GameCommand {
  const DieInBattle({final  String? $type}): $type = $type ?? 'DieInBattle';
  factory DieInBattle.fromJson(Map<String, dynamic> json) => _$DieInBattleFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DieInBattleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DieInBattle);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameCommand.dieInBattle()';
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

class AddLocalPlayer implements GameCommand {
  const AddLocalPlayer({required this.name, final  String? $type}): $type = $type ?? 'AddLocalPlayer';
  factory AddLocalPlayer.fromJson(Map<String, dynamic> json) => _$AddLocalPlayerFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddLocalPlayerCopyWith<AddLocalPlayer> get copyWith => _$AddLocalPlayerCopyWithImpl<AddLocalPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddLocalPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddLocalPlayer&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'GameCommand.addLocalPlayer(name: $name)';
}


}

/// @nodoc
abstract mixin class $AddLocalPlayerCopyWith<$Res> implements $GameCommandCopyWith<$Res> {
  factory $AddLocalPlayerCopyWith(AddLocalPlayer value, $Res Function(AddLocalPlayer) _then) = _$AddLocalPlayerCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$AddLocalPlayerCopyWithImpl<$Res>
    implements $AddLocalPlayerCopyWith<$Res> {
  _$AddLocalPlayerCopyWithImpl(this._self, this._then);

  final AddLocalPlayer _self;
  final $Res Function(AddLocalPlayer) _then;

/// Create a copy of GameCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(AddLocalPlayer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
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
