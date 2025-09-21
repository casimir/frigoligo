import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/local/storage/database/models/article.drift.dart';
import '../../providers/article.dart';

Widget _build(WidgetRef ref, Widget Function(Article?) onArticle) {
  return ref.watch(currentArticleProvider).when(
        data: (it) => onArticle(it),
        error: (error, _) => ErrorScreen(error: error),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
      );
}

mixin CurrentArticleWidget on ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      _build(ref, (article) => buildArticle(context, ref, article));

  Widget buildArticle(BuildContext context, WidgetRef ref, Article? article);
}

mixin CurrentArticleState<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  @override
  Widget build(BuildContext context) =>
      _build(ref, (article) => buildArticle(context, article));

  Widget buildArticle(BuildContext context, Article? article);
}
