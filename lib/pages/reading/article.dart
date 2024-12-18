import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../db/extensions/article.dart';
import '../../db/models/article.drift.dart';
import '../../providers/expander.dart';
import '../../services/remote_sync.dart';
import '../../services/remote_sync_actions/articles.dart';
import '../../widget_keys.dart';
import '../../widgets/remote_sync_fab.dart';
import '../../widgets/remote_sync_progress_indicator.dart';
import '../reading_settings_configurator.dart';
import 'article_content.dart';
import 'article_sheet.dart';
import 'mixins.dart';

class ArticlePage extends ConsumerStatefulWidget {
  const ArticlePage({
    super.key,
    this.drawer,
    this.forcedDrawerOpen = false,
    this.withExpander = false,
    this.withProgressIndicator = true,
  });

  final Widget? drawer;
  final bool forcedDrawerOpen;
  final bool withExpander;
  final bool withProgressIndicator;

  @override
  ConsumerState<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlePage>
    with CurrentArticleState<ArticlePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey _shareButtonKey = GlobalKey();
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
    final showBottomBar = !Layout.isExpanded(context);
    final showRemoteSyncerWidgets = widget.withProgressIndicator &&
        !(_scaffoldKey.currentState?.isDrawerOpen ?? false);

    if (article == null) {
      return _PageScaffold(
        scaffoldKey: _scaffoldKey,
        appBarLeading: appBarLeading,
        title: null,
        drawer: widget.drawer,
        forcedDrawerOpen: widget.forcedDrawerOpen,
        withProgressIndicator: showRemoteSyncerWidgets,
        scrollEnabled: false,
        builder: (_, __) => const Center(child: Icon(Icons.question_mark)),
      );
    }

    return _PageScaffold(
      scaffoldKey: _scaffoldKey,
      controller: scroller,
      appBarLeading: appBarLeading,
      title: Builder(builder: (context) {
        return GestureDetector(
          child: Text(
            article.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          onTap: () => Scaffold.of(context).openEndDrawer(),
        );
      }),
      actions: [
        Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          );
        }),
        if (!showBottomBar) ..._buildActions(article),
        IconButton(
          key: const Key(wkArticleReadingSettings),
          icon: const Icon(Icons.format_size),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => const ReadingSettingsConfigurator(),
            barrierColor: Colors.transparent,
            showDragHandle: true,
          ),
        ),
      ],
      bottomActions: showBottomBar ? _buildActions(article) : null,
      drawer: widget.drawer,
      forcedDrawerOpen: widget.forcedDrawerOpen,
      endDrawer: const ArticleSheet(),
      withProgressIndicator: showRemoteSyncerWidgets,
      scrollEnabled: article.content != null,
      builder: (_, scrollKey) => article.content == null
          ? ArticleContentEmpty(articleUrl: Uri.parse(article.url))
          : ArticleContent(article: article, scrollKey: scrollKey!),
    );
  }

  List<IconButton> _buildActions(Article? article) {
    if (article == null) return [];

    return [
      IconButton(
        icon: stateIcons[article.stateValue]!,
        onPressed: () async {
          final syncer = ref.read(remoteSyncerProvider.notifier);
          await syncer.add(EditArticleAction(
            article.id,
            archive: article.archivedAt == null,
          ));
          await syncer.synchronize();
        },
      ),
      IconButton(
        icon: starredIcons[article.starredValue]!,
        onPressed: () async {
          final syncer = ref.read(remoteSyncerProvider.notifier);
          await syncer.add(EditArticleAction(
            article.id,
            starred: article.starredAt == null,
          ));
          await syncer.synchronize();
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final result = await showOkCancelAlertDialog(
            context: context,
            title: context.L.article_delete,
            message: article.title,
            okLabel: context.L.g_delete,
            isDestructiveAction: true,
          );
          if (result == OkCancelResult.cancel) return;
          final syncer = ref.read(remoteSyncerProvider.notifier);
          await syncer.add(DeleteArticleAction(article.id));
          await syncer.synchronize();
          if (!widget.withExpander && mounted) {
            context.go('/');
          }
        },
      ),
      IconButton(
        key: _shareButtonKey,
        icon: shareIcon,
        onPressed: () {
          final box =
              _shareButtonKey.currentContext!.findRenderObject() as RenderBox?;
          Share.share(
            article.url,
            subject: article.title,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
          );
        },
      ),
    ];
  }
}

enum _ProgressIndicatorPosition { none, top, bottom }

typedef _PageScaffoldBodyBuilder = Widget Function(
    BuildContext, GlobalKey<NestedScrollViewState>?);

