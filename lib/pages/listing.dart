import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frigoligo/providers/article.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/article.dart';
import '../services/wallabag.dart';
import '../string_extension.dart';
import '../widgets/async_action_button.dart';
import '../widgets/icon_toggle_button.dart';
import 'session_details.dart';

final _log = Logger('frigoligo.listing');

class ListingPage extends StatefulWidget {
  const ListingPage({super.key, required this.onItemSelect});

  final void Function(Article) onItemSelect;

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  bool _showFilters = false;
  StateFilter _stateFilter = StateFilter.unread;
  StarredFilter _starredFilter = StarredFilter.all;

  String _makeTitle(ArticlesProvider articles) {
    var prefix = _stateFilter.name.toCapitalCase()!;
    if (_starredFilter == StarredFilter.starred) {
      prefix += ' ★';
    }
    return '$prefix (${articles.count(_stateFilter, _starredFilter)})';
  }

  @override
  Widget build(BuildContext context) {
    var articles = context.watch<ArticlesProvider>();
    var refreshProgressValue = context.select<ArticlesProvider, double?>(
      (articles) => articles.refreshProgressValue,
    );

    // in split mode, select the first article of the list
    var articleProvider = context.read<ArticleProvider?>();
    if (articleProvider != null && articleProvider.articleId == 0) {
      final first = articles.index(0, _stateFilter, _starredFilter);
      if (first != null) {
        articleProvider.updateId(first.id!);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(_makeTitle(articles)),
        actions: [
          IconToggleButton(
            isSelected: _showFilters,
            onPressed: () {
              setState(() => _showFilters = !_showFilters);
            },
            icon: const Icon(Icons.filter_list),
          ),
          AsyncActionButton(
            icon: const Icon(Icons.refresh),
            progressValue: refreshProgressValue,
            onPressed: () => articles.incrementalRefresh(),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'resync',
                child: ListTile(
                  leading: Icon(Icons.sync),
                  title: Text('Resync all articles'),
                ),
              ),
              const PopupMenuItem(
                value: 'session',
                child: ListTile(
                  leading: Icon(Icons.key),
                  title: Text('Session details'),
                ),
              ),
              const PopupMenuItem(
                value: 'about',
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'resync':
                  if (!articles.refreshInProgress) {
                    articles.fullRefresh();
                  }
                case 'session':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SessionDetailsPage()),
                  );
                case 'about':
                  PackageInfo.fromPlatform().then((info) {
                    showAboutDialog(
                      context: context,
                      // applicationIcon: const FlutterLogo(),
                      applicationVersion: '${info.version}+${info.buildNumber}',
                      applicationLegalese: '© 2023 Casimir Lab',
                    );
                  });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilters)
            FilterHeader(
              selectedState: _stateFilter,
              selectedStarred: _starredFilter,
              onStateChange: (stateSelection, starredSelection) {
                setState(() {
                  _stateFilter = stateSelection;
                  _starredFilter = starredSelection;
                });
              },
            ),
          Expanded(
            child: articles.count(_stateFilter, _starredFilter) == 0
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
                          itemCount:
                              articles.count(_stateFilter, _starredFilter),
                          itemBuilder: (context, index) {
                            return ArticleListItem(
                              article: articles.index(
                                  index, _stateFilter, _starredFilter)!,
                              onTap: (article) => widget.onItemSelect(article),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
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
    return InkWell(
      onTap: () => onTap?.call(article),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            article.domainName ?? article.url,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Text('${article.readingTime} min'),
                      ],
                    ),
                    Text(
                      article.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: article.tags
                          .map((tag) => ActionChip(
                                label: Text(tag),
                                onPressed: () {
                                  var snackBar = SnackBar(
                                    content: Text(
                                        'In the future, filtering by tag $tag...'),
                                    duration: const Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              ))
                          .toList()),
                ),
              ),
              Row(
                children: [
                  stateIcons[article.stateValue]!,
                  starredIcons[article.starredValue]!,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
