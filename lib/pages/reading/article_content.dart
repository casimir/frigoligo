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

typedef ProgressCallback = Future<void> Function(
    double progress, bool isScrolling);
typedef ProgressScrollTo = Future<void> Function(double pixels);
typedef ProgressScroller = Future<void> Function(ProgressScrollTo);

class ArticleContent extends ConsumerStatefulWidget {
  const ArticleContent({super.key, required this.article});

  final Article article;

  @override
  ConsumerState<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends ConsumerState<ArticleContent> {
  Future<void> _onScrollReady(ProgressScrollTo scrollTo) async {
    final scrollPosition =
        await ref.read(scrollPositionProvider(widget.article.id).future);
    final progress = scrollPosition?.progress;
    if (progress != null && progress > 0) {
      await scrollTo(progress);
    }
  }

  Future<void> _onScroll(double progress, bool isScrolling) async {
    ref.read(currentReadingProgressProvider.notifier).progress = progress;

    if (!isScrolling) {
      await DB().articlesDao.saveScrollProgress(widget.article, progress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _HtmlWidgetContent(
      article: widget.article,
      onScrollReady: _onScrollReady,
      onScroll: _onScroll,
    );
  }
}

class _HtmlWidgetContent extends ConsumerWidget {
  const _HtmlWidgetContent({
    required this.article,
    required this.onScrollReady,
    required this.onScroll,
  });

  final Article article;
  final ProgressScroller onScrollReady;
  final ProgressCallback onScroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(readingSettingsProvider);
    return SelectionArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              PaddedGroup(
                child: HtmlWidgetPlus(
                  article.content!,
                  title: article.title,
                  onTreeBuilt: (_) => onScrollReady((progress) async {
                    final controller = PrimaryScrollController.of(context);
                    final pixels =
                        progress * controller.position.maxScrollExtent;
                    controller.jumpTo(pixels);
                  }),
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

  bool _onScrollNotification(ScrollNotification notification) {
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
      onScroll(progress, isScrolling);
    }

    return false;
  }
}
