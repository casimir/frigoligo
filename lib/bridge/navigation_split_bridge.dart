// coverage:ignore-file
import 'dart:async';
import 'dart:convert';

import '../config/dependencies.dart';
import '../data/services/local/storage/config_store_service.dart';
import '../domain/models/query.dart';
import '../domain/sync/sync_manager.dart';
import '../pigeon/navigation_split.g.dart';
import '../ui/home/controllers/listing_container_controller.dart';
import '../ui/home/controllers/search_panel_controller.dart';
import 'article_sheet_bridge.dart';

class NavigationSplitBridge implements NavigationSplitFlutterApi {
  NavigationSplitBridge({
    required ConfigStoreService configStoreService,
    required ArticleRepository articleRepository,
    required QueryRepository queryRepository,
  }) : _configStoreService = configStoreService,
       _articleRepository = articleRepository,
       _queryRepository = queryRepository,
       _searchPanelController = SearchPanelController(
         queryRepository: queryRepository,
       ),
       _listingController = ListingContainerController(
         syncManager: SyncManager.instance,
       ) {
    NavigationSplitFlutterApi.setUp(this);
    _idsSubscription = queryRepository.watchArticleIds().listen((ids) {
      unawaited(_api.updateArticleIds(ids));
    });
    unawaited(_pushFilterState());
    _querySubscription = queryRepository.queryStream.listen((_) {
      unawaited(_pushFilterState());
    });
    _settingsSubscription = configStoreService
        .watch<dynamic>('readingSettings')
        .listen((json) {
          unawaited(_api.updateReadingSettings(_settingsFromJson(json)));
        });
    SyncManager.instance.addListener(_onSyncState);
  }

  final ConfigStoreService _configStoreService;
  final ArticleRepository _articleRepository;
  final QueryRepository _queryRepository;
  final SearchPanelController _searchPanelController;
  final ListingContainerController _listingController;
  final NavigationSplitApi _api = NavigationSplitApi();

  StreamSubscription<List<int>>? _idsSubscription;
  StreamSubscription<Query>? _querySubscription;
  StreamSubscription<String?>? _contentSubscription;
  StreamSubscription<ArticleRowData?>? _dataSubscription;
  StreamSubscription<dynamic>? _settingsSubscription;

  static ArticleReadingSettings _settingsFromJson(dynamic json) {
    final map = switch (json) {
      String s => jsonDecode(s) as Map<dynamic, dynamic>?,
      Map m => m,
      _ => null,
    };
    return ArticleReadingSettings(
      fontSize: (map?['fontSize'] as num?)?.toDouble() ?? 16.0,
      fontFamily: (map?['fontFamily'] as String?) ?? 'Lato',
      justifyText: (map?['justifyText'] as bool?) ?? false,
    );
  }

  void _onSyncState(SyncState state) {
    unawaited(
      _api.updateSyncState(
        NavigationSyncState(
          isWorking: state.isWorking,
          progressValue: state.progressValue,
          pendingCount: state.pendingCount,
        ),
      ),
    );
  }

  Future<void> _pushFilterState() async {
    final q = _queryRepository.query;
    await _api.updateFilterState(
      NavigationFilterState(
        text: q.text,
        textMode: switch (q.textMode) {
          SearchTextMode.all => NavigationSearchTextMode.all,
          SearchTextMode.title => NavigationSearchTextMode.title,
          SearchTextMode.content => NavigationSearchTextMode.content,
        },
        stateFilter: switch (q.state) {
          StateFilter.all => NavigationStateFilter.all,
          StateFilter.unread => NavigationStateFilter.unread,
          StateFilter.archived => NavigationStateFilter.archived,
        },
        onlyStarred: q.onlyStarred,
        tags: q.tags,
        domains: q.domains,
      ),
    );
  }

  static ArticleRowData _rowDataFrom(dynamic a) {
    return ArticleRowData(
      id: a.id,
      title: a.title,
      domainName: a.domainName,
      readingTime: a.readingTime,
      previewPictureUrl: a.previewPicture,
      tags: a.tags,
      isArchived: a.isArchived,
      isStarred: a.isStarred,
      url: a.url,
    );
  }

