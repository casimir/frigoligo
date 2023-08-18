import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/article.dart';
import '../providers/article.dart';
import '../services/wallabag.dart';
import '../string_extension.dart';
import '../widgets/async_action_button.dart';
import '../widgets/icon_toggle_button.dart';

final _log = Logger('frigoligo.listing');

class ListingPage extends StatefulWidget {
  const ListingPage({super.key, required this.onItemSelect});

  final void Function(Article) onItemSelect;

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> with RestorationMixin {
  final RestorableBool _showFilters = RestorableBool(false);
  final RestorableEnum<StateFilter> _stateFilter =
      RestorableEnum(StateFilter.unread, values: StateFilter.values);
  final RestorableEnum<StarredFilter> _starredFilter =
      RestorableEnum(StarredFilter.all, values: StarredFilter.values);

  @override
  String? get restorationId => 'listing';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_showFilters, 'listing.showFilters');
    registerForRestoration(_stateFilter, 'listing.stateFilter');
    registerForRestoration(_starredFilter, 'listing.starredFilter');
  }

  @override
  void dispose() {
    _showFilters.dispose();
    _stateFilter.dispose();
    _starredFilter.dispose();
    super.dispose();
  }

  String _makeTitle(ArticlesProvider articles) {
    var prefix = _stateFilter.value.name.toCapitalCase()!;
    if (_starredFilter.value == StarredFilter.starred) {
      prefix += ' ★';
    }
    return '$prefix (${articles.count(_stateFilter.value, _starredFilter.value)})';
  }

  @override
  Widget build(BuildContext context) {
    final articles = context.watch<ArticlesProvider>();
    final refreshProgressValue = context.select<ArticlesProvider, double?>(
      (articles) => articles.refreshProgressValue,
    );

    // in split mode, select the first article of the list
    final articleProvider = context.read<ArticleProvider?>();
    if (articleProvider != null && articleProvider.articleId == 0) {
      final first = articles.index(0, _stateFilter.value, _starredFilter.value);
      if (first != null) {
        articleProvider.updateId(first.id);
      }
    }

    articles.onError = (error) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(_makeTitle(articles)),
        actions: [
          IconToggleButton(
            isSelected: _showFilters.value,
            onPressed: () {
              setState(() => _showFilters.value = !_showFilters.value);
            },
            icon: const Icon(Icons.filter_list),
          ),
          AsyncActionButton(
            icon: const Icon(Icons.refresh),
            progressValue: refreshProgressValue,
            onPressed: () {
              _log.info('user action > incremental refresh');
              articles.incrementalRefresh();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings', extra: articles),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilters.value)
            FilterHeader(
              selectedState: _stateFilter.value,
              selectedStarred: _starredFilter.value,
              onStateChange: (stateSelection, starredSelection) {
                setState(() {
                  _stateFilter.value = stateSelection;
                  _starredFilter.value = starredSelection;
                });
              },
            ),
          Expanded(
            child: articles.count(_stateFilter.value, _starredFilter.value) == 0
                ? Center(
                    child: Text(
                      'No articles',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: articles.count(
                              _stateFilter.value, _starredFilter.value),
                          itemBuilder: (context, index) {
                            return ArticleListItem(
                              article: articles.index(index, _stateFilter.value,
                                  _starredFilter.value)!,
                              onTap: (article) => widget.onItemSelect(article),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          restorationId: 'listing.list',
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      restorationId: 'listing.scaffold',
    );
  }
}

class FilterHeader extends StatelessWidget {
  const FilterHeader({
    super.key,
    required this.selectedState,
    required this.selectedStarred,
    this.onStateChange,
  });

  final StateFilter selectedState;
  final StarredFilter selectedStarred;
  final Function(StateFilter, StarredFilter)? onStateChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          SegmentedButton(
            segments: [
              _makeButtonSegment(StateFilter.all),
              _makeButtonSegment(StateFilter.unread),
              _makeButtonSegment(StateFilter.archived),
            ],
            selected: {selectedState},
            onSelectionChanged: (selection) =>
                onStateChange?.call(selection.first, selectedStarred),
          ),
          SegmentedButton(
            segments: [
              _makeButtonSegment(StarredFilter.all),
              _makeButtonSegment(
                StarredFilter.starred,
                label: starredIcons[StarredFilter.starred]!,
              ),
            ],
            selected: {selectedStarred},
            onSelectionChanged: (selection) =>
                onStateChange?.call(selectedState, selection.first),
          )
        ],
      ),
    );
  }
}

ButtonSegment<T> _makeButtonSegment<T extends Enum>(T value, {Widget? label}) {
  return ButtonSegment(
    value: value,
    label: label ?? Text(value.name.toCapitalCase()!),
  );
}

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({super.key, required this.article, this.onTap});

  final Article article;
  final void Function(Article)? onTap;

  @override
  Widget build(BuildContext context) {
    // TODO explore https://pub.dev/packages/flutter_slidable
    // TODO GestureDetector on iOS
    return SizedBox(
      height: 130,
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
                                style: Theme.of(context).textTheme.labelMedium,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Text(
                              '${article.readingTime} min',
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
                  SizedBox(
                    width: 80,
                    height: 80,
                    child:
                        // https://github.com/Baseflow/flutter_cached_network_image/issues/383
                        article.previewPicture!.endsWith('.svg')
                            ? SvgPicture.network(
                                article.previewPicture!,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: article.previewPicture!,
                                errorWidget: (context, url, error) {
                                  _log.severe(
                                      'article:${article.id} failed to load image',
                                      error);
                                  return const Icon(Icons.error);
                                },
                                fit: BoxFit.cover,
                              ),
                  )
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
                    child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: article.tags
                            .map((tag) => ActionChip(
                                  label: Text(tag),
                                  labelStyle:
                                      Theme.of(context).textTheme.labelSmall,
                                  onPressed: () {
                                    var snackBar = SnackBar(
                                      content: Text(
                                          'In the future, filtering by tag $tag...'),
                                      duration: const Duration(seconds: 1),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  padding: const EdgeInsets.all(2.0),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                ))
                            .toList()),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      stateIcons[article.stateValue]!,
                      starredIcons[article.starredValue]!,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
