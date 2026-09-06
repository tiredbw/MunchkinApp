// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomSettings {

 DiceMode get diceMode; int get minLevel; int get maxLevel; int get initialLevel; int get minStrength; int get maxStrength; int get initialStrength; int get victoryCountdownSeconds; bool get trackRaceClass;
/// Create a copy of RoomSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomSettingsCopyWith<RoomSettings> get copyWith => _$RoomSettingsCopyWithImpl<RoomSettings>(this as RoomSettings, _$identity);

  /// Serializes this RoomSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomSettings&&(identical(other.diceMode, diceMode) || other.diceMode == diceMode)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel)&&(identical(other.initialLevel, initialLevel) || other.initialLevel == initialLevel)&&(identical(other.minStrength, minStrength) || other.minStrength == minStrength)&&(identical(other.maxStrength, maxStrength) || other.maxStrength == maxStrength)&&(identical(other.initialStrength, initialStrength) || other.initialStrength == initialStrength)&&(identical(other.victoryCountdownSeconds, victoryCountdownSeconds) || other.victoryCountdownSeconds == victoryCountdownSeconds)&&(identical(other.trackRaceClass, trackRaceClass) || other.trackRaceClass == trackRaceClass));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diceMode,minLevel,maxLevel,initialLevel,minStrength,maxStrength,initialStrength,victoryCountdownSeconds,trackRaceClass);

@override
String toString() {
  return 'RoomSettings(diceMode: $diceMode, minLevel: $minLevel, maxLevel: $maxLevel, initialLevel: $initialLevel, minStrength: $minStrength, maxStrength: $maxStrength, initialStrength: $initialStrength, victoryCountdownSeconds: $victoryCountdownSeconds, trackRaceClass: $trackRaceClass)';
}


}

