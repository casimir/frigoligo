// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../article.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScrollPosition)
const scrollPositionProvider = ScrollPositionFamily._();

final class ScrollPositionProvider
    extends
        $AsyncNotifierProvider<ScrollPosition, ArticleScrollPositionModel?> {
  const ScrollPositionProvider._({
    required ScrollPositionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'scrollPositionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$scrollPositionHash();

  @override
  String toString() {
    return r'scrollPositionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ScrollPosition create() => ScrollPosition();

  @override
  bool operator ==(Object other) {
    return other is ScrollPositionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scrollPositionHash() => r'cc45561500058e54846702a758e048703e761c12';

final class ScrollPositionFamily extends $Family
    with
        $ClassFamilyOverride<
          ScrollPosition,
          AsyncValue<ArticleScrollPositionModel?>,
          ArticleScrollPositionModel?,
          FutureOr<ArticleScrollPositionModel?>,
          int
        > {
  const ScrollPositionFamily._()
    : super(
        retry: null,
        name: r'scrollPositionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ScrollPositionProvider call(int articleId) =>
      ScrollPositionProvider._(argument: articleId, from: this);

  @override
  String toString() => r'scrollPositionProvider';
}

abstract class _$ScrollPosition
    extends $AsyncNotifier<ArticleScrollPositionModel?> {
  late final _$args = ref.$arg as int;
  int get articleId => _$args;

  FutureOr<ArticleScrollPositionModel?> build(int articleId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ArticleScrollPositionModel?>,
              ArticleScrollPositionModel?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ArticleScrollPositionModel?>,
                ArticleScrollPositionModel?
              >,
              AsyncValue<ArticleScrollPositionModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CurrentReadingProgress)
const currentReadingProgressProvider = CurrentReadingProgressProvider._();

final class CurrentReadingProgressProvider
    extends $NotifierProvider<CurrentReadingProgress, double?> {
  const CurrentReadingProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentReadingProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentReadingProgressHash();

  @$internal
  @override
  CurrentReadingProgress create() => CurrentReadingProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double?>(value),
    );
  }
}

String _$currentReadingProgressHash() =>
    r'06fa7d21b93662369fbaa0c83372aae4009c87de';

abstract class _$CurrentReadingProgress extends $Notifier<double?> {
  double? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<double?, double?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double?, double?>,
              double?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
