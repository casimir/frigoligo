// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleDataHash() => r'72cf426783f218b987b89bb1373db5c4fb521695';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ArticleData
    extends BuildlessAutoDisposeAsyncNotifier<Article?> {
  late final int articleId;

  FutureOr<Article?> build(int articleId);
}

/// See also [ArticleData].
@ProviderFor(ArticleData)
const articleDataProvider = ArticleDataFamily();

/// See also [ArticleData].
class ArticleDataFamily extends Family<AsyncValue<Article?>> {
  /// See also [ArticleData].
  const ArticleDataFamily();

  /// See also [ArticleData].
  ArticleDataProvider call(int articleId) {
    return ArticleDataProvider(articleId);
  }

  @override
  ArticleDataProvider getProviderOverride(
    covariant ArticleDataProvider provider,
  ) {
    return call(provider.articleId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'articleDataProvider';
}

/// See also [ArticleData].
class ArticleDataProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ArticleData, Article?> {
  /// See also [ArticleData].
  ArticleDataProvider(int articleId)
    : this._internal(
        () => ArticleData()..articleId = articleId,
        from: articleDataProvider,
        name: r'articleDataProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$articleDataHash,
        dependencies: ArticleDataFamily._dependencies,
        allTransitiveDependencies: ArticleDataFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ArticleDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.articleId,
  }) : super.internal();

  final int articleId;

  @override
  FutureOr<Article?> runNotifierBuild(covariant ArticleData notifier) {
    return notifier.build(articleId);
  }

  @override
  Override overrideWith(ArticleData Function() create) {
    return ProviderOverride(
      origin: this,
      override: ArticleDataProvider._internal(
        () => create()..articleId = articleId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        articleId: articleId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ArticleData, Article?>
  createElement() {
    return _ArticleDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleDataProvider && other.articleId == articleId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, articleId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ArticleDataRef on AutoDisposeAsyncNotifierProviderRef<Article?> {
  /// The parameter `articleId` of this provider.
  int get articleId;
}

class _ArticleDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ArticleData, Article?>
    with ArticleDataRef {
  _ArticleDataProviderElement(super.provider);

  @override
  int get articleId => (origin as ArticleDataProvider).articleId;
}

String _$currentArticleHash() => r'c27a1b25db5008a06aa3e045d866a342fe585106';

/// See also [CurrentArticle].
@ProviderFor(CurrentArticle)
final currentArticleProvider =
    AutoDisposeAsyncNotifierProvider<CurrentArticle, Article?>.internal(
      CurrentArticle.new,
      name: r'currentArticleProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentArticleHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentArticle = AutoDisposeAsyncNotifier<Article?>;
String _$scrollPositionHash() => r'14429f91ef7c2786483b903c93eedc0d15af7a28';

abstract class _$ScrollPosition
    extends BuildlessAutoDisposeAsyncNotifier<ArticleScrollPosition?> {
  late final int articleId;

  FutureOr<ArticleScrollPosition?> build(int articleId);
}

/// See also [ScrollPosition].
@ProviderFor(ScrollPosition)
const scrollPositionProvider = ScrollPositionFamily();

/// See also [ScrollPosition].
class ScrollPositionFamily extends Family<AsyncValue<ArticleScrollPosition?>> {
  /// See also [ScrollPosition].
  const ScrollPositionFamily();

  /// See also [ScrollPosition].
  ScrollPositionProvider call(int articleId) {
    return ScrollPositionProvider(articleId);
  }

  @override
  ScrollPositionProvider getProviderOverride(
    covariant ScrollPositionProvider provider,
  ) {
    return call(provider.articleId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'scrollPositionProvider';
}

/// See also [ScrollPosition].
class ScrollPositionProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ScrollPosition,
          ArticleScrollPosition?
        > {
  /// See also [ScrollPosition].
  ScrollPositionProvider(int articleId)
    : this._internal(
        () => ScrollPosition()..articleId = articleId,
        from: scrollPositionProvider,
        name: r'scrollPositionProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$scrollPositionHash,
        dependencies: ScrollPositionFamily._dependencies,
        allTransitiveDependencies:
            ScrollPositionFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ScrollPositionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.articleId,
  }) : super.internal();

  final int articleId;

  @override
  FutureOr<ArticleScrollPosition?> runNotifierBuild(
    covariant ScrollPosition notifier,
  ) {
    return notifier.build(articleId);
  }

  @override
  Override overrideWith(ScrollPosition Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScrollPositionProvider._internal(
        () => create()..articleId = articleId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        articleId: articleId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    ScrollPosition,
    ArticleScrollPosition?
  >
  createElement() {
    return _ScrollPositionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScrollPositionProvider && other.articleId == articleId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, articleId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ScrollPositionRef
    on AutoDisposeAsyncNotifierProviderRef<ArticleScrollPosition?> {
  /// The parameter `articleId` of this provider.
  int get articleId;
}

class _ScrollPositionProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ScrollPosition,
          ArticleScrollPosition?
        >
    with ScrollPositionRef {
  _ScrollPositionProviderElement(super.provider);

  @override
  int get articleId => (origin as ScrollPositionProvider).articleId;
}

String _$openArticleHash() => r'b539747977d0b7cb779381e3963b083b1651616d';

/// See also [OpenArticle].
@ProviderFor(OpenArticle)
final openArticleProvider =
    AutoDisposeNotifierProvider<OpenArticle, int?>.internal(
      OpenArticle.new,
      name: r'openArticleProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$openArticleHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OpenArticle = AutoDisposeNotifier<int?>;
String _$currentReadingProgressHash() =>
    r'06fa7d21b93662369fbaa0c83372aae4009c87de';

/// See also [CurrentReadingProgress].
@ProviderFor(CurrentReadingProgress)
final currentReadingProgressProvider =
    AutoDisposeNotifierProvider<CurrentReadingProgress, double?>.internal(
      CurrentReadingProgress.new,
      name: r'currentReadingProgressProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentReadingProgressHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentReadingProgress = AutoDisposeNotifier<double?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