/// @nodoc
abstract mixin class $RoomSettingsCopyWith<$Res>  {
  factory $RoomSettingsCopyWith(RoomSettings value, $Res Function(RoomSettings) _then) = _$RoomSettingsCopyWithImpl;
@useResult
$Res call({
 DiceMode diceMode, int minLevel, int maxLevel, int initialLevel, int minStrength, int maxStrength, int initialStrength, int victoryCountdownSeconds, bool trackRaceClass
});




}
/// @nodoc
class _$RoomSettingsCopyWithImpl<$Res>
    implements $RoomSettingsCopyWith<$Res> {
  _$RoomSettingsCopyWithImpl(this._self, this._then);

  final RoomSettings _self;
  final $Res Function(RoomSettings) _then;

/// Create a copy of RoomSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? diceMode = null,Object? minLevel = null,Object? maxLevel = null,Object? initialLevel = null,Object? minStrength = null,Object? maxStrength = null,Object? initialStrength = null,Object? victoryCountdownSeconds = null,Object? trackRaceClass = null,}) {
  return _then(_self.copyWith(
diceMode: null == diceMode ? _self.diceMode : diceMode // ignore: cast_nullable_to_non_nullable
as DiceMode,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as int,maxLevel: null == maxLevel ? _self.maxLevel : maxLevel // ignore: cast_nullable_to_non_nullable
as int,initialLevel: null == initialLevel ? _self.initialLevel : initialLevel // ignore: cast_nullable_to_non_nullable
as int,minStrength: null == minStrength ? _self.minStrength : minStrength // ignore: cast_nullable_to_non_nullable
as int,maxStrength: null == maxStrength ? _self.maxStrength : maxStrength // ignore: cast_nullable_to_non_nullable
as int,initialStrength: null == initialStrength ? _self.initialStrength : initialStrength // ignore: cast_nullable_to_non_nullable
as int,victoryCountdownSeconds: null == victoryCountdownSeconds ? _self.victoryCountdownSeconds : victoryCountdownSeconds // ignore: cast_nullable_to_non_nullable
as int,trackRaceClass: null == trackRaceClass ? _self.trackRaceClass : trackRaceClass // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomSettings].
extension RoomSettingsPatterns on RoomSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomSettings() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomSettings value)  $default,){
final _that = this;
switch (_that) {
case _RoomSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomSettings value)?  $default,){
final _that = this;
switch (_that) {
case _RoomSettings() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DiceMode diceMode,  int minLevel,  int maxLevel,  int initialLevel,  int minStrength,  int maxStrength,  int initialStrength,  int victoryCountdownSeconds,  bool trackRaceClass)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomSettings() when $default != null:
return $default(_that.diceMode,_that.minLevel,_that.maxLevel,_that.initialLevel,_that.minStrength,_that.maxStrength,_that.initialStrength,_that.victoryCountdownSeconds,_that.trackRaceClass);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DiceMode diceMode,  int minLevel,  int maxLevel,  int initialLevel,  int minStrength,  int maxStrength,  int initialStrength,  int victoryCountdownSeconds,  bool trackRaceClass)  $default,) {final _that = this;
switch (_that) {
case _RoomSettings():
return $default(_that.diceMode,_that.minLevel,_that.maxLevel,_that.initialLevel,_that.minStrength,_that.maxStrength,_that.initialStrength,_that.victoryCountdownSeconds,_that.trackRaceClass);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DiceMode diceMode,  int minLevel,  int maxLevel,  int initialLevel,  int minStrength,  int maxStrength,  int initialStrength,  int victoryCountdownSeconds,  bool trackRaceClass)?  $default,) {final _that = this;
switch (_that) {
case _RoomSettings() when $default != null:
return $default(_that.diceMode,_that.minLevel,_that.maxLevel,_that.initialLevel,_that.minStrength,_that.maxStrength,_that.initialStrength,_that.victoryCountdownSeconds,_that.trackRaceClass);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomSettings implements RoomSettings {
  const _RoomSettings({this.diceMode = DiceMode.virtual, this.minLevel = 1, this.maxLevel = 10, this.initialLevel = 1, this.minStrength = -99, this.maxStrength = 99, this.initialStrength = 0, this.victoryCountdownSeconds = 5, this.trackRaceClass = true});
  factory _RoomSettings.fromJson(Map<String, dynamic> json) => _$RoomSettingsFromJson(json);

@override@JsonKey() final  DiceMode diceMode;
@override@JsonKey() final  int minLevel;
@override@JsonKey() final  int maxLevel;
@override@JsonKey() final  int initialLevel;
@override@JsonKey() final  int minStrength;
@override@JsonKey() final  int maxStrength;
@override@JsonKey() final  int initialStrength;
@override@JsonKey() final  int victoryCountdownSeconds;
@override@JsonKey() final  bool trackRaceClass;

/// Create a copy of RoomSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomSettingsCopyWith<_RoomSettings> get copyWith => __$RoomSettingsCopyWithImpl<_RoomSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomSettings&&(identical(other.diceMode, diceMode) || other.diceMode == diceMode)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel)&&(identical(other.initialLevel, initialLevel) || other.initialLevel == initialLevel)&&(identical(other.minStrength, minStrength) || other.minStrength == minStrength)&&(identical(other.maxStrength, maxStrength) || other.maxStrength == maxStrength)&&(identical(other.initialStrength, initialStrength) || other.initialStrength == initialStrength)&&(identical(other.victoryCountdownSeconds, victoryCountdownSeconds) || other.victoryCountdownSeconds == victoryCountdownSeconds)&&(identical(other.trackRaceClass, trackRaceClass) || other.trackRaceClass == trackRaceClass));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diceMode,minLevel,maxLevel,initialLevel,minStrength,maxStrength,initialStrength,victoryCountdownSeconds,trackRaceClass);

@override
String toString() {
  return 'RoomSettings(diceMode: $diceMode, minLevel: $minLevel, maxLevel: $maxLevel, initialLevel: $initialLevel, minStrength: $minStrength, maxStrength: $maxStrength, initialStrength: $initialStrength, victoryCountdownSeconds: $victoryCountdownSeconds, trackRaceClass: $trackRaceClass)';
}


}

/// @nodoc
abstract mixin class _$RoomSettingsCopyWith<$Res> implements $RoomSettingsCopyWith<$Res> {
  factory _$RoomSettingsCopyWith(_RoomSettings value, $Res Function(_RoomSettings) _then) = __$RoomSettingsCopyWithImpl;
@override @useResult
$Res call({
 DiceMode diceMode, int minLevel, int maxLevel, int initialLevel, int minStrength, int maxStrength, int initialStrength, int victoryCountdownSeconds, bool trackRaceClass
});




}
/// @nodoc
class __$RoomSettingsCopyWithImpl<$Res>
    implements _$RoomSettingsCopyWith<$Res> {
  __$RoomSettingsCopyWithImpl(this._self, this._then);

  final _RoomSettings _self;
  final $Res Function(_RoomSettings) _then;

/// Create a copy of RoomSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? diceMode = null,Object? minLevel = null,Object? maxLevel = null,Object? initialLevel = null,Object? minStrength = null,Object? maxStrength = null,Object? initialStrength = null,Object? victoryCountdownSeconds = null,Object? trackRaceClass = null,}) {
  return _then(_RoomSettings(
diceMode: null == diceMode ? _self.diceMode : diceMode // ignore: cast_nullable_to_non_nullable
as DiceMode,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as int,maxLevel: null == maxLevel ? _self.maxLevel : maxLevel // ignore: cast_nullable_to_non_nullable
as int,initialLevel: null == initialLevel ? _self.initialLevel : initialLevel // ignore: cast_nullable_to_non_nullable
as int,minStrength: null == minStrength ? _self.minStrength : minStrength // ignore: cast_nullable_to_non_nullable
as int,maxStrength: null == maxStrength ? _self.maxStrength : maxStrength // ignore: cast_nullable_to_non_nullable
as int,initialStrength: null == initialStrength ? _self.initialStrength : initialStrength // ignore: cast_nullable_to_non_nullable
as int,victoryCountdownSeconds: null == victoryCountdownSeconds ? _self.victoryCountdownSeconds : victoryCountdownSeconds // ignore: cast_nullable_to_non_nullable
as int,trackRaceClass: null == trackRaceClass ? _self.trackRaceClass : trackRaceClass // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Player {

 String get id; String get name; bool get isHost; int get level; int get strength; MunchkinRace get race; MunchkinClass get charClass; bool get isConnected; DateTime? get lastSeenAt;
/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerCopyWith<Player> get copyWith => _$PlayerCopyWithImpl<Player>(this as Player, _$identity);

  /// Serializes this Player to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Player&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isHost, isHost) || other.isHost == isHost)&&(identical(other.level, level) || other.level == level)&&(identical(other.strength, strength) || other.strength == strength)&&(identical(other.race, race) || other.race == race)&&(identical(other.charClass, charClass) || other.charClass == charClass)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isHost,level,strength,race,charClass,isConnected,lastSeenAt);

@override
String toString() {
  return 'Player(id: $id, name: $name, isHost: $isHost, level: $level, strength: $strength, race: $race, charClass: $charClass, isConnected: $isConnected, lastSeenAt: $lastSeenAt)';
}


}

/// @nodoc
abstract mixin class $PlayerCopyWith<$Res>  {
  factory $PlayerCopyWith(Player value, $Res Function(Player) _then) = _$PlayerCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool isHost, int level, int strength, MunchkinRace race, MunchkinClass charClass, bool isConnected, DateTime? lastSeenAt
});




}
/// @nodoc
class _$PlayerCopyWithImpl<$Res>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._self, this._then);

  final Player _self;
  final $Res Function(Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isHost = null,Object? level = null,Object? strength = null,Object? race = null,Object? charClass = null,Object? isConnected = null,Object? lastSeenAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isHost: null == isHost ? _self.isHost : isHost // ignore: cast_nullable_to_non_nullable
as bool,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,strength: null == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as int,race: null == race ? _self.race : race // ignore: cast_nullable_to_non_nullable
as MunchkinRace,charClass: null == charClass ? _self.charClass : charClass // ignore: cast_nullable_to_non_nullable
as MunchkinClass,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Player].
extension PlayerPatterns on Player {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Player value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Player value)  $default,){
final _that = this;
switch (_that) {
case _Player():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Player value)?  $default,){
final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool isHost,  int level,  int strength,  MunchkinRace race,  MunchkinClass charClass,  bool isConnected,  DateTime? lastSeenAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.name,_that.isHost,_that.level,_that.strength,_that.race,_that.charClass,_that.isConnected,_that.lastSeenAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool isHost,  int level,  int strength,  MunchkinRace race,  MunchkinClass charClass,  bool isConnected,  DateTime? lastSeenAt)  $default,) {final _that = this;
switch (_that) {
case _Player():
return $default(_that.id,_that.name,_that.isHost,_that.level,_that.strength,_that.race,_that.charClass,_that.isConnected,_that.lastSeenAt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool isHost,  int level,  int strength,  MunchkinRace race,  MunchkinClass charClass,  bool isConnected,  DateTime? lastSeenAt)?  $default,) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.name,_that.isHost,_that.level,_that.strength,_that.race,_that.charClass,_that.isConnected,_that.lastSeenAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Player extends Player {
  const _Player({required this.id, required this.name, required this.isHost, required this.level, required this.strength, this.race = MunchkinRace.none, this.charClass = MunchkinClass.none, this.isConnected = true, this.lastSeenAt}): super._();
  factory _Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

@override final  String id;
@override final  String name;
@override final  bool isHost;
@override final  int level;
@override final  int strength;
@override@JsonKey() final  MunchkinRace race;
@override@JsonKey() final  MunchkinClass charClass;
@override@JsonKey() final  bool isConnected;
@override final  DateTime? lastSeenAt;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerCopyWith<_Player> get copyWith => __$PlayerCopyWithImpl<_Player>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Player&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isHost, isHost) || other.isHost == isHost)&&(identical(other.level, level) || other.level == level)&&(identical(other.strength, strength) || other.strength == strength)&&(identical(other.race, race) || other.race == race)&&(identical(other.charClass, charClass) || other.charClass == charClass)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isHost,level,strength,race,charClass,isConnected,lastSeenAt);

