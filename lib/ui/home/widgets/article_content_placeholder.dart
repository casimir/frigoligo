import 'package:cadanse/cadanse.dart';
import 'package:flutter/material.dart';

import '../../../buildcontext_extension.dart';

class ArticleContentPlaceholder extends StatelessWidget {
  const ArticleContentPlaceholder({
    super.key,
    required this.articleUrl,
    required this.openUrlCallback,
  });

  final Uri? articleUrl;
  final Future<void> Function(Uri) openUrlCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.L.article_noContentFetched,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          C.spacers.verticalContent,
          if (articleUrl != null)
            ElevatedButton(
              onPressed: () => openUrlCallback(articleUrl!),
              child: Text(context.L.article_openInBrowser),
            ),
        ],
      ),
    );
  }
}
