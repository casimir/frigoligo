// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Query)
const queryProvider = QueryProvider._();

final class QueryProvider extends $NotifierProvider<Query, WQuery> {
  const QueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queryHash();

  @$internal
  @override
  Query create() => Query();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WQuery>(value),
    );
  }
}

String _$queryHash() => r'206337ab5e2b8807556d00a9956cf5583d31519b';

abstract class _$Query extends $Notifier<WQuery> {
  WQuery build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WQuery, WQuery>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WQuery, WQuery>,
              WQuery,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(QueryMeta)
const queryMetaProvider = QueryMetaProvider._();

final class QueryMetaProvider
    extends $AsyncNotifierProvider<QueryMeta, QueryState> {
  const QueryMetaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queryMetaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queryMetaHash();

  @$internal
  @override
  QueryMeta create() => QueryMeta();
}

String _$queryMetaHash() => r'136d2589ffab82204b3fc27dc3571ccb8a251939';

abstract class _$QueryMeta extends $AsyncNotifier<QueryState> {
  FutureOr<QueryState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<QueryState>, QueryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<QueryState>, QueryState>,
              AsyncValue<QueryState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
