import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../buildcontext_extension.dart';
import '../../db/database.dart';
import '../../db/models/article.drift.dart';
import '../../providers/article.dart';
import '../../providers/reading_settings.dart';
import '../../widgets/html_widget_plus.dart';

class ArticleContent extends ConsumerStatefulWidget {
  const ArticleContent({super.key, required this.article});

  final Article article;

  @override
  ConsumerState<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends ConsumerState<ArticleContent> {
  Future<void> _onScroll(double progress, bool isScrolling) async {
    ref.read(currentReadingProgressProvider.notifier).progress = progress;

    if (!isScrolling) {
      await DB().articlesDao.saveScrollProgress(widget.article, progress);
    }
  }

  Future<void> _jumpToProgress(BuildContext context) async {
    final controller = PrimaryScrollController.of(context);
    final scrollPosition =
        await ref.read(scrollPositionProvider(widget.article.id).future);
    final progress = scrollPosition?.progress;
    if (progress != null && progress > 0) {
      final pixels = progress * controller.position.maxScrollExtent;
      controller.jumpTo(pixels);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(readingSettingsProvider);
    return SelectionArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          var update = false;
          var isScrolling = false;
          if (notification is ScrollUpdateNotification) {
            update = true;
            isScrolling = true;
          }
          if (notification is ScrollEndNotification) {
            update = true;
          }

          if (update) {
            final pixels = notification.metrics.pixels;
            final maxExtent = notification.metrics.maxScrollExtent;
            final double progress = (pixels / maxExtent).clamp(0, 1);
            _onScroll(progress, isScrolling);
          }

          return false;
        },
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              PaddedGroup(
                child: HtmlWidgetPlus(
                  widget.article.content!,
                  title: widget.article.title,
                  onTreeBuilt: (_) => _jumpToProgress(context),
                  justifyText: settings.justifyText,
                  textStyle: settings.textStyle,
                ),
              ),
              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleContentEmpty extends StatelessWidget {
  const ArticleContentEmpty({
    super.key,
    required this.articleUrl,
  });

  final Uri articleUrl;

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
          ElevatedButton(
            onPressed: () => launchUrl(articleUrl),
            child: Text(context.L.article_openInBrowser),
          ),
        ],
      ),
    );
  }
}
