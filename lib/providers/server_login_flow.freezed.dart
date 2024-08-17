// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_login_flow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FlowState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(Map<String, String>? initial) ready,
    required TResult Function() checking,
    required TResult Function(ServerCheck check) checked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(Map<String, String>? initial)? ready,
    TResult? Function()? checking,
    TResult? Function(ServerCheck check)? checked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(Map<String, String>? initial)? ready,
    TResult Function()? checking,
    TResult Function(ServerCheck check)? checked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FSInitializing value) initializing,
    required TResult Function(FSReady value) ready,
    required TResult Function(FSChecking value) checking,
    required TResult Function(FSChecked value) checked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FSInitializing value)? initializing,
    TResult? Function(FSReady value)? ready,
    TResult? Function(FSChecking value)? checking,
    TResult? Function(FSChecked value)? checked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FSInitializing value)? initializing,
    TResult Function(FSReady value)? ready,
    TResult Function(FSChecking value)? checking,
    TResult Function(FSChecked value)? checked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowStateCopyWith<$Res> {
  factory $FlowStateCopyWith(FlowState value, $Res Function(FlowState) then) =
      _$FlowStateCopyWithImpl<$Res, FlowState>;
}

/// @nodoc
class _$FlowStateCopyWithImpl<$Res, $Val extends FlowState>
    implements $FlowStateCopyWith<$Res> {
  _$FlowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FSInitializingImplCopyWith<$Res> {
  factory _$$FSInitializingImplCopyWith(_$FSInitializingImpl value,
          $Res Function(_$FSInitializingImpl) then) =
      __$$FSInitializingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FSInitializingImplCopyWithImpl<$Res>
    extends _$FlowStateCopyWithImpl<$Res, _$FSInitializingImpl>
    implements _$$FSInitializingImplCopyWith<$Res> {
  __$$FSInitializingImplCopyWithImpl(
      _$FSInitializingImpl _value, $Res Function(_$FSInitializingImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FSInitializingImpl implements FSInitializing {
  const _$FSInitializingImpl();

  @override
  String toString() {
    return 'FlowState.initializing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FSInitializingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(Map<String, String>? initial) ready,
    required TResult Function() checking,
    required TResult Function(ServerCheck check) checked,
  }) {
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(Map<String, String>? initial)? ready,
    TResult? Function()? checking,
    TResult? Function(ServerCheck check)? checked,
  }) {
    return initializing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(Map<String, String>? initial)? ready,
    TResult Function()? checking,
    TResult Function(ServerCheck check)? checked,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FSInitializing value) initializing,
    required TResult Function(FSReady value) ready,
    required TResult Function(FSChecking value) checking,
    required TResult Function(FSChecked value) checked,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FSInitializing value)? initializing,
    TResult? Function(FSReady value)? ready,
    TResult? Function(FSChecking value)? checking,
    TResult? Function(FSChecked value)? checked,
  }) {
    return initializing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FSInitializing value)? initializing,
    TResult Function(FSReady value)? ready,
    TResult Function(FSChecking value)? checking,
    TResult Function(FSChecked value)? checked,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class FSInitializing implements FlowState {
  const factory FSInitializing() = _$FSInitializingImpl;
}

/// @nodoc
abstract class _$$FSReadyImplCopyWith<$Res> {
  factory _$$FSReadyImplCopyWith(
          _$FSReadyImpl value, $Res Function(_$FSReadyImpl) then) =
      __$$FSReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, String>? initial});
}

