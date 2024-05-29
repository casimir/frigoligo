import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:popover/popover.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../dialogs/save.dart';
import '../models/article.dart';
import '../providers/article.dart';
import '../providers/query.dart';
import '../services/remote_sync.dart';
import '../services/remote_sync_actions/articles.dart';
import '../services/wallabag_storage.dart';
import '../widget_keys.dart';
import '../widgets/article_image_preview.dart';
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
    this.showSelectedItem = true,
  });

  final void Function(int articleId)? onItemSelect;
  final bool withProgressIndicator;
  final bool showSelectedItem;

  @override
  ConsumerState<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends ConsumerState<ListingPage> {
  final ScrollController _scroller = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.showSelectedItem) {
      final articleId = ref.read(currentArticleProvider)?.id;
      if (articleId != null) {
        final query = ref.read(queryProvider);
        final scrollToIndex =
            ref.read(storageProvider.notifier).indexOf(articleId, query);
        if (scrollToIndex != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scroller.jumpTo(scrollToIndex * listingHeight);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = ref.watch(storageProvider);
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
        title: const TitleWidget(key: Key(wkListingFiltersButton)),
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
          listOrEmpyPlaceholder(
            context,
            count,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RefreshIndicator.adaptive(
                    onRefresh: doRefresh,
                    child: ListView.separated(
                      controller: _scroller,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemBuilder: (context, index) {
                        final article = storage.index(index, query)!;
                        if (index == 0) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ref
                                .read(currentArticleProvider.notifier)
                                .maybeInit(article.id!);
                          });
                        }
                        return ArticleListItem(
                          article: article,
                          onTap: (article) {
                            ref
                                .read(currentArticleProvider.notifier)
                                .change(article.id!);
                            widget.onItemSelect?.call(article.id!);
                          },
                          showSelection: widget.showSelectedItem,
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: count,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: RemoteSyncFAB(showIf: widget.withProgressIndicator),
      restorationId: 'listing.scaffold',
    );
  }
}

Widget listOrEmpyPlaceholder(BuildContext context, int count, Widget child) {
  return Expanded(
    child: count == 0
        ? Center(
            child: Text(
              context.L.listing_noArticles,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        : child,
  );
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

class ArticleListItem extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO explore https://pub.dev/packages/flutter_slidable
    // TODO GestureDetector on iOS

    final selectedId = ref.watch(currentArticleProvider)?.id;

    return Ink(
      color: showSelection && selectedId == article.id
          ? Theme.of(context).highlightColor
          : null,
      child: SizedBox(
        height: listingHeight,
        child: InkWell(
          onTap: () => onTap?.call(article),
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
                                  article.domainName ?? article.url,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Text(
                                context.L
                                    .article_readingTime(article.readingTime),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            article.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (article.previewPicture != null)
                    ArticleImagePreview(article: article)
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
                        tags: article.tags,
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
                        IconButton(
                          visualDensity: VisualDensity.compact,
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
}
