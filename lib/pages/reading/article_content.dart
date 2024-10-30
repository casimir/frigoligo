import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../buildcontext_extension.dart';
import '../../db/models/article.drift.dart';
import '../../providers/article.dart';
import '../../providers/reading_settings.dart';

class HtmlWidgetFactory extends WidgetFactory
    with CachedNetworkImageFactory, UrlLauncherFactory {
  HtmlWidgetFactory({this.onTreeBuilt});

  void Function(Widget)? onTreeBuilt;

  @override
  Widget buildBodyWidget(BuildContext context, Widget child) {
    final body = super.buildBodyWidget(context, child);
    onTreeBuilt?.call(body);
    return body;
  }
}

class HtmlWidgetPlus extends StatelessWidget {
  const HtmlWidgetPlus(
    this.html, {
    super.key,
    this.onTreeBuilt,
    this.textStyle,
  });

  final String html;
  final void Function(Widget)? onTreeBuilt;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      factoryBuilder: () => HtmlWidgetFactory(
        onTreeBuilt: (child) =>
            WidgetsBinding.instance.addPostFrameCallback((_) {
          onTreeBuilt?.call(child);
        }),
      ),
      textStyle: textStyle,
    );
  }
}

class ArticleContent extends ConsumerStatefulWidget {
  const ArticleContent({
    super.key,
    required this.article,
    required this.scrollKey,
  });

  final Article article;
  final GlobalKey<NestedScrollViewState> scrollKey;

  @override
  ConsumerState<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends ConsumerState<ArticleContent> {
  ScrollController get controller =>
      widget.scrollKey.currentState!.innerController;

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final pixels = controller.position.pixels;
    final maxExtent = controller.position.maxScrollExtent;
    final double progress = (pixels / maxExtent).clamp(0, 1);
    ref.read(currentArticleProvider.notifier).saveScrollProgress(progress);
  }

  // As of version 2.0 there seem to be a random issue with the correct scroll
  // position being restored. The offset is kind of correct so it should be ok
  // on a normal usage but it's not perfect.
  Future<void> _jumpToProgress() async {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          PaddedGroup(
            child: HtmlWidgetPlus(
              widget.article.content!,
              onTreeBuilt: (_) => _jumpToProgress(),
              textStyle: ref.watch(readingSettingsProvider).textStyle,
            ),
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
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