  @override
  Future<ArticleRowData> getArticleRowData(int id) async {
    final article = await _articleRepository
        .watchData(id)
        .where((a) => a != null)
        .first;
    return _rowDataFrom(article!);
  }

  @override
  Future<List<String>> getAvailableTags() =>
      _queryRepository.listAvailableTags();

  @override
  Future<List<String>> getAvailableDomains() =>
      _queryRepository.listAvailableDomains();

  @override
  void setSearchText(String text) => _searchPanelController.setText(text);

  @override
  void setTextMode(NavigationSearchTextMode mode) =>
      _searchPanelController.setTextMode(switch (mode) {
        NavigationSearchTextMode.all => SearchTextMode.all,
        NavigationSearchTextMode.title => SearchTextMode.title,
        NavigationSearchTextMode.content => SearchTextMode.content,
      });

  @override
  void setStateFilter(NavigationStateFilter state) =>
      _searchPanelController.setState(switch (state) {
        NavigationStateFilter.all => StateFilter.all,
        NavigationStateFilter.unread => StateFilter.unread,
        NavigationStateFilter.archived => StateFilter.archived,
      });

  @override
  void setOnlyStarred(bool onlyStarred) =>
      _searchPanelController.setOnlyStarred(onlyStarred);

  @override
  void setTags(List<String> tags) => _searchPanelController.setTags(tags);

  @override
  void setDomains(List<String> domains) =>
      _searchPanelController.setDomains(domains);

  @override
  Future<void> setArticleArchived(int id, bool archived) =>
      _editArticle(id, archived: archived);

  @override
  Future<void> setArticleStarred(int id, bool starred) =>
      _editArticle(id, starred: starred);

  @override
  Future<void> setReadingSettings(ArticleReadingSettings settings) async {
    final existing = _configStoreService.get<String>('readingSettings');
    final map = existing != null
        ? Map<String, dynamic>.from(jsonDecode(existing) as Map)
        : <String, dynamic>{};
    map['fontSize'] = settings.fontSize;
    map['fontFamily'] = settings.fontFamily;
    map['justifyText'] = settings.justifyText;
    await _configStoreService.set('readingSettings', jsonEncode(map));
  }

  @override
  Future<void> refresh() => _listingController.refresh();

  @override
  void filterByTag(String tag) => _searchPanelController.setTags([tag]);

  @override
  Future<void> deleteArticle(int id) async {
    await SyncManager.instance.addAction(DeleteArticleAction(id));
    unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
  }

  @override
  Future<void> openArticleSheet(int id) =>
      dependencies.get<ArticleSheetBridge>().open(id);

  @override
  Future<void> saveLink(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host.isEmpty) {
      throw ArgumentError('Invalid URL: $url');
    }
    final action = SaveArticleAction(uri);
    await SyncManager.instance.addAction(action);
    unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
  }

  @override
  Future<void> onArticleSelected(int id) async {
    await _contentSubscription?.cancel();
    await _dataSubscription?.cancel();
    await _api.updateArticleContent(
      ArticleContent(id: id, html: null, readingProgress: 0.0),
    );
    unawaited(_startContentStream(id));
    _dataSubscription = _articleRepository
        .watchData(id)
        .where((a) => a != null)
        .map((a) => _rowDataFrom(a!))
        .listen((data) {
          unawaited(_api.updateArticleData(data));
        });
  }

  @override
  Future<void> onReadingProgressChanged(int articleId, double progress) =>
      _articleRepository.setReadingProgress(articleId, progress);

  void dispose() {
    _idsSubscription?.cancel();
    _querySubscription?.cancel();
    _contentSubscription?.cancel();
    _dataSubscription?.cancel();
    _settingsSubscription?.cancel();
    SyncManager.instance.removeListener(_onSyncState);
  }

  Future<void> _startContentStream(int id) async {
    final progress = await _articleRepository.watchReadingProgress(id).first;
    _contentSubscription = _articleRepository.watchContent(id).listen((html) {
      unawaited(
        _api.updateArticleContent(
          ArticleContent(id: id, html: html, readingProgress: progress ?? 0.0),
        ),
      );
    });
  }

  Future<void> _editArticle(int id, {bool? archived, bool? starred}) async {
    await SyncManager.instance.addAction(
      EditArticleAction(id, archived: archived, starred: starred),
    );
    unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
  }
}
