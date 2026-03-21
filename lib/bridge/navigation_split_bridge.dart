import 'dart:async';

import '../config/dependencies.dart';
import '../domain/models/query.dart';
import '../domain/sync/sync_manager.dart';
import '../pigeon/bridges.g.dart';
import 'article_sheet_bridge.dart';

class NavigationSplitBridge implements NavigationSplitFlutterApi {
  NavigationSplitBridge({
    required ArticleRepository articleRepository,
    required QueryRepository queryRepository,
  }) : _articleRepository = articleRepository,
       _queryRepository = queryRepository {
    NavigationSplitFlutterApi.setUp(this);
    _idsSubscription = queryRepository.watchArticleIds().listen((ids) {
      unawaited(_api.updateArticleIds(ids));
    });
    _querySubscription = queryRepository.queryStream.listen((q) {
      unawaited(_api.updateFilterState(_filterStateFrom(q)));
    });
    SyncManager.instance.addListener(_onSyncState);
  }

  final ArticleRepository _articleRepository;
  final QueryRepository _queryRepository;
  final NavigationSplitApi _api = NavigationSplitApi();

  StreamSubscription<List<int>>? _idsSubscription;
  StreamSubscription<Query>? _querySubscription;
  StreamSubscription<String?>? _contentSubscription;
  StreamSubscription<ArticleRowData?>? _dataSubscription;

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

  static NavigationFilterState _filterStateFrom(Query q) {
    return NavigationFilterState(
      text: q.text,
      textMode: q.textMode.index,
      stateFilter: q.state.index,
      onlyStarred: q.onlyStarred,
      tags: q.tags,
      domains: q.domains,
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
  void setSearchText(String text) {
    _queryRepository.query = _queryRepository.query.copyWith(text: text);
  }

  @override
  void setTextMode(int mode) {
    _queryRepository.query = _queryRepository.query.copyWith(
      textMode: SearchTextMode.values[mode],
    );
  }

  @override
  void setStateFilter(int state) {
    _queryRepository.query = _queryRepository.query.copyWith(
      state: StateFilter.values[state],
    );
  }

  @override
  void setOnlyStarred(bool onlyStarred) {
    _queryRepository.query = _queryRepository.query.copyWith(
      onlyStarred: onlyStarred,
    );
  }

  @override
  void setTags(List<String> tags) {
    _queryRepository.query = _queryRepository.query.copyWith(tags: tags);
  }

  @override
  void setDomains(List<String> domains) {
    _queryRepository.query = _queryRepository.query.copyWith(domains: domains);
  }

  @override
  void refresh() {
    unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
  }

  @override
  void setArticleArchived(int id, bool archived) {
    unawaited(_editArticle(id, archived: archived));
  }

  @override
  void setArticleStarred(int id, bool starred) {
    unawaited(_editArticle(id, starred: starred));
  }

  @override
  void filterByTag(String tag) {
    _queryRepository.query = _queryRepository.query.copyWith(tags: [tag]);
  }

  @override
  void onArticleSelected(int id) {
    _contentSubscription?.cancel();
    _dataSubscription?.cancel();
    unawaited(
      _api.updateArticleContent(
        ArticleContent(id: id, html: null, readingProgress: 0.0),
      ),
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

  @override
  void onReadingProgressChanged(int articleId, double progress) {
    unawaited(_articleRepository.setReadingProgress(articleId, progress));
  }

  @override
  void deleteArticle(int id) {
    unawaited(_doDeleteArticle(id));
  }

  @override
  void openArticleSheet(int id) {
    unawaited(dependencies.get<ArticleSheetBridge>().open(id));
  }

  void dispose() {
    _idsSubscription?.cancel();
    _querySubscription?.cancel();
    _contentSubscription?.cancel();
    _dataSubscription?.cancel();
    SyncManager.instance.removeListener(_onSyncState);
  }

  Future<void> _editArticle(int id, {bool? archived, bool? starred}) async {
    await SyncManager.instance.addAction(
      EditArticleAction(id, archived: archived, starred: starred),
    );
    unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
  }

  Future<void> _doDeleteArticle(int id) async {
    await SyncManager.instance.addAction(DeleteArticleAction(id));
    unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
  }
}
