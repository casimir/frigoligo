// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SaveArticleState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() postponed,
    required TResult Function(int articleId) success,
    required TResult Function(Object e) error,
    required TResult Function(Uri? parsed) errorDubiousUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? postponed,
    TResult? Function(int articleId)? success,
    TResult? Function(Object e)? error,
    TResult? Function(Uri? parsed)? errorDubiousUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? postponed,
    TResult Function(int articleId)? success,
    TResult Function(Object e)? error,
    TResult Function(Uri? parsed)? errorDubiousUrl,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SASPending value) pending,
    required TResult Function(SASPostponed value) postponed,
    required TResult Function(SASSuccess value) success,
    required TResult Function(SASError value) error,
    required TResult Function(SASErrorDubiousUrl value) errorDubiousUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SASPending value)? pending,
    TResult? Function(SASPostponed value)? postponed,
    TResult? Function(SASSuccess value)? success,
    TResult? Function(SASError value)? error,
    TResult? Function(SASErrorDubiousUrl value)? errorDubiousUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SASPending value)? pending,
    TResult Function(SASPostponed value)? postponed,
    TResult Function(SASSuccess value)? success,
    TResult Function(SASError value)? error,
    TResult Function(SASErrorDubiousUrl value)? errorDubiousUrl,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveArticleStateCopyWith<$Res> {
  factory $SaveArticleStateCopyWith(
          SaveArticleState value, $Res Function(SaveArticleState) then) =
      _$SaveArticleStateCopyWithImpl<$Res, SaveArticleState>;
}

/// @nodoc
class _$SaveArticleStateCopyWithImpl<$Res, $Val extends SaveArticleState>
    implements $SaveArticleStateCopyWith<$Res> {
  _$SaveArticleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SASPendingImplCopyWith<$Res> {
  factory _$$SASPendingImplCopyWith(
          _$SASPendingImpl value, $Res Function(_$SASPendingImpl) then) =
      __$$SASPendingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SASPendingImplCopyWithImpl<$Res>
    extends _$SaveArticleStateCopyWithImpl<$Res, _$SASPendingImpl>
    implements _$$SASPendingImplCopyWith<$Res> {
  __$$SASPendingImplCopyWithImpl(
      _$SASPendingImpl _value, $Res Function(_$SASPendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SASPendingImpl with DiagnosticableTreeMixin implements SASPending {
  const _$SASPendingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SaveArticleState.pending()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'SaveArticleState.pending'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SASPendingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() postponed,
    required TResult Function(int articleId) success,
    required TResult Function(Object e) error,
    required TResult Function(Uri? parsed) errorDubiousUrl,
  }) {
    return pending();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? postponed,
    TResult? Function(int articleId)? success,
    TResult? Function(Object e)? error,
    TResult? Function(Uri? parsed)? errorDubiousUrl,
  }) {
    return pending?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? postponed,
    TResult Function(int articleId)? success,
    TResult Function(Object e)? error,
    TResult Function(Uri? parsed)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SASPending value) pending,
    required TResult Function(SASPostponed value) postponed,
    required TResult Function(SASSuccess value) success,
    required TResult Function(SASError value) error,
    required TResult Function(SASErrorDubiousUrl value) errorDubiousUrl,
  }) {
    return pending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SASPending value)? pending,
    TResult? Function(SASPostponed value)? postponed,
    TResult? Function(SASSuccess value)? success,
    TResult? Function(SASError value)? error,
    TResult? Function(SASErrorDubiousUrl value)? errorDubiousUrl,
  }) {
    return pending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SASPending value)? pending,
    TResult Function(SASPostponed value)? postponed,
    TResult Function(SASSuccess value)? success,
    TResult Function(SASError value)? error,
    TResult Function(SASErrorDubiousUrl value)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending(this);
    }
    return orElse();
  }
}

abstract class SASPending implements SaveArticleState {
  const factory SASPending() = _$SASPendingImpl;
}

/// @nodoc
abstract class _$$SASPostponedImplCopyWith<$Res> {
  factory _$$SASPostponedImplCopyWith(
          _$SASPostponedImpl value, $Res Function(_$SASPostponedImpl) then) =
      __$$SASPostponedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SASPostponedImplCopyWithImpl<$Res>
    extends _$SaveArticleStateCopyWithImpl<$Res, _$SASPostponedImpl>
    implements _$$SASPostponedImplCopyWith<$Res> {
  __$$SASPostponedImplCopyWithImpl(
      _$SASPostponedImpl _value, $Res Function(_$SASPostponedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SASPostponedImpl with DiagnosticableTreeMixin implements SASPostponed {
  const _$SASPostponedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SaveArticleState.postponed()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'SaveArticleState.postponed'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SASPostponedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() postponed,
    required TResult Function(int articleId) success,
    required TResult Function(Object e) error,
    required TResult Function(Uri? parsed) errorDubiousUrl,
  }) {
    return postponed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? postponed,
    TResult? Function(int articleId)? success,
    TResult? Function(Object e)? error,
    TResult? Function(Uri? parsed)? errorDubiousUrl,
  }) {
    return postponed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? postponed,
    TResult Function(int articleId)? success,
    TResult Function(Object e)? error,
    TResult Function(Uri? parsed)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (postponed != null) {
      return postponed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SASPending value) pending,
    required TResult Function(SASPostponed value) postponed,
    required TResult Function(SASSuccess value) success,
    required TResult Function(SASError value) error,
    required TResult Function(SASErrorDubiousUrl value) errorDubiousUrl,
  }) {
    return postponed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SASPending value)? pending,
    TResult? Function(SASPostponed value)? postponed,
    TResult? Function(SASSuccess value)? success,
    TResult? Function(SASError value)? error,
    TResult? Function(SASErrorDubiousUrl value)? errorDubiousUrl,
  }) {
    return postponed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SASPending value)? pending,
    TResult Function(SASPostponed value)? postponed,
    TResult Function(SASSuccess value)? success,
    TResult Function(SASError value)? error,
    TResult Function(SASErrorDubiousUrl value)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (postponed != null) {
      return postponed(this);
    }
    return orElse();
  }
}

