// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../save_article.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SaveArticle)
const saveArticleProvider = SaveArticleFamily._();

final class SaveArticleProvider
    extends $NotifierProvider<SaveArticle, SaveArticleState> {
  const SaveArticleProvider._({
    required SaveArticleFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'saveArticleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$saveArticleHash();

  @override
  String toString() {
    return r'saveArticleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SaveArticle create() => SaveArticle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveArticleState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveArticleState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SaveArticleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$saveArticleHash() => r'495cfa73659130e9484ce897bfd94921508e8cc6';

final class SaveArticleFamily extends $Family
    with
        $ClassFamilyOverride<
          SaveArticle,
          SaveArticleState,
          SaveArticleState,
          SaveArticleState,
          String
        > {
  const SaveArticleFamily._()
    : super(
        retry: null,
        name: r'saveArticleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SaveArticleProvider call(String url) =>
      SaveArticleProvider._(argument: url, from: this);

  @override
  String toString() => r'saveArticleProvider';
}

abstract class _$SaveArticle extends $Notifier<SaveArticleState> {
  late final _$args = ref.$arg as String;
  String get url => _$args;

  SaveArticleState build(String url);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<SaveArticleState, SaveArticleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SaveArticleState, SaveArticleState>,
              SaveArticleState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
