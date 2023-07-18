import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:frigoligo/constants.dart';
import 'package:frigoligo/widgets/async_action_button.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article.dart';
import '../providers/article.dart';

class ArticlePage extends StatefulWidget {
  // TODO articleId is not used but required to avoid triggering flutter caching
  // maybe that's just a setState() missing somewhere
  const ArticlePage({super.key, required this.articleId});

  final int articleId;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool _stateChangePending = false;
  bool _starredChangePending = false;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ArticleProvider>();
    var article = provider.article;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (article != null)
            AsyncActionButton(
              icon: stateIcons[article.stateValue]!,
              progressValue: _stateChangePending ? 0 : null,
              onPressed: () => provider.modifyAndRefresh(
                archive: article.archivedAt == null,
                onProgress: (progress) =>
                    setState(() => _stateChangePending = progress < 1),
              ),
            ),
          if (article != null)
            AsyncActionButton(
              icon: starredIcons[article.starredValue]!,
              progressValue: _starredChangePending ? 0 : null,
              onPressed: () => provider.modifyAndRefresh(
                starred: article.starredAt == null,
                onProgress: (progress) =>
                    setState(() => _starredChangePending = progress < 1),
              ),
            ),
          PopupMenuButton(
            itemBuilder: (context) => [
              // TODO UI settings
              PopupMenuItem(
                value: 'share',
                enabled: article != null,
                child: ListTile(
                  leading: shareIcon,
                  title: const Text('Share'),
                ),
              ),
              PopupMenuItem(
                value: 'open',
                enabled: article != null,
                child: const ListTile(
                  leading: Icon(Icons.open_in_browser),
                  title: Text('Open in browser'),
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                enabled: article != null,
                child: const ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete article'),
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'share':
                  final box = context.findRenderObject() as RenderBox?;
                  Share.share(
                    article!.url,
                    subject: article.title,
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size,
                  );
                case 'open':
                  launchUrl(Uri.parse(article!.url));
                case 'delete':
                  provider.deleteAndRefresh();
                  Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: article != null
          ? SingleChildScrollView(
              key: ObjectKey(article.id),
              child: Column(
                children: [
                  ArticlePageHeader(article: article),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: HtmlWidget(
                      article.content,
                      factoryBuilder: () => HtmlWidgetFactory(),
                    ),
                  )
                ],
              ),
            )
          : const Center(child: Icon(Icons.question_mark)),
    );
  }
}

class ArticlePageHeader extends StatelessWidget {
  const ArticlePageHeader({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          article.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(article.domainName!),
            const Text(' - '),
            const Icon(Icons.timer_outlined),
            Text('${article.readingTime} min'),
          ],
        ),
      ],
    );
  }
}

class HtmlWidgetFactory extends WidgetFactory
    with CachedNetworkImageFactory, UrlLauncherFactory {}
