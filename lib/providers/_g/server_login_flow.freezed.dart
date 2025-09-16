// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../server_login_flow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlowState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FlowState()';
}


}

/// @nodoc
class $FlowStateCopyWith<$Res>  {
$FlowStateCopyWith(FlowState _, $Res Function(FlowState) __);
}


/// Adds pattern-matching-related methods to [FlowState].
extension FlowStatePatterns on FlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FSInitializing value)?  initializing,TResult Function( FSReady value)?  ready,TResult Function( FSChecking value)?  checking,TResult Function( FSChecked value)?  checked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FSInitializing() when initializing != null:
return initializing(_that);case FSReady() when ready != null:
return ready(_that);case FSChecking() when checking != null:
return checking(_that);case FSChecked() when checked != null:
return checked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FSInitializing value)  initializing,required TResult Function( FSReady value)  ready,required TResult Function( FSChecking value)  checking,required TResult Function( FSChecked value)  checked,}){
final _that = this;
switch (_that) {
case FSInitializing():
return initializing(_that);case FSReady():
return ready(_that);case FSChecking():
return checking(_that);case FSChecked():
return checked(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FSInitializing value)?  initializing,TResult? Function( FSReady value)?  ready,TResult? Function( FSChecking value)?  checking,TResult? Function( FSChecked value)?  checked,}){
final _that = this;
switch (_that) {
case FSInitializing() when initializing != null:
return initializing(_that);case FSReady() when ready != null:
return ready(_that);case FSChecking() when checking != null:
return checking(_that);case FSChecked() when checked != null:
return checked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initializing,TResult Function( Map<String, String>? initial)?  ready,TResult Function()?  checking,TResult Function( ServerCheck check)?  checked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FSInitializing() when initializing != null:
return initializing();case FSReady() when ready != null:
return ready(_that.initial);case FSChecking() when checking != null:
return checking();case FSChecked() when checked != null:
return checked(_that.check);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initializing,required TResult Function( Map<String, String>? initial)  ready,required TResult Function()  checking,required TResult Function( ServerCheck check)  checked,}) {final _that = this;
switch (_that) {
case FSInitializing():
return initializing();case FSReady():
return ready(_that.initial);case FSChecking():
return checking();case FSChecked():
return checked(_that.check);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initializing,TResult? Function( Map<String, String>? initial)?  ready,TResult? Function()?  checking,TResult? Function( ServerCheck check)?  checked,}) {final _that = this;
switch (_that) {
case FSInitializing() when initializing != null:
return initializing();case FSReady() when ready != null:
return ready(_that.initial);case FSChecking() when checking != null:
return checking();case FSChecked() when checked != null:
return checked(_that.check);case _:
  return null;

}
}

}

/// @nodoc


class FSInitializing implements FlowState {
  const FSInitializing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FSInitializing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FlowState.initializing()';
}


}




/// @nodoc


class FSReady implements FlowState {
  const FSReady([final  Map<String, String>? initial]): _initial = initial;
  

 final  Map<String, String>? _initial;
 Map<String, String>? get initial {
  final value = _initial;
  if (value == null) return null;
  if (_initial is EqualUnmodifiableMapView) return _initial;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of FlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FSReadyCopyWith<FSReady> get copyWith => _$FSReadyCopyWithImpl<FSReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FSReady&&const DeepCollectionEquality().equals(other._initial, _initial));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_initial));

@override
String toString() {
  return 'FlowState.ready(initial: $initial)';
}


}

/// @nodoc
abstract mixin class $FSReadyCopyWith<$Res> implements $FlowStateCopyWith<$Res> {
  factory $FSReadyCopyWith(FSReady value, $Res Function(FSReady) _then) = _$FSReadyCopyWithImpl;
@useResult
$Res call({
 Map<String, String>? initial
});




}
/// @nodoc
class _$FSReadyCopyWithImpl<$Res>
    implements $FSReadyCopyWith<$Res> {
  _$FSReadyCopyWithImpl(this._self, this._then);

  final FSReady _self;
  final $Res Function(FSReady) _then;

/// Create a copy of FlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? initial = freezed,}) {
  return _then(FSReady(
freezed == initial ? _self._initial : initial // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

/// @nodoc


class FSChecking implements FlowState {
  const FSChecking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FSChecking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FlowState.checking()';
}


}




/// @nodoc


class FSChecked implements FlowState {
  const FSChecked(this.check);
  

 final  ServerCheck check;

/// Create a copy of FlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FSCheckedCopyWith<FSChecked> get copyWith => _$FSCheckedCopyWithImpl<FSChecked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FSChecked&&(identical(other.check, check) || other.check == check));
}


@override
int get hashCode => Object.hash(runtimeType,check);

@override
String toString() {
  return 'FlowState.checked(check: $check)';
}


}

/// @nodoc
abstract mixin class $FSCheckedCopyWith<$Res> implements $FlowStateCopyWith<$Res> {
  factory $FSCheckedCopyWith(FSChecked value, $Res Function(FSChecked) _then) = _$FSCheckedCopyWithImpl;
@useResult
$Res call({
 ServerCheck check
});




}
/// @nodoc
class _$FSCheckedCopyWithImpl<$Res>
    implements $FSCheckedCopyWith<$Res> {
  _$FSCheckedCopyWithImpl(this._self, this._then);

  final FSChecked _self;
  final $Res Function(FSChecked) _then;

/// Create a copy of FlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? check = null,}) {
  return _then(FSChecked(
null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as ServerCheck,
  ));
}


}

// dart format on
