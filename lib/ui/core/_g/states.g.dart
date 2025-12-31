// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../states.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticleState)
const articleStateProvider = ArticleStateFamily._();

final class ArticleStateProvider
    extends $AsyncNotifierProvider<ArticleState, ArticleData?> {
  const ArticleStateProvider._({
    required ArticleStateFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'articleStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleStateHash();

  @override
  String toString() {
    return r'articleStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArticleState create() => ArticleState();

  @override
  bool operator ==(Object other) {
    return other is ArticleStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleStateHash() => r'eb62b02258ec7d3b8b090e8f78dbdecd7852f083';

final class ArticleStateFamily extends $Family
    with
        $ClassFamilyOverride<
          ArticleState,
          AsyncValue<ArticleData?>,
          ArticleData?,
          FutureOr<ArticleData?>,
          int
        > {
  const ArticleStateFamily._()
    : super(
        retry: null,
        name: r'articleStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleStateProvider call(int articleId) =>
      ArticleStateProvider._(argument: articleId, from: this);

  @override
  String toString() => r'articleStateProvider';
}

abstract class _$ArticleState extends $AsyncNotifier<ArticleData?> {
  late final _$args = ref.$arg as int;
  int get articleId => _$args;

  FutureOr<ArticleData?> build(int articleId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ArticleData?>, ArticleData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ArticleData?>, ArticleData?>,
              AsyncValue<ArticleData?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(articleExistsState)
const articleExistsStateProvider = ArticleExistsStateFamily._();

final class ArticleExistsStateProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const ArticleExistsStateProvider._({
    required ArticleExistsStateFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'articleExistsStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleExistsStateHash();

  @override
  String toString() {
    return r'articleExistsStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as int;
    return articleExistsState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleExistsStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleExistsStateHash() =>
    r'892a0d41e3714f0abb6de0d1b1e8bc5a52760173';

final class ArticleExistsStateFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, int> {
  const ArticleExistsStateFamily._()
    : super(
        retry: null,
        name: r'articleExistsStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleExistsStateProvider call(int articleId) =>
      ArticleExistsStateProvider._(argument: articleId, from: this);

  @override
  String toString() => r'articleExistsStateProvider';
}

/// Riverpod provider that exposes SyncManager state for UI consumption.
///
/// This provider listens to SyncManager state changes and rebuilds widgets.
/// All business logic is in SyncManager - this is purely for UI reactivity.

@ProviderFor(SyncManagerState)
const syncManagerStateProvider = SyncManagerStateProvider._();

/// Riverpod provider that exposes SyncManager state for UI consumption.
///
/// This provider listens to SyncManager state changes and rebuilds widgets.
/// All business logic is in SyncManager - this is purely for UI reactivity.
final class SyncManagerStateProvider
    extends $NotifierProvider<SyncManagerState, SyncState> {
  /// Riverpod provider that exposes SyncManager state for UI consumption.
  ///
  /// This provider listens to SyncManager state changes and rebuilds widgets.
  /// All business logic is in SyncManager - this is purely for UI reactivity.
  const SyncManagerStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncManagerStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncManagerStateHash();

  @$internal
  @override
  SyncManagerState create() => SyncManagerState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncState>(value),
    );
  }
}

String _$syncManagerStateHash() => r'a43b36ce77e883cb319d1b9a38a5514cc59700e8';

/// Riverpod provider that exposes SyncManager state for UI consumption.
///
/// This provider listens to SyncManager state changes and rebuilds widgets.
/// All business logic is in SyncManager - this is purely for UI reactivity.

abstract class _$SyncManagerState extends $Notifier<SyncState> {
  SyncState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SyncState, SyncState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SyncState, SyncState>,
              SyncState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
