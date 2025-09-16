// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../save_article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaveArticleState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SaveArticleState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveArticleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SaveArticleState()';
}


}

/// @nodoc
class $SaveArticleStateCopyWith<$Res>  {
$SaveArticleStateCopyWith(SaveArticleState _, $Res Function(SaveArticleState) __);
}


/// Adds pattern-matching-related methods to [SaveArticleState].
extension SaveArticleStatePatterns on SaveArticleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SASPending value)?  pending,TResult Function( SASPostponed value)?  postponed,TResult Function( SASSuccess value)?  success,TResult Function( SASError value)?  error,TResult Function( SASErrorDubiousUrl value)?  errorDubiousUrl,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SASPending() when pending != null:
return pending(_that);case SASPostponed() when postponed != null:
return postponed(_that);case SASSuccess() when success != null:
return success(_that);case SASError() when error != null:
return error(_that);case SASErrorDubiousUrl() when errorDubiousUrl != null:
return errorDubiousUrl(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SASPending value)  pending,required TResult Function( SASPostponed value)  postponed,required TResult Function( SASSuccess value)  success,required TResult Function( SASError value)  error,required TResult Function( SASErrorDubiousUrl value)  errorDubiousUrl,}){
final _that = this;
switch (_that) {
case SASPending():
return pending(_that);case SASPostponed():
return postponed(_that);case SASSuccess():
return success(_that);case SASError():
return error(_that);case SASErrorDubiousUrl():
return errorDubiousUrl(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SASPending value)?  pending,TResult? Function( SASPostponed value)?  postponed,TResult? Function( SASSuccess value)?  success,TResult? Function( SASError value)?  error,TResult? Function( SASErrorDubiousUrl value)?  errorDubiousUrl,}){
final _that = this;
switch (_that) {
case SASPending() when pending != null:
return pending(_that);case SASPostponed() when postponed != null:
return postponed(_that);case SASSuccess() when success != null:
return success(_that);case SASError() when error != null:
return error(_that);case SASErrorDubiousUrl() when errorDubiousUrl != null:
return errorDubiousUrl(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  pending,TResult Function()?  postponed,TResult Function( int articleId)?  success,TResult Function( Object e)?  error,TResult Function( Uri? parsed)?  errorDubiousUrl,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SASPending() when pending != null:
return pending();case SASPostponed() when postponed != null:
return postponed();case SASSuccess() when success != null:
return success(_that.articleId);case SASError() when error != null:
return error(_that.e);case SASErrorDubiousUrl() when errorDubiousUrl != null:
return errorDubiousUrl(_that.parsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  pending,required TResult Function()  postponed,required TResult Function( int articleId)  success,required TResult Function( Object e)  error,required TResult Function( Uri? parsed)  errorDubiousUrl,}) {final _that = this;
switch (_that) {
case SASPending():
return pending();case SASPostponed():
return postponed();case SASSuccess():
return success(_that.articleId);case SASError():
return error(_that.e);case SASErrorDubiousUrl():
return errorDubiousUrl(_that.parsed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  pending,TResult? Function()?  postponed,TResult? Function( int articleId)?  success,TResult? Function( Object e)?  error,TResult? Function( Uri? parsed)?  errorDubiousUrl,}) {final _that = this;
switch (_that) {
case SASPending() when pending != null:
return pending();case SASPostponed() when postponed != null:
return postponed();case SASSuccess() when success != null:
return success(_that.articleId);case SASError() when error != null:
return error(_that.e);case SASErrorDubiousUrl() when errorDubiousUrl != null:
return errorDubiousUrl(_that.parsed);case _:
  return null;

}
}

}

/// @nodoc


class SASPending with DiagnosticableTreeMixin implements SaveArticleState {
  const SASPending();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SaveArticleState.pending'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SASPending);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SaveArticleState.pending()';
}


}




/// @nodoc


class SASPostponed with DiagnosticableTreeMixin implements SaveArticleState {
  const SASPostponed();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SaveArticleState.postponed'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SASPostponed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SaveArticleState.postponed()';
}


}




/// @nodoc


class SASSuccess with DiagnosticableTreeMixin implements SaveArticleState {
  const SASSuccess(this.articleId);
  

