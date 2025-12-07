import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/dependencies.dart';
import '../data/services/local/storage/database/models/article.drift.dart';
import '../data/services/local/storage/storage_service.dart';

part '_g/article.g.dart';

// workaround: provider can't return generated types since riverpod 3.0
class ArticleScrollPositionModel {
  ArticleScrollPositionModel({required this.articleScrollPosition});

  final ArticleScrollPosition articleScrollPosition;
}

@riverpod
class ScrollPosition extends _$ScrollPosition {
  StreamSubscription? _watcher;

  @override
  Future<ArticleScrollPositionModel?> build(int articleId) async {
    final LocalStorageService storageService = dependencies.get();
    final q = storageService.db.managers.articleScrollPositions.filter(
      (f) => f.id.equals(articleId),
    );

    ref.onDispose(() => _watcher?.cancel());
    _watcher?.cancel();
    _watcher = q.watchSingleOrNull().listen((value) {
      final current = state.maybeWhen(orElse: () => null, data: (asp) => asp);
      if (value != current?.articleScrollPosition) {
        state = AsyncValue.data(
          value != null
              ? ArticleScrollPositionModel(articleScrollPosition: value)
              : null,
        );
      }
    });

    final ret = await q.getSingleOrNull();
    return ret != null
        ? ArticleScrollPositionModel(articleScrollPosition: ret)
        : null;
  }
}

@riverpod
class CurrentReadingProgress extends _$CurrentReadingProgress {
  @override
  double? build() => null;

  set progress(double value) => state = value;
}
