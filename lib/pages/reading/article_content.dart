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
  double? _lastSavedProgress;
  ScrollController? _scroller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scroller = PrimaryScrollController.of(context);
      _scroller!.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _scroller?.removeListener(_scrollListener);
    super.dispose();
  }

  Future<void> _scrollListener() async {
    final controller = _scroller!;
    final pixels = controller.position.pixels;
    final maxExtent = controller.position.maxScrollExtent;
    final double progress = (pixels / maxExtent).clamp(0, 1);
    await _onScrollUpdate(progress);
  }

  Future<void> _onScrollUpdate(double progress) async {
    ref.read(currentReadingProgressProvider.notifier).progress = progress;

    // throttle saving in DB by requiring at least some progress (in %)
    const percThreshold = 1 / 100;
    final delta = _lastSavedProgress != null
        ? (_lastSavedProgress! - progress).abs()
        : percThreshold;
    if (delta >= percThreshold) {
      await DB().articlesDao.saveScrollProgress(widget.article, progress);
      _lastSavedProgress = progress;
    }
  }

  Future<void> _jumpToProgress() async {
    final controller = _scroller!;
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
      child: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            PaddedGroup(
              child: HtmlWidgetPlus(
                widget.article.content!,
                title: widget.article.title,
                onTreeBuilt: (_) => _jumpToProgress(),
                justifyText: settings.justifyText,
                textStyle: settings.textStyle,
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
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
