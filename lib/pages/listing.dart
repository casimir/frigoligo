import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frigoligo/services/remote_sync.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/article.dart';
import '../providers/article.dart';
import '../providers/settings.dart';
import '../services/wallabag_storage.dart';
import '../string_extension.dart';
import '../widgets/article_image_preview.dart';
import '../widgets/icon_toggle_button.dart';
import '../widgets/remote_sync_progress_indicator.dart';
import '../widgets/tag_list.dart';

final _log = Logger('frigoligo.listing');

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

  String _makeTitle(WallabagStorage storage) {
    var prefix = _stateFilter.value.name.toCapitalCase()!;
    if (_starredFilter.value == StarredFilter.starred) {
      prefix += ' ★';
    }
    return '$prefix (${storage.count(_stateFilter.value, _starredFilter.value)})';
  }

  @override
  Widget build(BuildContext context) {
    final storage = context.watch<WallabagStorage>();
    final settings = storage.settings;

    storage.onError = (error) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    };

    Future<void> doRefresh() async {
      _log.info('triggered refresh');
      await context.read<RemoteSync>().synchronize(withFinalRefresh: true);
    }

    final count = storage.count(_stateFilter.value, _starredFilter.value);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_makeTitle(storage)),
        actions: [
          IconToggleButton(
            isSelected: _showFilters.value,
            onPressed: () {
              setState(() => _showFilters.value = !_showFilters.value);
            },
            icon: const Icon(Icons.filter_list),
          ),
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
                        article: storage.index(
                            index, _stateFilter.value, _starredFilter.value)!,
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
      restorationId: 'listing.scaffold',
    );
  }
}

Widget listOrEmpyPlaceholder(BuildContext context, int count, Widget child) {
  return Expanded(
    child: count == 0
        ? Center(
            child: Text(
              'No articles',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        : child,
  );
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
                        onTagPressed: (tag) {
                          var snackBar = SnackBar(
                            content:
                                Text('In the future, filtering by tag $tag...'),
                            duration: const Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
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
      ),
    );
  }
}
