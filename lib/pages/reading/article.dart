import 'package:cadanse/components/widgets/adaptive/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/models/article.drift.dart';
import '../../providers/article.dart';
import '../../providers/expander.dart';
import '../../widget_keys.dart';
import '../../widgets/remote_sync_fab.dart';
import '../../widgets/remote_sync_progress_indicator.dart';
import 'actions.dart';
import 'article_content.dart';
import 'article_sheet.dart';
import 'mixins.dart';

class ArticlePage extends ConsumerStatefulWidget {
  const ArticlePage({
    super.key,
    this.withExpander = false,
    this.withProgressIndicator = true,
  });

  final bool withExpander;
  final bool withProgressIndicator;

  @override
  ConsumerState<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlePage>
    with CurrentArticleState<ArticlePage> {
  final ScrollController scroller = ScrollController();

  @override
  void dispose() {
    scroller.dispose();
    super.dispose();
  }

  Widget? get appBarLeading {
    if (!widget.withExpander) return null;

    return IconButton(
      key: const Key(wkArticleExpanderToggle),
      icon: Icon(
        ref.watch(expanderProvider)
            ? Icons.list
            : Icons.keyboard_double_arrow_left,
      ),
      onPressed: () => ref.watch(expanderProvider.notifier).toggle(),
    );
  }

  @override
  Widget buildArticle(BuildContext context, Article? article) {
    if (article == null) {
      return _PageScaffold(
        appBarLeading: appBarLeading,
        withProgressIndicator: widget.withProgressIndicator,
        scrollEnabled: false,
        builder: (_) => const Center(child: Icon(Icons.question_mark)),
      );
    }

    return _PageScaffold(
      controller: scroller,
      appBarLeading: appBarLeading,
      actions: buildActions(context, ref, article, widget.withExpander),
      endDrawer: const ArticleSheet(),
      withProgressIndicator: widget.withProgressIndicator,
      scrollEnabled: article.content != null,
      builder:
          (_) =>
              article.content == null
                  ? ArticleContentEmpty(articleUrl: Uri.parse(article.url))
                  : ArticleContent(article: article),
    );
  }
}

class _PageScaffold extends StatelessWidget {
  const _PageScaffold({
    this.controller,
    required this.appBarLeading,
    this.actions = const [],
    this.endDrawer,
    required this.withProgressIndicator,
    this.scrollEnabled = true,
    required this.builder,
  });

  final ScrollController? controller;
  final Widget? appBarLeading;
  final List<Widget> actions;
  final Widget? endDrawer;
  final bool withProgressIndicator;
  final bool scrollEnabled;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBarBottom =
        withProgressIndicator
            ? const RemoteSyncProgressIndicator(
              idleWidget: ReadingProgressIndicator(),
            )
            : const ReadingProgressIndicator();

    return AdaptiveScaffold(
      barData: AdaptiveBarData(
        leading: appBarLeading,
        actions: actions,
        bottom: appBarBottom,
      ),
      body: builder(context),
      floatingActionButton: RemoteSyncFAB(showIf: withProgressIndicator),
      endDrawer: endDrawer,
    );
  }
}

class ReadingProgressIndicator extends ConsumerWidget
    implements PreferredSizeWidget {
  const ReadingProgressIndicator({
    super.key,
    this.hideWhenNoProgress = true,
    this.height,
  });

  final bool hideWhenNoProgress;
  final double? height;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 4.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(currentReadingProgressProvider);

    if ((progress == null || progress == 0) && hideWhenNoProgress) {
      return SizedBox(
        height: Theme.of(context).progressIndicatorTheme.linearMinHeight,
      );
    }

    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
