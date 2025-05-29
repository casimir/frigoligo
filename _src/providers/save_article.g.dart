// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_article.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$saveArticleHash() => r'495cfa73659130e9484ce897bfd94921508e8cc6';

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

abstract class _$SaveArticle
    extends BuildlessAutoDisposeNotifier<SaveArticleState> {
  late final String url;

  SaveArticleState build(String url);
}

/// See also [SaveArticle].
@ProviderFor(SaveArticle)
const saveArticleProvider = SaveArticleFamily();

/// See also [SaveArticle].
class SaveArticleFamily extends Family<SaveArticleState> {
  /// See also [SaveArticle].
  const SaveArticleFamily();

  /// See also [SaveArticle].
  SaveArticleProvider call(String url) {
    return SaveArticleProvider(url);
  }

  @override
  SaveArticleProvider getProviderOverride(
    covariant SaveArticleProvider provider,
  ) {
    return call(provider.url);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'saveArticleProvider';
}

/// See also [SaveArticle].
class SaveArticleProvider
    extends AutoDisposeNotifierProviderImpl<SaveArticle, SaveArticleState> {
  /// See also [SaveArticle].
  SaveArticleProvider(String url)
    : this._internal(
        () => SaveArticle()..url = url,
        from: saveArticleProvider,
        name: r'saveArticleProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$saveArticleHash,
        dependencies: SaveArticleFamily._dependencies,
        allTransitiveDependencies: SaveArticleFamily._allTransitiveDependencies,
        url: url,
      );

  SaveArticleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  SaveArticleState runNotifierBuild(covariant SaveArticle notifier) {
    return notifier.build(url);
  }

  @override
  Override overrideWith(SaveArticle Function() create) {
    return ProviderOverride(
      origin: this,
      override: SaveArticleProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SaveArticle, SaveArticleState>
  createElement() {
    return _SaveArticleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaveArticleProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SaveArticleRef on AutoDisposeNotifierProviderRef<SaveArticleState> {
  /// The parameter `url` of this provider.
  String get url;
}

class _SaveArticleProviderElement
    extends AutoDisposeNotifierProviderElement<SaveArticle, SaveArticleState>
    with SaveArticleRef {
  _SaveArticleProviderElement(super.provider);

  @override
  String get url => (origin as SaveArticleProvider).url;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
