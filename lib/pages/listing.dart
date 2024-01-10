import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../models/article.dart';
import '../providers/article.dart';
import '../providers/query.dart';
import '../providers/settings.dart';
import '../services/remote_sync.dart';
import '../services/remote_sync_actions/articles.dart';
import '../services/wallabag_storage.dart';
import '../widgets/article_image_preview.dart';
import '../widgets/remote_sync_fab.dart';
import '../widgets/remote_sync_progress_indicator.dart';
import '../widgets/tag_list.dart';
import 'filters.dart';

final _log = Logger('frigoligo.listing');

const listingHeight = 130.0;
const idealListingWidth = 333.3;

class ListingPage extends StatefulWidget {
  const ListingPage({
    super.key,
    required this.onItemSelect,
    this.initialArticleId,
    this.withProgressIndicator = true,
  });

  final void Function(int articleId) onItemSelect;
  final int? initialArticleId;
  final bool withProgressIndicator;

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  @override
  Widget build(BuildContext context) {
    final storage = context.watch<WallabagStorage>();
    final settings = storage.settings;
    final queryProvider = context.watch<QueryProvider>();

    Future<void> doRefresh() async {
      _log.info('triggered refresh');
      await context.read<RemoteSyncer>().synchronize(withFinalRefresh: true);
    }

    final count = storage.count(queryProvider.query);

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
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings', extra: storage),
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemBuilder: (context, index) => ArticleListItem(
                        article: storage.index(index, queryProvider.query)!,
                        onTap: (article) {
                          settings[Sk.selectedArticleId] = article.id;
                          widget.onItemSelect(article.id!);
                        },
                      ),
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

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  bool _showingFilters = false;

  @override
  Widget build(BuildContext context) {
    final queryProvider = context.watch<QueryProvider>();
    var text = switch (queryProvider.query.state!) {
      StateFilter.unread => context.L.listing_articlesUnread,
      StateFilter.archived => context.L.listing_articlesArchived,
      StateFilter.all => context.L.listing_articlesAll,
    };
    if (queryProvider.query.starred == StarredFilter.starred) {
      text += ' (★)';
    }

    final storage = context.watch<WallabagStorage>();

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
          bodyBuilder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: storage),
                ChangeNotifierProvider.value(value: queryProvider),
              ],
              builder: (context, child) {
                return const FiltersPage();
              }),
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

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({super.key, required this.article, this.onTap});

  final Article article;
  final void Function(Article)? onTap;

  @override
  Widget build(BuildContext context) {
    // TODO explore https://pub.dev/packages/flutter_slidable
    // TODO GestureDetector on iOS

    final syncer = context.read<RemoteSyncer>();
    final queryProvider = context.watch<QueryProvider>();
    final selectedId = context.read<ArticleProvider?>()?.articleId;

    return Ink(
      color: selectedId == article.id ? Theme.of(context).hoverColor : null,
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
                        onTagPressed: (tag) =>
                            queryProvider.overrideWith(WQuery(tags: [tag])),
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
                          onPressed: () => syncer
                            ..add(EditArticleAction(
                              article.id!,
                              archive: article.archivedAt == null,
                            ))
                            ..synchronize(),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: starredIcons[article.starredValue]!,
                          onPressed: () => syncer
                            ..add(EditArticleAction(
                              article.id!,
                              starred: article.starredAt == null,
                            ))
                            ..synchronize(),
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
