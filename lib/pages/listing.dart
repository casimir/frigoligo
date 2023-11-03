import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/article.dart';
import '../providers/article.dart';
import '../providers/settings.dart';
import '../services/remote_sync.dart';
import '../services/remote_sync_actions/articles.dart';
import '../services/wallabag_storage.dart';
import '../string_extension.dart';
import '../widgets/article_image_preview.dart';
import '../widgets/icon_toggle_button.dart';
import '../widgets/remote_sync_fab.dart';
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

// TODO make it restorable and remove all the other attributes
  WQuery _query = WQuery(state: StateFilter.unread);

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
    var prefix = _query.state!.name.toCapitalCase()!;
    if (_starredFilter.value == StarredFilter.starred) {
      prefix += ' ★';
    }
    return '$prefix (${storage.count(_query)})';
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
      await context.read<RemoteSyncer>().synchronize(withFinalRefresh: true);
    }

    final count = storage.count(_query);

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
              query: _query,
              onStateChange: (WQuery wq) => setState(() {
                _query = wq;
              }),
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
                        article: storage.index(index, _query)!,
                        onTap: (article) {
                          settings[Sk.selectedArticleId] = article.id;
                          widget.onItemSelect(article.id!);
                        },
                        updateQuery: (wq) => setState(() {
                          _query = _query.override(wq);
                        }),
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
              'No articles',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        : child,
  );
}

class FilterHeader extends StatelessWidget {
  const FilterHeader({super.key, required this.query, this.onStateChange});

  final WQuery query;
  final Function(WQuery)? onStateChange;

  @override
  Widget build(BuildContext context) {
    final storage = context.watch<WallabagStorage>();

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
            selected: {query.state},
            onSelectionChanged: (selection) {
              var wq = query.dup();
              wq.state = selection.first;
              onStateChange?.call(wq);
            },
          ),
          SegmentedButton(
            segments: [
              _makeButtonSegment(StarredFilter.all),
              _makeButtonSegment(
                StarredFilter.starred,
                label: starredIcons[StarredFilter.starred]!,
              ),
            ],
            selected: {query.starred},
            onSelectionChanged: (selection) {
              var wq = query.dup();
              wq.starred = selection.first;
              onStateChange?.call(wq);
            },
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: MultiSelectDialogField(
                items:
                    storage.tags.map((it) => MultiSelectItem(it, it)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  var wq = query.dup();
                  wq.tags = values;
                  onStateChange?.call(wq);
                },
                buttonText: const Text('Filter by tags'),
                title: const Text('Tags'),
                searchable: true,
                separateSelectedItems: true,
                initialValue: query.tags ?? List<String>.empty(),
              ),
            ),
            IconButton(
                onPressed: () {
                  var wq = query.dup();
                  wq.tags = [];
                  onStateChange?.call(wq);
                },
                icon: const Icon(Icons.clear)),
          ]),
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
  const ArticleListItem(
      {super.key, required this.article, this.onTap, this.updateQuery});

  final Article article;
  final void Function(Article)? onTap;
  final void Function(WQuery)? updateQuery;

  @override
  Widget build(BuildContext context) {
    // TODO explore https://pub.dev/packages/flutter_slidable
    // TODO GestureDetector on iOS

    final syncer = context.read<RemoteSyncer>();
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
                        onTagPressed: (tag) =>
                            updateQuery?.call(WQuery(tags: [tag])),
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
