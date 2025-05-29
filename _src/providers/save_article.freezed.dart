// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_article.dart';

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
