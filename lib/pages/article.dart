import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../models/article.dart';
import '../models/article_scroll_position.dart';
import '../providers/article.dart';
import '../providers/expander.dart';
import '../providers/reading_settings.dart';
import '../services/remote_sync.dart';
import '../services/remote_sync_actions/articles.dart';
import '../widget_keys.dart';
import '../widgets/remote_sync_fab.dart';
import '../widgets/remote_sync_progress_indicator.dart';
import '../widgets/tag_list.dart';
import 'reading_settings_configurator.dart';
import 'tags_selector/dialog.dart';

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

class _ArticlePageState extends ConsumerState<ArticlePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final scroller = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.drawer != null && widget.forcedDrawerOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scaffoldKey.currentState?.openDrawer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final article = ref.watch(currentArticleProvider);

    Widget? leading;
    if (widget.withExpander) {
      leading = IconButton(
        key: const Key(wkArticleExpanderToggle),
        icon: Icon(
          ref.watch(expanderProvider)
              ? Icons.list
              : Icons.keyboard_double_arrow_left,
        ),
        onPressed: () => ref.watch(expanderProvider.notifier).toggle(),
      );
    }

    late final Widget body;
    if (article == null) {
      body = _buildNoArticle();
    } else if (article.content == null) {
      body = _buildEmptyContent(Uri.parse(article.url));
    } else {
      body = _buildArticleContent(article);
    }

    final showRemoteSyncerWidgets = widget.withProgressIndicator &&
        !(_scaffoldKey.currentState?.isDrawerOpen ?? false);

    return SelectionArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: leading,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            if (article != null)
              IconButton(
                icon: stateIcons[article.stateValue]!,
                onPressed: () {
                  ref.read(remoteSyncerProvider.notifier)
                    ..add(EditArticleAction(
                      article.id!,
                      archive: article.archivedAt == null,
                    ))
                    ..synchronize();
                },
              ),
            if (article != null)
              IconButton(
                icon: starredIcons[article.starredValue]!,
                onPressed: () {
                  ref.read(remoteSyncerProvider.notifier)
                    ..add(EditArticleAction(
                      article.id!,
                      starred: article.starredAt == null,
                    ))
                    ..synchronize();
                },
              ),
            PopupMenuButton(
              key: const Key(wkArticlePopupMenu),
              itemBuilder: (context) => [
                PopupMenuItem(
                  key: const Key(wkArticlePopupMenuSettings),
                  value: 'reading-settings',
                  child: ListTile(
                    leading: const Icon(Icons.format_size),
                    title: Text(context.L.readingsettings_title),
                  ),
                ),
                PopupMenuItem(
                  value: 'share',
                  enabled: article != null,
                  child: ListTile(
                    leading: shareIcon,
                    title: Text(context.L.g_share),
                  ),
                ),
                PopupMenuItem(
                  value: 'open',
                  enabled: article != null,
                  child: ListTile(
                    leading: const Icon(Icons.open_in_browser),
                    title: Text(context.L.article_openInBrowser),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  enabled: article != null,
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: Text(context.L.g_delete),
                  ),
                ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case 'reading-settings':
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => const ReadingSettingsConfigurator(),
                      barrierColor: Colors.transparent,
                      showDragHandle: true,
                    );
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
                    final result = await showOkCancelAlertDialog(
                      context: context,
                      title: context.L.article_delete,
                      message: article!.title,
                      okLabel: context.L.g_delete,
                      isDestructiveAction: true,
                    );
                    if (result == OkCancelResult.cancel) return;
                    final syncer = ref.read(remoteSyncerProvider.notifier);
                    syncer.add(DeleteArticleAction(article.id!));
                    await syncer.synchronize();
                    if (!widget.withExpander && context.mounted) {
                      context.go('/');
                    }
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            if (showRemoteSyncerWidgets) const RemoteSyncProgressIndicator(),
            Expanded(child: body),
          ],
        ),
        floatingActionButton: RemoteSyncFAB(showIf: showRemoteSyncerWidgets),
        drawer: widget.drawer,
        onDrawerChanged: (isOpened) => setState(() {
          // set the state so that the progress indicator widget move correctly
        }),
      ),
    );
  }

  Widget _buildNoArticle() {
    return const Center(child: Icon(Icons.question_mark));
  }

  Widget _buildEmptyContent(Uri articleUrl) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.L.article_noContentFetched,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () => launchUrl(articleUrl),
            child: Text(context.L.article_openInBrowser),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleContent(Article article) {
    void showTagsDialog([_]) => showDialog(
          context: context,
          builder: (_) => TagsSelectorDialog(
            tags: ref.read(storageProvider).tags,
            initialValue: article.tags,
            onConfirm: (tags) {
              ref.read(remoteSyncerProvider.notifier)
                ..add(EditArticleAction(article.id!, tags: tags))
                ..synchronize();
            },
          ),
        );

    final scrollPositionFetch = ref.watch(scrollPositionProvider(article.id!));
    return scrollPositionFetch.when(
      data: (scrollPosition) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              final progress =
                  scroller.offset / scroller.position.maxScrollExtent;
              ref
                  .read(currentArticleProvider.notifier)
                  .saveScrollProgress(progress);
            }
            return false;
          },
          child: Scrollbar(
            controller: scroller,
            child: SingleChildScrollView(
              controller: scroller,
              child: Column(
                children: [
                  _buildHeader(article),
                  article.tags.isNotEmpty
                      ? TagList(
                          tags: article.tags, onTagPressed: showTagsDialog)
                      : TextButton(
                          onPressed: showTagsDialog,
                          child: Text(context.L.article_addTags),
                        ),
                  const Divider(),
                  _buildContent(article.content!, scrollPosition),
                  // TODO use SafeArea instead?
                  // use the same padding as SafeArea.bottom
                  SizedBox(height: MediaQuery.paddingOf(context).bottom),
                ],
              ),
            ),
          ),
        );
      },
      error: (e, _) => Center(child: ErrorScreen(error: e as Exception)),
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _buildHeader(Article article) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    );
  }

  Widget _buildContent(String content, ArticleScrollPosition? scrollPosition) {
    final values = ref.watch(readingSettingsProvider);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: HtmlWidget(
        content,
        factoryBuilder: () => HtmlWidgetFactory(
          onTreeBuilt: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollPosition != null && scrollPosition.progress > 0) {
              final pixels =
                  scrollPosition.progress * scroller.position.maxScrollExtent;
              scroller.jumpTo(pixels);
            }
          }),
        ),
        textStyle: values.textStyle,
      ),
    );
  }
}

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