abstract class SASPostponed implements SaveArticleState {
  const factory SASPostponed() = _$SASPostponedImpl;
}

/// @nodoc
abstract class _$$SASSuccessImplCopyWith<$Res> {
  factory _$$SASSuccessImplCopyWith(
          _$SASSuccessImpl value, $Res Function(_$SASSuccessImpl) then) =
      __$$SASSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int articleId});
}

/// @nodoc
class __$$SASSuccessImplCopyWithImpl<$Res>
    extends _$SaveArticleStateCopyWithImpl<$Res, _$SASSuccessImpl>
    implements _$$SASSuccessImplCopyWith<$Res> {
  __$$SASSuccessImplCopyWithImpl(
      _$SASSuccessImpl _value, $Res Function(_$SASSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articleId = null,
  }) {
    return _then(_$SASSuccessImpl(
      null == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SASSuccessImpl with DiagnosticableTreeMixin implements SASSuccess {
  const _$SASSuccessImpl(this.articleId);

  @override
  final int articleId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SaveArticleState.success(articleId: $articleId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SaveArticleState.success'))
      ..add(DiagnosticsProperty('articleId', articleId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SASSuccessImpl &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, articleId);

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SASSuccessImplCopyWith<_$SASSuccessImpl> get copyWith =>
      __$$SASSuccessImplCopyWithImpl<_$SASSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() postponed,
    required TResult Function(int articleId) success,
    required TResult Function(Object e) error,
    required TResult Function(Uri? parsed) errorDubiousUrl,
  }) {
    return success(articleId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? postponed,
    TResult? Function(int articleId)? success,
    TResult? Function(Object e)? error,
    TResult? Function(Uri? parsed)? errorDubiousUrl,
  }) {
    return success?.call(articleId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? postponed,
    TResult Function(int articleId)? success,
    TResult Function(Object e)? error,
    TResult Function(Uri? parsed)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(articleId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SASPending value) pending,
    required TResult Function(SASPostponed value) postponed,
    required TResult Function(SASSuccess value) success,
    required TResult Function(SASError value) error,
    required TResult Function(SASErrorDubiousUrl value) errorDubiousUrl,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SASPending value)? pending,
    TResult? Function(SASPostponed value)? postponed,
    TResult? Function(SASSuccess value)? success,
    TResult? Function(SASError value)? error,
    TResult? Function(SASErrorDubiousUrl value)? errorDubiousUrl,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SASPending value)? pending,
    TResult Function(SASPostponed value)? postponed,
    TResult Function(SASSuccess value)? success,
    TResult Function(SASError value)? error,
    TResult Function(SASErrorDubiousUrl value)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SASSuccess implements SaveArticleState {
  const factory SASSuccess(final int articleId) = _$SASSuccessImpl;

  int get articleId;

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SASSuccessImplCopyWith<_$SASSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SASErrorImplCopyWith<$Res> {
  factory _$$SASErrorImplCopyWith(
          _$SASErrorImpl value, $Res Function(_$SASErrorImpl) then) =
      __$$SASErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object e});
}

/// @nodoc
class __$$SASErrorImplCopyWithImpl<$Res>
    extends _$SaveArticleStateCopyWithImpl<$Res, _$SASErrorImpl>
    implements _$$SASErrorImplCopyWith<$Res> {
  __$$SASErrorImplCopyWithImpl(
      _$SASErrorImpl _value, $Res Function(_$SASErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$SASErrorImpl(
      null == e ? _value.e : e,
    ));
  }
}

/// @nodoc

class _$SASErrorImpl with DiagnosticableTreeMixin implements SASError {
  const _$SASErrorImpl(this.e);

  @override
  final Object e;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SaveArticleState.error(e: $e)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SaveArticleState.error'))
      ..add(DiagnosticsProperty('e', e));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SASErrorImpl &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SASErrorImplCopyWith<_$SASErrorImpl> get copyWith =>
      __$$SASErrorImplCopyWithImpl<_$SASErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() postponed,
    required TResult Function(int articleId) success,
    required TResult Function(Object e) error,
    required TResult Function(Uri? parsed) errorDubiousUrl,
  }) {
    return error(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? postponed,
    TResult? Function(int articleId)? success,
    TResult? Function(Object e)? error,
    TResult? Function(Uri? parsed)? errorDubiousUrl,
  }) {
    return error?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? postponed,
    TResult Function(int articleId)? success,
    TResult Function(Object e)? error,
    TResult Function(Uri? parsed)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SASPending value) pending,
    required TResult Function(SASPostponed value) postponed,
    required TResult Function(SASSuccess value) success,
    required TResult Function(SASError value) error,
    required TResult Function(SASErrorDubiousUrl value) errorDubiousUrl,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SASPending value)? pending,
    TResult? Function(SASPostponed value)? postponed,
    TResult? Function(SASSuccess value)? success,
    TResult? Function(SASError value)? error,
    TResult? Function(SASErrorDubiousUrl value)? errorDubiousUrl,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SASPending value)? pending,
    TResult Function(SASPostponed value)? postponed,
    TResult Function(SASSuccess value)? success,
    TResult Function(SASError value)? error,
    TResult Function(SASErrorDubiousUrl value)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SASError implements SaveArticleState {
  const factory SASError(final Object e) = _$SASErrorImpl;

  Object get e;

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SASErrorImplCopyWith<_$SASErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SASErrorDubiousUrlImplCopyWith<$Res> {
  factory _$$SASErrorDubiousUrlImplCopyWith(_$SASErrorDubiousUrlImpl value,
          $Res Function(_$SASErrorDubiousUrlImpl) then) =
      __$$SASErrorDubiousUrlImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uri? parsed});
}

