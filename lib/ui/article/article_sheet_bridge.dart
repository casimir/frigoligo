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
    required SyncManager syncManager,
  }) : _articleRepository = articleRepository,
       _tagRepository = tagRepository,
       _syncManager = syncManager {
    ArticleSheetFlutterApi.setUp(this);
  }

  final ArticleRepository _articleRepository;
  final TagRepository _tagRepository;
  final SyncManager _syncManager;
  AppLocalizations? _l10n;

  final _api = ArticleSheetApi();
  StreamSubscription<ArticleData?>? _sub;
  int? _articleId;

  Future<void> open(int articleId, {required AppLocalizations l10n}) async {
    _l10n = l10n;
    unawaited(_sub?.cancel());
    _articleId = articleId;
    _sub = _articleRepository.watchData(articleId).listen((article) {
      if (article == null) return;
      final l10n = _l10n!;
      _api.update(
        ArticleSheetData(
          title: article.title,
          link: article.url,
          domain: Uri.tryParse(article.url)?.host,
          readingTime: l10n.article_readingTime(article.readingTime),
          tags: article.tags,
          labels: ArticleSheetLabels(
            addTags: l10n.article_addTags,
            openInBrowser: l10n.article_openInBrowser,
            readingTime: l10n.articlefields_readingTime,
            refetchContent: l10n.article_refetchContent,
            share: l10n.g_share,
            sheetTitle: l10n.g_article,
            tags: l10n.articlefields_tags,
            title: l10n.articlefields_title,
            website: l10n.articlefields_website,
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
