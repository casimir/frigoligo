import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenArticle extends StateNotifier<int?> {
  OpenArticle() : super(null);

  void schedule(int articleId) {
    print('SCHEDULE $articleId');
    state = articleId;
  }

  void reset() {
    state = null;
  }
}

final openArticleProvider = StateNotifierProvider<OpenArticle, int?>((ref) {
  return OpenArticle();
});
