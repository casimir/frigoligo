// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticleData)
const articleDataProvider = ArticleDataFamily._();

final class ArticleDataProvider
    extends $AsyncNotifierProvider<ArticleData, ArticleModel?> {
  const ArticleDataProvider._({
    required ArticleDataFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'articleDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleDataHash();

  @override
  String toString() {
    return r'articleDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArticleData create() => ArticleData();

  @override
  bool operator ==(Object other) {
    return other is ArticleDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleDataHash() => r'a82eb7422acdd76f692dfc6f1bf9e64b961456cc';

final class ArticleDataFamily extends $Family
    with
        $ClassFamilyOverride<
          ArticleData,
          AsyncValue<ArticleModel?>,
          ArticleModel?,
          FutureOr<ArticleModel?>,
          int
        > {
  const ArticleDataFamily._()
    : super(
        retry: null,
        name: r'articleDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleDataProvider call(int articleId) =>
      ArticleDataProvider._(argument: articleId, from: this);

  @override
  String toString() => r'articleDataProvider';
}

abstract class _$ArticleData extends $AsyncNotifier<ArticleModel?> {
  late final _$args = ref.$arg as int;
  int get articleId => _$args;

  FutureOr<ArticleModel?> build(int articleId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ArticleModel?>, ArticleModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ArticleModel?>, ArticleModel?>,
              AsyncValue<ArticleModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CurrentArticle)
const currentArticleProvider = CurrentArticleProvider._();

final class CurrentArticleProvider
    extends $AsyncNotifierProvider<CurrentArticle, ArticleModel?> {
  const CurrentArticleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentArticleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentArticleHash();

  @$internal
  @override
  CurrentArticle create() => CurrentArticle();
}

String _$currentArticleHash() => r'fb429c09329db9f8c59869fc48873e250747457e';

abstract class _$CurrentArticle extends $AsyncNotifier<ArticleModel?> {
  FutureOr<ArticleModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ArticleModel?>, ArticleModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ArticleModel?>, ArticleModel?>,
              AsyncValue<ArticleModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

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

String _$scrollPositionHash() => r'ccaee9514dd9330fe39dcc449ce2d10b6d49ff5d';

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

@ProviderFor(OpenArticle)
const openArticleProvider = OpenArticleProvider._();

final class OpenArticleProvider extends $NotifierProvider<OpenArticle, int?> {
  const OpenArticleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openArticleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openArticleHash();

  @$internal
  @override
  OpenArticle create() => OpenArticle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$openArticleHash() => r'b539747977d0b7cb779381e3963b083b1651616d';

abstract class _$OpenArticle extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
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
