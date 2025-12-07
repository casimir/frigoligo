// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../states.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleContentStateHash() =>
    r'c7c0f819a65206a6a7eeab83f94c0152ddf3aa48';

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

abstract class _$ArticleContentState
    extends BuildlessAutoDisposeAsyncNotifier<String?> {
  late final int articleId;

  FutureOr<String?> build(int articleId);
}

/// See also [ArticleContentState].
@ProviderFor(ArticleContentState)
const articleContentStateProvider = ArticleContentStateFamily();

/// See also [ArticleContentState].
class ArticleContentStateFamily extends Family<AsyncValue<String?>> {
  /// See also [ArticleContentState].
  const ArticleContentStateFamily();

  /// See also [ArticleContentState].
  ArticleContentStateProvider call(int articleId) {
    return ArticleContentStateProvider(articleId);
  }

  @override
  ArticleContentStateProvider getProviderOverride(
    covariant ArticleContentStateProvider provider,
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
  String? get name => r'articleContentStateProvider';
}

/// See also [ArticleContentState].
class ArticleContentStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ArticleContentState, String?> {
  /// See also [ArticleContentState].
  ArticleContentStateProvider(int articleId)
    : this._internal(
        () => ArticleContentState()..articleId = articleId,
        from: articleContentStateProvider,
        name: r'articleContentStateProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$articleContentStateHash,
        dependencies: ArticleContentStateFamily._dependencies,
        allTransitiveDependencies:
            ArticleContentStateFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ArticleContentStateProvider._internal(
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
  FutureOr<String?> runNotifierBuild(covariant ArticleContentState notifier) {
    return notifier.build(articleId);
  }

  @override
  Override overrideWith(ArticleContentState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ArticleContentStateProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ArticleContentState, String?>
  createElement() {
    return _ArticleContentStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleContentStateProvider && other.articleId == articleId;
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
mixin ArticleContentStateRef on AutoDisposeAsyncNotifierProviderRef<String?> {
  /// The parameter `articleId` of this provider.
  int get articleId;
}

class _ArticleContentStateProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<ArticleContentState, String?>
    with ArticleContentStateRef {
  _ArticleContentStateProviderElement(super.provider);

  @override
  int get articleId => (origin as ArticleContentStateProvider).articleId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
