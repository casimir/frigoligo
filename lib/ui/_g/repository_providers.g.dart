// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(articleRepository)
const articleRepositoryProvider = ArticleRepositoryProvider._();

final class ArticleRepositoryProvider
    extends
        $FunctionalProvider<
          ArticleRepository,
          ArticleRepository,
          ArticleRepository
        >
    with $Provider<ArticleRepository> {
  const ArticleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'articleRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$articleRepositoryHash();

  @$internal
  @override
  $ProviderElement<ArticleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ArticleRepository create(Ref ref) {
    return articleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArticleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArticleRepository>(value),
    );
  }
}

String _$articleRepositoryHash() => r'ebca35c8eeec3c692739e57ac7e28d8a427d9a94';

@ProviderFor(queryRepository)
const queryRepositoryProvider = QueryRepositoryProvider._();

final class QueryRepositoryProvider
    extends
        $FunctionalProvider<QueryRepository, QueryRepository, QueryRepository>
    with $Provider<QueryRepository> {
  const QueryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queryRepositoryHash();

  @$internal
  @override
  $ProviderElement<QueryRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QueryRepository create(Ref ref) {
    return queryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QueryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QueryRepository>(value),
    );
  }
}

String _$queryRepositoryHash() => r'1170814cef35b7a27956948eec3a1bbdcb6f94ff';

@ProviderFor(tagRepository)
const tagRepositoryProvider = TagRepositoryProvider._();

final class TagRepositoryProvider
    extends $FunctionalProvider<TagRepository, TagRepository, TagRepository>
    with $Provider<TagRepository> {
  const TagRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagRepositoryHash();

  @$internal
  @override
  $ProviderElement<TagRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TagRepository create(Ref ref) {
    return tagRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TagRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TagRepository>(value),
    );
  }
}

String _$tagRepositoryHash() => r'75a7afb89fe152f499d78c33ee2a4490c0e86594';
