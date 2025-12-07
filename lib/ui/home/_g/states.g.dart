// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../states.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(queryState)
const queryStateProvider = QueryStateProvider._();

final class QueryStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<QueryState>,
          QueryState,
          FutureOr<QueryState>
        >
    with $FutureModifier<QueryState>, $FutureProvider<QueryState> {
  const QueryStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queryStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queryStateHash();

  @$internal
  @override
  $FutureProviderElement<QueryState> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<QueryState> create(Ref ref) {
    return queryState(ref);
  }
}

String _$queryStateHash() => r'cd16e0f8dff7e8b3c2a8074ea24fad4583aaa786';
