import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../buildcontext_extension.dart';
import '../../db/models/article.drift.dart';
import '../../widgets/material_sheet.dart';
import 'mixins.dart';

class ArticleSheet extends ConsumerWidget with CurrentArticleWidget {
  const ArticleSheet({super.key});

  @override
  Widget buildArticle(BuildContext context, WidgetRef ref, Article? article) {
    if (article == null) {
      // Should never happer but the mixin signature imposes this check.
      return const SizedBox.shrink();
    }

    return MaterialSheet.side(
      context: context,
      title: 'Article', // TODO translate
      child: PaddedGroup(
        child: Column(
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(article.domainName ?? article.url),
                const Text(' - '),
                const Icon(Icons.timer_outlined),
                Text(context.L.article_readingTime(article.readingTime)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
