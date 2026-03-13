import 'dart:async';

import '../../domain/models/article_data.dart';
import '../../domain/repositories.dart';
import '../../domain/sync/sync_manager.dart';
import '../../pigeon/article_sheet.g.dart';
import '../../src/generated/i18n/app_localizations.dart';

class ArticleSheetBridge implements ArticleSheetFlutterApi {
  ArticleSheetBridge({
    required ArticleRepository articleRepository,
    required TagRepository tagRepository,
    required AppLocalizations l10n,
    required SyncManager syncManager,
  }) : _articleRepository = articleRepository,
       _tagRepository = tagRepository,
       _l10n = l10n,
       _syncManager = syncManager {
    ArticleSheetFlutterApi.setUp(this);
  }

  final ArticleRepository _articleRepository;
  final TagRepository _tagRepository;
  final AppLocalizations _l10n;
  final SyncManager _syncManager;

  final _api = ArticleSheetApi();
  StreamSubscription<ArticleData?>? _sub;
  int? _articleId;

  Future<void> open(int articleId) async {
    unawaited(_sub?.cancel());
    _articleId = articleId;
    _sub = _articleRepository.watchData(articleId).listen((article) {
      if (article == null) return;
      _api.update(
        ArticleSheetData(
          title: article.title,
          link: article.url,
          domain: Uri.tryParse(article.url ?? '')?.host,
          readingTime: _l10n.article_readingTime(article.readingTime),
          tags: article.tags,
          labels: ArticleSheetLabels(
            addTags: _l10n.article_addTags,
            openInBrowser: _l10n.article_openInBrowser,
            readingTime: _l10n.articlefields_readingTime,
            refetchContent: _l10n.article_refetchContent,
            share: _l10n.g_share,
            sheetTitle: _l10n.g_article,
            tags: _l10n.articlefields_tags,
            title: _l10n.articlefields_title,
            website: _l10n.articlefields_website,
          ),
        ),
      );
    });
    await _api.open();
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    _sub = null;
    _articleId = null;
  }

  @override
  Future<List<String>> getAllTags() => _tagRepository.getAll();

  @override
  Future<void> refetchContent() async {
    if (_articleId == null) return;
    await _syncManager.addAction(RefetchArticleAction(_articleId!));
    await _syncManager.synchronize(withFinalRefresh: false);
  }

  @override
  Future<void> setTags(List<String> tags) async {
    if (_articleId == null) return;
    await _syncManager.addAction(EditArticleAction(_articleId!, tags: tags));
    await _syncManager.synchronize(withFinalRefresh: false);
  }
}