@override
String toString() {
  return 'Player(id: $id, name: $name, isHost: $isHost, level: $level, strength: $strength, race: $race, charClass: $charClass, isConnected: $isConnected, lastSeenAt: $lastSeenAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) _then) = __$PlayerCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool isHost, int level, int strength, MunchkinRace race, MunchkinClass charClass, bool isConnected, DateTime? lastSeenAt
});




}
/// @nodoc
class __$PlayerCopyWithImpl<$Res>
    implements _$PlayerCopyWith<$Res> {
  __$PlayerCopyWithImpl(this._self, this._then);

  final _Player _self;
  final $Res Function(_Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isHost = null,Object? level = null,Object? strength = null,Object? race = null,Object? charClass = null,Object? isConnected = null,Object? lastSeenAt = freezed,}) {
  return _then(_Player(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isHost: null == isHost ? _self.isHost : isHost // ignore: cast_nullable_to_non_nullable
as bool,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,strength: null == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as int,race: null == race ? _self.race : race // ignore: cast_nullable_to_non_nullable
as MunchkinRace,charClass: null == charClass ? _self.charClass : charClass // ignore: cast_nullable_to_non_nullable
as MunchkinClass,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$BattleState {

 String get playerId; BattleStatus get status; DateTime? get endsAt; String? get intervenedBy;
/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BattleStateCopyWith<BattleState> get copyWith => _$BattleStateCopyWithImpl<BattleState>(this as BattleState, _$identity);

  /// Serializes this BattleState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BattleState&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.intervenedBy, intervenedBy) || other.intervenedBy == intervenedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,status,endsAt,intervenedBy);

@override
String toString() {
  return 'BattleState(playerId: $playerId, status: $status, endsAt: $endsAt, intervenedBy: $intervenedBy)';
}


}

/// @nodoc
abstract mixin class $BattleStateCopyWith<$Res>  {
  factory $BattleStateCopyWith(BattleState value, $Res Function(BattleState) _then) = _$BattleStateCopyWithImpl;
@useResult
$Res call({
 String playerId, BattleStatus status, DateTime? endsAt, String? intervenedBy
});




}
/// @nodoc
class _$BattleStateCopyWithImpl<$Res>
    implements $BattleStateCopyWith<$Res> {
  _$BattleStateCopyWithImpl(this._self, this._then);

  final BattleState _self;
  final $Res Function(BattleState) _then;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? status = null,Object? endsAt = freezed,Object? intervenedBy = freezed,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BattleStatus,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,intervenedBy: freezed == intervenedBy ? _self.intervenedBy : intervenedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BattleState].
extension BattleStatePatterns on BattleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BattleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BattleState value)  $default,){
final _that = this;
switch (_that) {
case _BattleState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BattleState value)?  $default,){
final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  BattleStatus status,  DateTime? endsAt,  String? intervenedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that.playerId,_that.status,_that.endsAt,_that.intervenedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  BattleStatus status,  DateTime? endsAt,  String? intervenedBy)  $default,) {final _that = this;
switch (_that) {
case _BattleState():
return $default(_that.playerId,_that.status,_that.endsAt,_that.intervenedBy);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  BattleStatus status,  DateTime? endsAt,  String? intervenedBy)?  $default,) {final _that = this;
switch (_that) {
case _BattleState() when $default != null:
return $default(_that.playerId,_that.status,_that.endsAt,_that.intervenedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BattleState implements BattleState {
  const _BattleState({required this.playerId, this.status = BattleStatus.fighting, this.endsAt, this.intervenedBy});
  factory _BattleState.fromJson(Map<String, dynamic> json) => _$BattleStateFromJson(json);

@override final  String playerId;
@override@JsonKey() final  BattleStatus status;
@override final  DateTime? endsAt;
@override final  String? intervenedBy;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BattleStateCopyWith<_BattleState> get copyWith => __$BattleStateCopyWithImpl<_BattleState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BattleStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BattleState&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.intervenedBy, intervenedBy) || other.intervenedBy == intervenedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,status,endsAt,intervenedBy);

@override
String toString() {
  return 'BattleState(playerId: $playerId, status: $status, endsAt: $endsAt, intervenedBy: $intervenedBy)';
}


}

/// @nodoc
abstract mixin class _$BattleStateCopyWith<$Res> implements $BattleStateCopyWith<$Res> {
  factory _$BattleStateCopyWith(_BattleState value, $Res Function(_BattleState) _then) = __$BattleStateCopyWithImpl;
@override @useResult
$Res call({
 String playerId, BattleStatus status, DateTime? endsAt, String? intervenedBy
});




}
/// @nodoc
class __$BattleStateCopyWithImpl<$Res>
    implements _$BattleStateCopyWith<$Res> {
  __$BattleStateCopyWithImpl(this._self, this._then);

  final _BattleState _self;
  final $Res Function(_BattleState) _then;

/// Create a copy of BattleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? status = null,Object? endsAt = freezed,Object? intervenedBy = freezed,}) {
  return _then(_BattleState(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BattleStatus,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,intervenedBy: freezed == intervenedBy ? _self.intervenedBy : intervenedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DiceRoll {

 String get id; String get playerId; int get value; int get sides; DateTime get rolledAt;
/// Create a copy of DiceRoll
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiceRollCopyWith<DiceRoll> get copyWith => _$DiceRollCopyWithImpl<DiceRoll>(this as DiceRoll, _$identity);

  /// Serializes this DiceRoll to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiceRoll&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.value, value) || other.value == value)&&(identical(other.sides, sides) || other.sides == sides)&&(identical(other.rolledAt, rolledAt) || other.rolledAt == rolledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playerId,value,sides,rolledAt);

@override
String toString() {
  return 'DiceRoll(id: $id, playerId: $playerId, value: $value, sides: $sides, rolledAt: $rolledAt)';
}


}

/// @nodoc
abstract mixin class $DiceRollCopyWith<$Res>  {
  factory $DiceRollCopyWith(DiceRoll value, $Res Function(DiceRoll) _then) = _$DiceRollCopyWithImpl;
@useResult
$Res call({
 String id, String playerId, int value, int sides, DateTime rolledAt
});




}
/// @nodoc
class _$DiceRollCopyWithImpl<$Res>
    implements $DiceRollCopyWith<$Res> {
  _$DiceRollCopyWithImpl(this._self, this._then);

  final DiceRoll _self;
  final $Res Function(DiceRoll) _then;

/// Create a copy of DiceRoll
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? value = null,Object? sides = null,Object? rolledAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,sides: null == sides ? _self.sides : sides // ignore: cast_nullable_to_non_nullable
as int,rolledAt: null == rolledAt ? _self.rolledAt : rolledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DiceRoll].
extension DiceRollPatterns on DiceRoll {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiceRoll value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiceRoll() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiceRoll value)  $default,){
final _that = this;
switch (_that) {
case _DiceRoll():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiceRoll value)?  $default,){
final _that = this;
switch (_that) {
case _DiceRoll() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId,  int value,  int sides,  DateTime rolledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiceRoll() when $default != null:
return $default(_that.id,_that.playerId,_that.value,_that.sides,_that.rolledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId,  int value,  int sides,  DateTime rolledAt)  $default,) {final _that = this;
switch (_that) {
case _DiceRoll():
return $default(_that.id,_that.playerId,_that.value,_that.sides,_that.rolledAt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId,  int value,  int sides,  DateTime rolledAt)?  $default,) {final _that = this;
switch (_that) {
case _DiceRoll() when $default != null:
return $default(_that.id,_that.playerId,_that.value,_that.sides,_that.rolledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiceRoll implements DiceRoll {
  const _DiceRoll({required this.id, required this.playerId, required this.value, this.sides = 6, required this.rolledAt});
  factory _DiceRoll.fromJson(Map<String, dynamic> json) => _$DiceRollFromJson(json);

@override final  String id;
@override final  String playerId;
@override final  int value;
@override@JsonKey() final  int sides;
@override final  DateTime rolledAt;

/// Create a copy of DiceRoll
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiceRollCopyWith<_DiceRoll> get copyWith => __$DiceRollCopyWithImpl<_DiceRoll>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiceRollToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiceRoll&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.value, value) || other.value == value)&&(identical(other.sides, sides) || other.sides == sides)&&(identical(other.rolledAt, rolledAt) || other.rolledAt == rolledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playerId,value,sides,rolledAt);

@override
String toString() {
  return 'DiceRoll(id: $id, playerId: $playerId, value: $value, sides: $sides, rolledAt: $rolledAt)';
}


}

/// @nodoc
abstract mixin class _$DiceRollCopyWith<$Res> implements $DiceRollCopyWith<$Res> {
  factory _$DiceRollCopyWith(_DiceRoll value, $Res Function(_DiceRoll) _then) = __$DiceRollCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId, int value, int sides, DateTime rolledAt
});




}
/// @nodoc
class __$DiceRollCopyWithImpl<$Res>
    implements _$DiceRollCopyWith<$Res> {
  __$DiceRollCopyWithImpl(this._self, this._then);

  final _DiceRoll _self;
  final $Res Function(_DiceRoll) _then;

/// Create a copy of DiceRoll
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? value = null,Object? sides = null,Object? rolledAt = null,}) {
  return _then(_DiceRoll(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,sides: null == sides ? _self.sides : sides // ignore: cast_nullable_to_non_nullable
as int,rolledAt: null == rolledAt ? _self.rolledAt : rolledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$GameState {

 int get schemaVersion; String get roomId; int get revision; RoomSettings get settings; RoomPhase get phase; List<Player> get players; List<String> get turnOrder; String? get activePlayerId; BattleState? get battle; DiceRoll? get lastDiceRoll; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateCopyWith<GameState> get copyWith => _$GameStateCopyWithImpl<GameState>(this as GameState, _$identity);

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameState&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.phase, phase) || other.phase == phase)&&const DeepCollectionEquality().equals(other.players, players)&&const DeepCollectionEquality().equals(other.turnOrder, turnOrder)&&(identical(other.activePlayerId, activePlayerId) || other.activePlayerId == activePlayerId)&&(identical(other.battle, battle) || other.battle == battle)&&(identical(other.lastDiceRoll, lastDiceRoll) || other.lastDiceRoll == lastDiceRoll)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,roomId,revision,settings,phase,const DeepCollectionEquality().hash(players),const DeepCollectionEquality().hash(turnOrder),activePlayerId,battle,lastDiceRoll,createdAt,updatedAt);

@override
String toString() {
  return 'GameState(schemaVersion: $schemaVersion, roomId: $roomId, revision: $revision, settings: $settings, phase: $phase, players: $players, turnOrder: $turnOrder, activePlayerId: $activePlayerId, battle: $battle, lastDiceRoll: $lastDiceRoll, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GameStateCopyWith<$Res>  {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) _then) = _$GameStateCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String roomId, int revision, RoomSettings settings, RoomPhase phase, List<Player> players, List<String> turnOrder, String? activePlayerId, BattleState? battle, DiceRoll? lastDiceRoll, DateTime createdAt, DateTime updatedAt
});


$RoomSettingsCopyWith<$Res> get settings;$BattleStateCopyWith<$Res>? get battle;$DiceRollCopyWith<$Res>? get lastDiceRoll;

}
/// @nodoc
class _$GameStateCopyWithImpl<$Res>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._self, this._then);

  final GameState _self;
  final $Res Function(GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? roomId = null,Object? revision = null,Object? settings = null,Object? phase = null,Object? players = null,Object? turnOrder = null,Object? activePlayerId = freezed,Object? battle = freezed,Object? lastDiceRoll = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as RoomSettings,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as RoomPhase,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<Player>,turnOrder: null == turnOrder ? _self.turnOrder : turnOrder // ignore: cast_nullable_to_non_nullable
as List<String>,activePlayerId: freezed == activePlayerId ? _self.activePlayerId : activePlayerId // ignore: cast_nullable_to_non_nullable
as String?,battle: freezed == battle ? _self.battle : battle // ignore: cast_nullable_to_non_nullable
as BattleState?,lastDiceRoll: freezed == lastDiceRoll ? _self.lastDiceRoll : lastDiceRoll // ignore: cast_nullable_to_non_nullable
as DiceRoll?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomSettingsCopyWith<$Res> get settings {
  
  return $RoomSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BattleStateCopyWith<$Res>? get battle {
    if (_self.battle == null) {
    return null;
  }

  return $BattleStateCopyWith<$Res>(_self.battle!, (value) {
    return _then(_self.copyWith(battle: value));
  });
}/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiceRollCopyWith<$Res>? get lastDiceRoll {
    if (_self.lastDiceRoll == null) {
    return null;
  }

  return $DiceRollCopyWith<$Res>(_self.lastDiceRoll!, (value) {
    return _then(_self.copyWith(lastDiceRoll: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameState].
extension GameStatePatterns on GameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameState value)  $default,){
final _that = this;
switch (_that) {
case _GameState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameState value)?  $default,){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String roomId,  int revision,  RoomSettings settings,  RoomPhase phase,  List<Player> players,  List<String> turnOrder,  String? activePlayerId,  BattleState? battle,  DiceRoll? lastDiceRoll,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.schemaVersion,_that.roomId,_that.revision,_that.settings,_that.phase,_that.players,_that.turnOrder,_that.activePlayerId,_that.battle,_that.lastDiceRoll,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String roomId,  int revision,  RoomSettings settings,  RoomPhase phase,  List<Player> players,  List<String> turnOrder,  String? activePlayerId,  BattleState? battle,  DiceRoll? lastDiceRoll,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GameState():
return $default(_that.schemaVersion,_that.roomId,_that.revision,_that.settings,_that.phase,_that.players,_that.turnOrder,_that.activePlayerId,_that.battle,_that.lastDiceRoll,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String roomId,  int revision,  RoomSettings settings,  RoomPhase phase,  List<Player> players,  List<String> turnOrder,  String? activePlayerId,  BattleState? battle,  DiceRoll? lastDiceRoll,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.schemaVersion,_that.roomId,_that.revision,_that.settings,_that.phase,_that.players,_that.turnOrder,_that.activePlayerId,_that.battle,_that.lastDiceRoll,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameState extends GameState {
  const _GameState({this.schemaVersion = 1, required this.roomId, this.revision = 0, required this.settings, this.phase = RoomPhase.lobby, final  List<Player> players = const <Player>[], final  List<String> turnOrder = const <String>[], this.activePlayerId, this.battle, this.lastDiceRoll, required this.createdAt, required this.updatedAt}): _players = players,_turnOrder = turnOrder,super._();
  factory _GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

@override@JsonKey() final  int schemaVersion;
@override final  String roomId;
@override@JsonKey() final  int revision;
@override final  RoomSettings settings;
@override@JsonKey() final  RoomPhase phase;
 final  List<Player> _players;
@override@JsonKey() List<Player> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

 final  List<String> _turnOrder;
@override@JsonKey() List<String> get turnOrder {
  if (_turnOrder is EqualUnmodifiableListView) return _turnOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_turnOrder);
}

@override final  String? activePlayerId;
@override final  BattleState? battle;
@override final  DiceRoll? lastDiceRoll;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateCopyWith<_GameState> get copyWith => __$GameStateCopyWithImpl<_GameState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameState&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.phase, phase) || other.phase == phase)&&const DeepCollectionEquality().equals(other._players, _players)&&const DeepCollectionEquality().equals(other._turnOrder, _turnOrder)&&(identical(other.activePlayerId, activePlayerId) || other.activePlayerId == activePlayerId)&&(identical(other.battle, battle) || other.battle == battle)&&(identical(other.lastDiceRoll, lastDiceRoll) || other.lastDiceRoll == lastDiceRoll)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,roomId,revision,settings,phase,const DeepCollectionEquality().hash(_players),const DeepCollectionEquality().hash(_turnOrder),activePlayerId,battle,lastDiceRoll,createdAt,updatedAt);

@override
String toString() {
  return 'GameState(schemaVersion: $schemaVersion, roomId: $roomId, revision: $revision, settings: $settings, phase: $phase, players: $players, turnOrder: $turnOrder, activePlayerId: $activePlayerId, battle: $battle, lastDiceRoll: $lastDiceRoll, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(_GameState value, $Res Function(_GameState) _then) = __$GameStateCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String roomId, int revision, RoomSettings settings, RoomPhase phase, List<Player> players, List<String> turnOrder, String? activePlayerId, BattleState? battle, DiceRoll? lastDiceRoll, DateTime createdAt, DateTime updatedAt
});


@override $RoomSettingsCopyWith<$Res> get settings;@override $BattleStateCopyWith<$Res>? get battle;@override $DiceRollCopyWith<$Res>? get lastDiceRoll;

}
/// @nodoc
class __$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(this._self, this._then);

  final _GameState _self;
  final $Res Function(_GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? roomId = null,Object? revision = null,Object? settings = null,Object? phase = null,Object? players = null,Object? turnOrder = null,Object? activePlayerId = freezed,Object? battle = freezed,Object? lastDiceRoll = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_GameState(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as RoomSettings,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as RoomPhase,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<Player>,turnOrder: null == turnOrder ? _self._turnOrder : turnOrder // ignore: cast_nullable_to_non_nullable
as List<String>,activePlayerId: freezed == activePlayerId ? _self.activePlayerId : activePlayerId // ignore: cast_nullable_to_non_nullable
as String?,battle: freezed == battle ? _self.battle : battle // ignore: cast_nullable_to_non_nullable
as BattleState?,lastDiceRoll: freezed == lastDiceRoll ? _self.lastDiceRoll : lastDiceRoll // ignore: cast_nullable_to_non_nullable
as DiceRoll?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomSettingsCopyWith<$Res> get settings {
  
  return $RoomSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BattleStateCopyWith<$Res>? get battle {
    if (_self.battle == null) {
    return null;
  }

  return $BattleStateCopyWith<$Res>(_self.battle!, (value) {
    return _then(_self.copyWith(battle: value));
  });
}/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiceRollCopyWith<$Res>? get lastDiceRoll {
    if (_self.lastDiceRoll == null) {
    return null;
  }

  return $DiceRollCopyWith<$Res>(_self.lastDiceRoll!, (value) {
    return _then(_self.copyWith(lastDiceRoll: value));
  });
}
}

// dart format on
