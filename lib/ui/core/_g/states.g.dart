// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../states.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleExistsStateHash() =>
    r'892a0d41e3714f0abb6de0d1b1e8bc5a52760173';

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

/// See also [articleExistsState].
@ProviderFor(articleExistsState)
const articleExistsStateProvider = ArticleExistsStateFamily();

/// See also [articleExistsState].
class ArticleExistsStateFamily extends Family<AsyncValue<bool>> {
  /// See also [articleExistsState].
  const ArticleExistsStateFamily();

  /// See also [articleExistsState].
  ArticleExistsStateProvider call(int articleId) {
    return ArticleExistsStateProvider(articleId);
  }

  @override
  ArticleExistsStateProvider getProviderOverride(
    covariant ArticleExistsStateProvider provider,
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
  String? get name => r'articleExistsStateProvider';
}

/// See also [articleExistsState].
class ArticleExistsStateProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [articleExistsState].
  ArticleExistsStateProvider(int articleId)
    : this._internal(
        (ref) => articleExistsState(ref as ArticleExistsStateRef, articleId),
        from: articleExistsStateProvider,
        name: r'articleExistsStateProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$articleExistsStateHash,
        dependencies: ArticleExistsStateFamily._dependencies,
        allTransitiveDependencies:
            ArticleExistsStateFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ArticleExistsStateProvider._internal(
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
  Override overrideWith(
    FutureOr<bool> Function(ArticleExistsStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ArticleExistsStateProvider._internal(
        (ref) => create(ref as ArticleExistsStateRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _ArticleExistsStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleExistsStateProvider && other.articleId == articleId;
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
mixin ArticleExistsStateRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `articleId` of this provider.
  int get articleId;
}

class _ArticleExistsStateProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with ArticleExistsStateRef {
  _ArticleExistsStateProviderElement(super.provider);

  @override
  int get articleId => (origin as ArticleExistsStateProvider).articleId;
}

String _$articleStateHash() => r'eb62b02258ec7d3b8b090e8f78dbdecd7852f083';

abstract class _$ArticleState
    extends BuildlessAutoDisposeAsyncNotifier<ArticleData?> {
  late final int articleId;

  FutureOr<ArticleData?> build(int articleId);
}

/// See also [ArticleState].
@ProviderFor(ArticleState)
const articleStateProvider = ArticleStateFamily();

/// See also [ArticleState].
class ArticleStateFamily extends Family<AsyncValue<ArticleData?>> {
  /// See also [ArticleState].
  const ArticleStateFamily();

  /// See also [ArticleState].
  ArticleStateProvider call(int articleId) {
    return ArticleStateProvider(articleId);
  }

  @override
  ArticleStateProvider getProviderOverride(
    covariant ArticleStateProvider provider,
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
  String? get name => r'articleStateProvider';
}

/// See also [ArticleState].
class ArticleStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ArticleState, ArticleData?> {
  /// See also [ArticleState].
  ArticleStateProvider(int articleId)
    : this._internal(
        () => ArticleState()..articleId = articleId,
        from: articleStateProvider,
        name: r'articleStateProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$articleStateHash,
        dependencies: ArticleStateFamily._dependencies,
        allTransitiveDependencies:
            ArticleStateFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ArticleStateProvider._internal(
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
  FutureOr<ArticleData?> runNotifierBuild(covariant ArticleState notifier) {
    return notifier.build(articleId);
  }

  @override
  Override overrideWith(ArticleState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ArticleStateProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ArticleState, ArticleData?>
  createElement() {
    return _ArticleStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleStateProvider && other.articleId == articleId;
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
mixin ArticleStateRef on AutoDisposeAsyncNotifierProviderRef<ArticleData?> {
  /// The parameter `articleId` of this provider.
  int get articleId;
}

class _ArticleStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ArticleState, ArticleData?>
    with ArticleStateRef {
  _ArticleStateProviderElement(super.provider);

  @override
  int get articleId => (origin as ArticleStateProvider).articleId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
