// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../states.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticleContentState)
const articleContentStateProvider = ArticleContentStateFamily._();

final class ArticleContentStateProvider
    extends $AsyncNotifierProvider<ArticleContentState, String?> {
  const ArticleContentStateProvider._({
    required ArticleContentStateFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'articleContentStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleContentStateHash();

  @override
  String toString() {
    return r'articleContentStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArticleContentState create() => ArticleContentState();

  @override
  bool operator ==(Object other) {
    return other is ArticleContentStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleContentStateHash() =>
    r'c7c0f819a65206a6a7eeab83f94c0152ddf3aa48';

final class ArticleContentStateFamily extends $Family
    with
        $ClassFamilyOverride<
          ArticleContentState,
          AsyncValue<String?>,
          String?,
          FutureOr<String?>,
          int
        > {
  const ArticleContentStateFamily._()
    : super(
        retry: null,
        name: r'articleContentStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleContentStateProvider call(int articleId) =>
      ArticleContentStateProvider._(argument: articleId, from: this);

  @override
  String toString() => r'articleContentStateProvider';
}

abstract class _$ArticleContentState extends $AsyncNotifier<String?> {
  late final _$args = ref.$arg as int;
  int get articleId => _$args;

  FutureOr<String?> build(int articleId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
