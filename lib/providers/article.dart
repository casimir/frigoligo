import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/dependencies.dart';
import '../data/services/local/storage/database/models/article.drift.dart';
import '../data/services/local/storage/storage_service.dart';

part '_g/article.g.dart';

@riverpod
class ScrollPosition extends _$ScrollPosition {
  StreamSubscription? _watcher;

  @override
  Future<ArticleScrollPosition?> build(int articleId) {
    final LocalStorageService storageService = dependencies.get();
    final q = storageService.db.managers.articleScrollPositions.filter(
      (f) => f.id.equals(articleId),
    );

    _watcher?.cancel();
    _watcher = q.watchSingleOrNull().listen((value) {
      final current = state.maybeWhen(orElse: () => null, data: (asp) => asp);
      if (value != current) state = AsyncValue.data(value);
    });

    return q.getSingleOrNull();
  }
}

@riverpod
class OpenArticle extends _$OpenArticle {
  @override
  int? build() => null;

  void schedule(int articleId) {
    state = articleId;
  }

  void reset() {
    state = null;
  }
}

@riverpod
class CurrentReadingProgress extends _$CurrentReadingProgress {
  @override
  double? build() => null;

  set progress(double value) => state = value;
}