/// @nodoc
class __$$FSReadyImplCopyWithImpl<$Res>
    extends _$FlowStateCopyWithImpl<$Res, _$FSReadyImpl>
    implements _$$FSReadyImplCopyWith<$Res> {
  __$$FSReadyImplCopyWithImpl(
      _$FSReadyImpl _value, $Res Function(_$FSReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initial = freezed,
  }) {
    return _then(_$FSReadyImpl(
      freezed == initial
          ? _value._initial
          : initial // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc

class _$FSReadyImpl implements FSReady {
  const _$FSReadyImpl([final Map<String, String>? initial])
      : _initial = initial;

  final Map<String, String>? _initial;
  @override
  Map<String, String>? get initial {
    final value = _initial;
    if (value == null) return null;
    if (_initial is EqualUnmodifiableMapView) return _initial;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'FlowState.ready(initial: $initial)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FSReadyImpl &&
            const DeepCollectionEquality().equals(other._initial, _initial));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_initial));

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FSReadyImplCopyWith<_$FSReadyImpl> get copyWith =>
      __$$FSReadyImplCopyWithImpl<_$FSReadyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(Map<String, String>? initial) ready,
    required TResult Function() checking,
    required TResult Function(ServerCheck check) checked,
  }) {
    return ready(initial);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(Map<String, String>? initial)? ready,
    TResult? Function()? checking,
    TResult? Function(ServerCheck check)? checked,
  }) {
    return ready?.call(initial);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(Map<String, String>? initial)? ready,
    TResult Function()? checking,
    TResult Function(ServerCheck check)? checked,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(initial);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FSInitializing value) initializing,
    required TResult Function(FSReady value) ready,
    required TResult Function(FSChecking value) checking,
    required TResult Function(FSChecked value) checked,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FSInitializing value)? initializing,
    TResult? Function(FSReady value)? ready,
    TResult? Function(FSChecking value)? checking,
    TResult? Function(FSChecked value)? checked,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FSInitializing value)? initializing,
    TResult Function(FSReady value)? ready,
    TResult Function(FSChecking value)? checking,
    TResult Function(FSChecked value)? checked,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class FSReady implements FlowState {
  const factory FSReady([final Map<String, String>? initial]) = _$FSReadyImpl;

  Map<String, String>? get initial;

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FSReadyImplCopyWith<_$FSReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FSCheckingImplCopyWith<$Res> {
  factory _$$FSCheckingImplCopyWith(
          _$FSCheckingImpl value, $Res Function(_$FSCheckingImpl) then) =
      __$$FSCheckingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FSCheckingImplCopyWithImpl<$Res>
    extends _$FlowStateCopyWithImpl<$Res, _$FSCheckingImpl>
    implements _$$FSCheckingImplCopyWith<$Res> {
  __$$FSCheckingImplCopyWithImpl(
      _$FSCheckingImpl _value, $Res Function(_$FSCheckingImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FSCheckingImpl implements FSChecking {
  const _$FSCheckingImpl();

  @override
  String toString() {
    return 'FlowState.checking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FSCheckingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(Map<String, String>? initial) ready,
    required TResult Function() checking,
    required TResult Function(ServerCheck check) checked,
  }) {
    return checking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(Map<String, String>? initial)? ready,
    TResult? Function()? checking,
    TResult? Function(ServerCheck check)? checked,
  }) {
    return checking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(Map<String, String>? initial)? ready,
    TResult Function()? checking,
    TResult Function(ServerCheck check)? checked,
    required TResult orElse(),
  }) {
    if (checking != null) {
      return checking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FSInitializing value) initializing,
    required TResult Function(FSReady value) ready,
    required TResult Function(FSChecking value) checking,
    required TResult Function(FSChecked value) checked,
  }) {
    return checking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FSInitializing value)? initializing,
    TResult? Function(FSReady value)? ready,
    TResult? Function(FSChecking value)? checking,
    TResult? Function(FSChecked value)? checked,
  }) {
    return checking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FSInitializing value)? initializing,
    TResult Function(FSReady value)? ready,
    TResult Function(FSChecking value)? checking,
    TResult Function(FSChecked value)? checked,
    required TResult orElse(),
  }) {
    if (checking != null) {
      return checking(this);
    }
    return orElse();
  }
}

abstract class FSChecking implements FlowState {
  const factory FSChecking() = _$FSCheckingImpl;
}

/// @nodoc
abstract class _$$FSCheckedImplCopyWith<$Res> {
  factory _$$FSCheckedImplCopyWith(
          _$FSCheckedImpl value, $Res Function(_$FSCheckedImpl) then) =
      __$$FSCheckedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ServerCheck check});
}

/// @nodoc
class __$$FSCheckedImplCopyWithImpl<$Res>
    extends _$FlowStateCopyWithImpl<$Res, _$FSCheckedImpl>
    implements _$$FSCheckedImplCopyWith<$Res> {
  __$$FSCheckedImplCopyWithImpl(
      _$FSCheckedImpl _value, $Res Function(_$FSCheckedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? check = null,
  }) {
    return _then(_$FSCheckedImpl(
      null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as ServerCheck,
    ));
  }
}

/// @nodoc

class _$FSCheckedImpl implements FSChecked {
  const _$FSCheckedImpl(this.check);

  @override
  final ServerCheck check;

  @override
  String toString() {
    return 'FlowState.checked(check: $check)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FSCheckedImpl &&
            (identical(other.check, check) || other.check == check));
  }

  @override
  int get hashCode => Object.hash(runtimeType, check);

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FSCheckedImplCopyWith<_$FSCheckedImpl> get copyWith =>
      __$$FSCheckedImplCopyWithImpl<_$FSCheckedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(Map<String, String>? initial) ready,
    required TResult Function() checking,
    required TResult Function(ServerCheck check) checked,
  }) {
    return checked(check);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(Map<String, String>? initial)? ready,
    TResult? Function()? checking,
    TResult? Function(ServerCheck check)? checked,
  }) {
    return checked?.call(check);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(Map<String, String>? initial)? ready,
    TResult Function()? checking,
    TResult Function(ServerCheck check)? checked,
    required TResult orElse(),
  }) {
    if (checked != null) {
      return checked(check);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FSInitializing value) initializing,
    required TResult Function(FSReady value) ready,
    required TResult Function(FSChecking value) checking,
    required TResult Function(FSChecked value) checked,
  }) {
    return checked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FSInitializing value)? initializing,
    TResult? Function(FSReady value)? ready,
    TResult? Function(FSChecking value)? checking,
    TResult? Function(FSChecked value)? checked,
  }) {
    return checked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FSInitializing value)? initializing,
    TResult Function(FSReady value)? ready,
    TResult Function(FSChecking value)? checking,
    TResult Function(FSChecked value)? checked,
    required TResult orElse(),
  }) {
    if (checked != null) {
      return checked(this);
    }
    return orElse();
  }
}

abstract class FSChecked implements FlowState {
  const factory FSChecked(final ServerCheck check) = _$FSCheckedImpl;

  ServerCheck get check;

  /// Create a copy of FlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FSCheckedImplCopyWith<_$FSCheckedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
