import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:popover/popover.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../db/database.dart';
import '../db/extensions/article.dart';
import '../dialogs/save.dart';
import '../providers/article.dart';
import '../providers/query.dart';
import '../services/remote_sync.dart';
import '../services/remote_sync_actions/articles.dart';
import '../services/wallabag_storage.dart';
import '../widget_keys.dart';
import '../widgets/article_image_preview.dart';
import '../widgets/async/list.dart';
import '../widgets/remote_sync_fab.dart';
import '../widgets/remote_sync_progress_indicator.dart';
import '../widgets/tag_list.dart';
import 'filters.dart';

final _log = Logger('frigoligo.listing');

const listingHeight = 130.0;
const idealListingWidth = 333.3;

class ListingPage extends ConsumerStatefulWidget {
  const ListingPage({
    super.key,
    this.onItemSelect,
    this.withProgressIndicator = true,
    this.sideBySideMode = true,
  });

  final void Function(int articleId)? onItemSelect;
  final bool withProgressIndicator;
  final bool sideBySideMode;

  @override
  ConsumerState<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends ConsumerState<ListingPage> {
  final ScrollController _scroller = ScrollController();

  void _openArticle(int articleId) {
    ref.read(currentArticleProvider.notifier).change(articleId);
    widget.onItemSelect?.call(articleId);
  }

  @override
  void initState() {
    super.initState();

    if (widget.sideBySideMode) {
      () async {
        final article = await ref.read(currentArticleProvider.future);
        if (article?.id != null) {
          final query = ref.read(queryProvider);
          final scrollToIndex = await ref
              .read(wStorageProvider.notifier)
              .indexOf(article!.id, query);
          if (scrollToIndex != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scroller.jumpTo(scrollToIndex * listingHeight);
            });
          }
        }
      }();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(wStorageProvider);

    final pendingOpenArticleId = ref.watch(openArticleProvider);
    if (pendingOpenArticleId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(openArticleProvider.notifier).reset();
        _openArticle(pendingOpenArticleId);
      });
    }

    final storage = ref.watch(wStorageProvider.notifier);
    final query = ref.watch(queryProvider);

    Future<void> doRefresh() async {
      _log.info('triggered refresh');
      await ref
          .read(remoteSyncerProvider.notifier)
          .synchronize(withFinalRefresh: true);
    }

    final count = storage.count(query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const TitleWidget(),
        actions: [
          if (!pullToRefreshSupported)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: doRefresh,
            ),
          IconButton(
            icon: const Icon(Icons.add_link),
            onPressed: () => showSaveUrlDialog(context),
          ),
          IconButton(
            key: const Key(wkListingSettings),
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          if (widget.withProgressIndicator) const RemoteSyncProgressIndicator(),
          AListView.separated(
            itemCount: count,
            itemBuilder: (context, index) async {
              if (index == 0) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  storage.index(index, query).then((article) => ref
                      .read(currentArticleProvider.notifier)
                      .maybeInit(article!.id));
                });
              }
              return ArticleListItem(
                article: (await storage.index(index, query))!,
                onTap: (article) => _openArticle(article.id),
                showSelection: widget.sideBySideMode,
              );
            },
            itemHeight: listingHeight,
            separatorBuilder: (context, index) => const Divider(),
            create: (context, child) => Expanded(
                child: RefreshIndicator.adaptive(
              onRefresh: doRefresh,
              child: child,
            )),
            emptyBuilder: (context) => Expanded(
              child: Center(
                child: Text(
                  context.L.listing_noArticles,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: RemoteSyncFAB(showIf: widget.withProgressIndicator),
      restorationId: 'listing.scaffold',
    );
  }
}

class TitleWidget extends ConsumerStatefulWidget {
  const TitleWidget({super.key});

  @override
  ConsumerState<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends ConsumerState<TitleWidget> {
  bool _showingFilters = false;

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(queryProvider);
    var text = switch (query.state!) {
      StateFilter.unread => context.L.listing_articlesUnread,
      StateFilter.archived => context.L.listing_articlesArchived,
      StateFilter.all => context.L.listing_articlesAll,
    };
    if (query.starred == StarredFilter.starred) {
      text += ' (★)';
    }

    return GestureDetector(
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          _showingFilters
              ? const Icon(Icons.expand_less)
              : const Icon(Icons.expand_more),
        ],
      ),
      onTap: () {
        setState(() {
          _showingFilters = !_showingFilters;
        });
        showPopover(
          context: context,
          bodyBuilder: (context) => const FiltersPage(),
          direction: PopoverDirection.top,
          backgroundColor: Theme.of(context).colorScheme.surface,
          transitionDuration: const Duration(milliseconds: 150),
          constraints: const BoxConstraints(maxWidth: idealListingWidth),
          onPop: () => setState(() {
            _showingFilters = false;
          }),
        );
      },
    );
  }
}

class AsyncArticleItem extends ConsumerWidget {
  const AsyncArticleItem({
    super.key,
    required this.article,
    this.onTap,
    required this.showSelection,
  });

  final Article article;
  final void Function(Article)? onTap;
  final bool showSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(currentArticleProvider).when(
          data: (selected) => ArticleListItem(
                article: article,
                onTap: onTap,
                showSelection: showSelection,
              ),
          error: (e, st) => throw Exception('unreachable branch but $e'),
          loading: () => const SizedBox(
                height: listingHeight,
                child: Center(child: CircularProgressIndicator.adaptive()),
              ));
}

class ArticleListItem extends ConsumerStatefulWidget {
  const ArticleListItem({
    super.key,
    required this.article,
    this.onTap,
    required this.showSelection,
  });

  final Article article;
  final void Function(Article)? onTap;
  final bool showSelection;

  @override
  ConsumerState<ArticleListItem> createState() => _ArticleListItemState();
}

class _ArticleListItemState extends ConsumerState<ArticleListItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    // TODO explore https://pub.dev/packages/flutter_slidable
    // TODO GestureDetector on iOS

    _listenToSelectionChange(ref);

    return Ink(
      color: widget.showSelection && _isSelected
          ? Theme.of(context).highlightColor
          : null,
      child: SizedBox(
        height: listingHeight,
        child: InkWell(
          onTap: () => widget.onTap?.call(widget.article),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.article.domainName ??
                                      widget.article.url,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Text(
                                context.L.article_readingTime(
                                    widget.article.readingTime),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            widget.article.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (widget.article.previewPicture != null)
                    ArticleImagePreview(article: widget.article)
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TagList(
                        tags: widget.article.tags,
                        onTagPressed: (tag) => ref
                            .read(queryProvider.notifier)
                            .overrideWith(WQuery(tags: [tag])),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: stateIcons[widget.article.stateValue]!,
                          onPressed: () async {
                            final syncer =
                                ref.read(remoteSyncerProvider.notifier);
                            await syncer.add(EditArticleAction(
                              widget.article.id,
                              archive: widget.article.archivedAt == null,
                            ));
                            await syncer.synchronize();
                          },
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: starredIcons[widget.article.starredValue]!,
                          onPressed: () async {
                            final syncer =
                                ref.read(remoteSyncerProvider.notifier);
                            await syncer.add(EditArticleAction(
                              widget.article.id,
                              starred: widget.article.starredAt == null,
                            ));
                            await syncer.synchronize();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listenToSelectionChange(WidgetRef ref) async {
    final currentArticleId =
        await ref.watch(currentArticleProvider.selectAsync((it) => it?.id));
    setState(() {
      _isSelected = currentArticleId == widget.article.id;
    });
  }
}