/// @nodoc
class __$$SASErrorDubiousUrlImplCopyWithImpl<$Res>
    extends _$SaveArticleStateCopyWithImpl<$Res, _$SASErrorDubiousUrlImpl>
    implements _$$SASErrorDubiousUrlImplCopyWith<$Res> {
  __$$SASErrorDubiousUrlImplCopyWithImpl(_$SASErrorDubiousUrlImpl _value,
      $Res Function(_$SASErrorDubiousUrlImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parsed = freezed,
  }) {
    return _then(_$SASErrorDubiousUrlImpl(
      freezed == parsed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc

class _$SASErrorDubiousUrlImpl
    with DiagnosticableTreeMixin
    implements SASErrorDubiousUrl {
  const _$SASErrorDubiousUrlImpl(this.parsed);

  @override
  final Uri? parsed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SaveArticleState.errorDubiousUrl(parsed: $parsed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SaveArticleState.errorDubiousUrl'))
      ..add(DiagnosticsProperty('parsed', parsed));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SASErrorDubiousUrlImpl &&
            (identical(other.parsed, parsed) || other.parsed == parsed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, parsed);

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SASErrorDubiousUrlImplCopyWith<_$SASErrorDubiousUrlImpl> get copyWith =>
      __$$SASErrorDubiousUrlImplCopyWithImpl<_$SASErrorDubiousUrlImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() postponed,
    required TResult Function(int articleId) success,
    required TResult Function(Object e) error,
    required TResult Function(Uri? parsed) errorDubiousUrl,
  }) {
    return errorDubiousUrl(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? postponed,
    TResult? Function(int articleId)? success,
    TResult? Function(Object e)? error,
    TResult? Function(Uri? parsed)? errorDubiousUrl,
  }) {
    return errorDubiousUrl?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? postponed,
    TResult Function(int articleId)? success,
    TResult Function(Object e)? error,
    TResult Function(Uri? parsed)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (errorDubiousUrl != null) {
      return errorDubiousUrl(parsed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SASPending value) pending,
    required TResult Function(SASPostponed value) postponed,
    required TResult Function(SASSuccess value) success,
    required TResult Function(SASError value) error,
    required TResult Function(SASErrorDubiousUrl value) errorDubiousUrl,
  }) {
    return errorDubiousUrl(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SASPending value)? pending,
    TResult? Function(SASPostponed value)? postponed,
    TResult? Function(SASSuccess value)? success,
    TResult? Function(SASError value)? error,
    TResult? Function(SASErrorDubiousUrl value)? errorDubiousUrl,
  }) {
    return errorDubiousUrl?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SASPending value)? pending,
    TResult Function(SASPostponed value)? postponed,
    TResult Function(SASSuccess value)? success,
    TResult Function(SASError value)? error,
    TResult Function(SASErrorDubiousUrl value)? errorDubiousUrl,
    required TResult orElse(),
  }) {
    if (errorDubiousUrl != null) {
      return errorDubiousUrl(this);
    }
    return orElse();
  }
}

abstract class SASErrorDubiousUrl implements SaveArticleState {
  const factory SASErrorDubiousUrl(final Uri? parsed) =
      _$SASErrorDubiousUrlImpl;

  Uri? get parsed;

  /// Create a copy of SaveArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SASErrorDubiousUrlImplCopyWith<_$SASErrorDubiousUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
