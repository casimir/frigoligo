// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