 final  int articleId;

/// Create a copy of SaveArticleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SASSuccessCopyWith<SASSuccess> get copyWith => _$SASSuccessCopyWithImpl<SASSuccess>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SaveArticleState.success'))
    ..add(DiagnosticsProperty('articleId', articleId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SASSuccess&&(identical(other.articleId, articleId) || other.articleId == articleId));
}


@override
int get hashCode => Object.hash(runtimeType,articleId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SaveArticleState.success(articleId: $articleId)';
}


}

/// @nodoc
abstract mixin class $SASSuccessCopyWith<$Res> implements $SaveArticleStateCopyWith<$Res> {
  factory $SASSuccessCopyWith(SASSuccess value, $Res Function(SASSuccess) _then) = _$SASSuccessCopyWithImpl;
@useResult
$Res call({
 int articleId
});




}
/// @nodoc
class _$SASSuccessCopyWithImpl<$Res>
    implements $SASSuccessCopyWith<$Res> {
  _$SASSuccessCopyWithImpl(this._self, this._then);

  final SASSuccess _self;
  final $Res Function(SASSuccess) _then;

/// Create a copy of SaveArticleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? articleId = null,}) {
  return _then(SASSuccess(
null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SASError with DiagnosticableTreeMixin implements SaveArticleState {
  const SASError(this.e);
  

 final  Object e;

/// Create a copy of SaveArticleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SASErrorCopyWith<SASError> get copyWith => _$SASErrorCopyWithImpl<SASError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SaveArticleState.error'))
    ..add(DiagnosticsProperty('e', e));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SASError&&const DeepCollectionEquality().equals(other.e, e));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(e));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SaveArticleState.error(e: $e)';
}


}

/// @nodoc
abstract mixin class $SASErrorCopyWith<$Res> implements $SaveArticleStateCopyWith<$Res> {
  factory $SASErrorCopyWith(SASError value, $Res Function(SASError) _then) = _$SASErrorCopyWithImpl;
@useResult
$Res call({
 Object e
});




}
/// @nodoc
class _$SASErrorCopyWithImpl<$Res>
    implements $SASErrorCopyWith<$Res> {
  _$SASErrorCopyWithImpl(this._self, this._then);

  final SASError _self;
  final $Res Function(SASError) _then;

/// Create a copy of SaveArticleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? e = null,}) {
  return _then(SASError(
null == e ? _self.e : e ,
  ));
}


}

/// @nodoc


class SASErrorDubiousUrl with DiagnosticableTreeMixin implements SaveArticleState {
  const SASErrorDubiousUrl(this.parsed);
  

 final  Uri? parsed;

/// Create a copy of SaveArticleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SASErrorDubiousUrlCopyWith<SASErrorDubiousUrl> get copyWith => _$SASErrorDubiousUrlCopyWithImpl<SASErrorDubiousUrl>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SaveArticleState.errorDubiousUrl'))
    ..add(DiagnosticsProperty('parsed', parsed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SASErrorDubiousUrl&&(identical(other.parsed, parsed) || other.parsed == parsed));
}


@override
int get hashCode => Object.hash(runtimeType,parsed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SaveArticleState.errorDubiousUrl(parsed: $parsed)';
}


}

/// @nodoc
abstract mixin class $SASErrorDubiousUrlCopyWith<$Res> implements $SaveArticleStateCopyWith<$Res> {
  factory $SASErrorDubiousUrlCopyWith(SASErrorDubiousUrl value, $Res Function(SASErrorDubiousUrl) _then) = _$SASErrorDubiousUrlCopyWithImpl;
@useResult
$Res call({
 Uri? parsed
});




}
/// @nodoc
class _$SASErrorDubiousUrlCopyWithImpl<$Res>
    implements $SASErrorDubiousUrlCopyWith<$Res> {
  _$SASErrorDubiousUrlCopyWithImpl(this._self, this._then);

  final SASErrorDubiousUrl _self;
  final $Res Function(SASErrorDubiousUrl) _then;

/// Create a copy of SaveArticleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? parsed = freezed,}) {
  return _then(SASErrorDubiousUrl(
freezed == parsed ? _self.parsed : parsed // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}


}

// dart format on
