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
