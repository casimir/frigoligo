import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/article_data.dart';
import '../repository_providers.dart';

part '_g/states.g.dart';

@riverpod
class ArticleState extends _$ArticleState {
  @override
  Future<ArticleData?> build(int articleId) async {
    final articleRepository = ref.watch(articleRepositoryProvider);
    final dataStream = articleRepository.watchData(articleId);

    final subscription = dataStream.listen((data) {
      state = AsyncValue.data(data);
    });
    ref.onDispose(() => subscription.cancel());

    return dataStream.first;
  }
}

@riverpod
Future<bool> articleExistsState(Ref ref, int articleId) {
  return ref.watch(
    articleStateProvider(articleId).selectAsync((data) => data != null),
  );
}
