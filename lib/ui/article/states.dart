import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository_providers.dart';

part '_g/states.g.dart';

@riverpod
class ArticleContentState extends _$ArticleContentState {
  @override
  Future<String?> build(int articleId) async {
    final articleRepository = ref.watch(articleRepositoryProvider);
    final dataStream = articleRepository.watchContent(articleId);

    final subscription = dataStream.listen((data) {
      state = AsyncValue.data(data);
    });
    ref.onDispose(() => subscription.cancel());

    return dataStream.first;
  }
}
