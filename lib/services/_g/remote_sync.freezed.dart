// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../remote_sync.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncState {

 bool get isWorking; double? get progressValue; Exception? get lastError; int get pendingCount;
/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStateCopyWith<SyncState> get copyWith => _$SyncStateCopyWithImpl<SyncState>(this as SyncState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncState&&(identical(other.isWorking, isWorking) || other.isWorking == isWorking)&&(identical(other.progressValue, progressValue) || other.progressValue == progressValue)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount));
}


@override
int get hashCode => Object.hash(runtimeType,isWorking,progressValue,lastError,pendingCount);

@override
String toString() {
  return 'SyncState(isWorking: $isWorking, progressValue: $progressValue, lastError: $lastError, pendingCount: $pendingCount)';
}


}

/// @nodoc
abstract mixin class $SyncStateCopyWith<$Res>  {
  factory $SyncStateCopyWith(SyncState value, $Res Function(SyncState) _then) = _$SyncStateCopyWithImpl;
@useResult
$Res call({
 bool isWorking, double? progressValue, Exception? lastError, int pendingCount
});




}
/// @nodoc
class _$SyncStateCopyWithImpl<$Res>
    implements $SyncStateCopyWith<$Res> {
  _$SyncStateCopyWithImpl(this._self, this._then);

  final SyncState _self;
  final $Res Function(SyncState) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isWorking = null,Object? progressValue = freezed,Object? lastError = freezed,Object? pendingCount = null,}) {
  return _then(_self.copyWith(
isWorking: null == isWorking ? _self.isWorking : isWorking // ignore: cast_nullable_to_non_nullable
as bool,progressValue: freezed == progressValue ? _self.progressValue : progressValue // ignore: cast_nullable_to_non_nullable
as double?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as Exception?,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _SyncState implements SyncState {
  const _SyncState({required this.isWorking, required this.progressValue, this.lastError = null, required this.pendingCount});
  

@override final  bool isWorking;
@override final  double? progressValue;
@override@JsonKey() final  Exception? lastError;
@override final  int pendingCount;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncStateCopyWith<_SyncState> get copyWith => __$SyncStateCopyWithImpl<_SyncState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncState&&(identical(other.isWorking, isWorking) || other.isWorking == isWorking)&&(identical(other.progressValue, progressValue) || other.progressValue == progressValue)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount));
}


@override
int get hashCode => Object.hash(runtimeType,isWorking,progressValue,lastError,pendingCount);

@override
String toString() {
  return 'SyncState(isWorking: $isWorking, progressValue: $progressValue, lastError: $lastError, pendingCount: $pendingCount)';
}


}

/// @nodoc
abstract mixin class _$SyncStateCopyWith<$Res> implements $SyncStateCopyWith<$Res> {
  factory _$SyncStateCopyWith(_SyncState value, $Res Function(_SyncState) _then) = __$SyncStateCopyWithImpl;
@override @useResult
$Res call({
 bool isWorking, double? progressValue, Exception? lastError, int pendingCount
});




}
/// @nodoc
class __$SyncStateCopyWithImpl<$Res>
    implements _$SyncStateCopyWith<$Res> {
  __$SyncStateCopyWithImpl(this._self, this._then);

  final _SyncState _self;
  final $Res Function(_SyncState) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isWorking = null,Object? progressValue = freezed,Object? lastError = freezed,Object? pendingCount = null,}) {
  return _then(_SyncState(
isWorking: null == isWorking ? _self.isWorking : isWorking // ignore: cast_nullable_to_non_nullable
as bool,progressValue: freezed == progressValue ? _self.progressValue : progressValue // ignore: cast_nullable_to_non_nullable
as double?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as Exception?,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