class _PageScaffold extends StatefulWidget {
  const _PageScaffold({
    required this.scaffoldKey,
    this.controller,
    required this.appBarLeading,
    this.title,
    this.actions = const [],
    this.bottomActions,
    this.drawer,
    required this.forcedDrawerOpen,
    this.endDrawer,
    required this.withProgressIndicator,
    this.scrollEnabled = true,
    required this.builder,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final ScrollController? controller;
  final Widget? appBarLeading;
  final Widget? title;
  final List<Widget> actions;
  final List<Widget>? bottomActions;
  final Widget? drawer;
  final bool forcedDrawerOpen;
  final Widget? endDrawer;
  final bool withProgressIndicator;
  final bool scrollEnabled;
  final _PageScaffoldBodyBuilder builder;

  @override
  State<_PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<_PageScaffold> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (widget.drawer != null && widget.forcedDrawerOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.scaffoldKey.currentState?.openDrawer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var showProgressIndicator = _ProgressIndicatorPosition.none;
    if (widget.withProgressIndicator) {
      showProgressIndicator = widget.bottomActions != null
          ? _ProgressIndicatorPosition.bottom
          : _ProgressIndicatorPosition.top;
    }
    final appBar = SliverAppBar.large(
      leading: widget.appBarLeading,
      title: widget.title,
      actions: widget.actions,
      backgroundColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        final scheme = Theme.of(context).colorScheme;
        return states.contains(WidgetState.scrolledUnder)
            ? scheme.primaryContainer
            : scheme.surface;
      }),
    );
    final body = widget.scrollEnabled
        ? _ScrollableContent(
            scrollKey: _scrollKey,
            appBar: appBar,
            showProgressIndicator: showProgressIndicator,
            body: widget.builder(context, _scrollKey),
          )
        : _NonScrollableContent(
            appBar: appBar,
            showProgressIndicator: showProgressIndicator,
            body: widget.builder(context, null),
          );

    final showRemoteSyncerWidgets = widget.withProgressIndicator &&
        !(widget.scaffoldKey.currentState?.isDrawerOpen ?? false);

    return Scaffold(
      key: widget.scaffoldKey,
      body: body,
      floatingActionButton: RemoteSyncFAB(showIf: showRemoteSyncerWidgets),
      floatingActionButtonLocation: widget.bottomActions != null
          ? FloatingActionButtonLocation.endDocked
          : null,
      drawer: widget.drawer,
      onDrawerChanged: (isOpened) => setState(() {
        // set the state so that the progress indicator widget move correctly
      }),
      endDrawer: widget.endDrawer,
      bottomNavigationBar: widget.bottomActions != null
          ? BottomAppBar(child: Row(children: widget.bottomActions!))
          : null,
    );
  }
}

class _NonScrollableContent extends StatelessWidget {
  const _NonScrollableContent({
    required this.appBar,
    required this.showProgressIndicator,
    required this.body,
  });

  final SliverAppBar appBar;
  final _ProgressIndicatorPosition showProgressIndicator;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        appBar,
        if (showProgressIndicator == _ProgressIndicatorPosition.top)
          const SliverToBoxAdapter(child: RemoteSyncProgressIndicator()),
        SliverFillRemaining(child: body),
        if (showProgressIndicator == _ProgressIndicatorPosition.bottom)
          const SliverToBoxAdapter(child: RemoteSyncProgressIndicator()),
      ],
    );
  }
}

class _ScrollableContent extends StatelessWidget {
  const _ScrollableContent({
    required this.scrollKey,
    required this.appBar,
    required this.showProgressIndicator,
    required this.body,
  });

  final GlobalKey<NestedScrollViewState> scrollKey;
  final SliverAppBar appBar;
  final _ProgressIndicatorPosition showProgressIndicator;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final scrollIndicator = Builder(builder: (context) {
      final controller = scrollKey.currentState!.innerController;
      return LinearScrollIndicator(controller);
    });

    return NestedScrollView(
      key: scrollKey,
      headerSliverBuilder: (context, _) => [
        appBar,
        if (showProgressIndicator == _ProgressIndicatorPosition.top)
          const PinnedHeaderSliver(child: RemoteSyncProgressIndicator()),
      ],
      body: Column(
        children: [
          Expanded(child: body),
          showProgressIndicator == _ProgressIndicatorPosition.bottom
              ? RemoteSyncProgressIndicator(idleWidget: scrollIndicator)
              : scrollIndicator,
        ],
      ),
    );
  }
}

class LinearScrollIndicator extends StatefulWidget {
  const LinearScrollIndicator(this.controller, {super.key});

  final ScrollController controller;

  @override
  State<LinearScrollIndicator> createState() => _LinearScrollIndicatorState();
}

class _LinearScrollIndicatorState extends State<LinearScrollIndicator> {
  double _scrollProgress = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollListener());
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final pixels = widget.controller.position.pixels;
    final maxExtent = widget.controller.position.maxScrollExtent;
    setState(() {
      // until there has been a scroll event, maxExtent is 0.0
      _scrollProgress = pixels > 0.0 ? (pixels / maxExtent).clamp(0, 1) : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _scrollProgress,
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
