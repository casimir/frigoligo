import 'dart:async';

import '../domain/models/article_data.dart';
import '../domain/repositories.dart';
import '../domain/sync/sync_manager.dart';
import '../pigeon/article_sheet.g.dart';
import '../src/generated/i18n/app_localizations.dart';
import '../ui/article/controllers/article_sheet_controller.dart';

class ArticleSheetBridge implements ArticleSheetFlutterApi {
  ArticleSheetBridge({
    required ArticleRepository articleRepository,
    required TagRepository tagRepository,
    required SyncManager syncManager,
    ArticleSheetApi? api,
  }) : _articleRepository = articleRepository,
       _tagRepository = tagRepository,
       _syncManager = syncManager,
       _api = api ?? ArticleSheetApi() {
    ArticleSheetFlutterApi.setUp(this);
  }

  final ArticleRepository _articleRepository;
  final TagRepository _tagRepository;
  final SyncManager _syncManager;
  final ArticleSheetApi _api;

  StreamSubscription<ArticleData?>? _sub;
  ArticleSheetController? _controller;

  Future<void> open(int articleId, {required AppLocalizations l10n}) async {
    await _sub?.cancel();
    _sub = null;
    _controller = ArticleSheetController(
      syncManager: _syncManager,
      tagRepository: _tagRepository,
      articleId: articleId,
    );
    final labels = ArticleSheetLabels(
      addTags: l10n.article_addTags,
      openInBrowser: l10n.article_openInBrowser,
      readingTime: l10n.articlefields_readingTime,
      refetchContent: l10n.article_refetchContent,
      share: l10n.g_share,
      sheetTitle: l10n.g_article,
      tags: l10n.articlefields_tags,
      title: l10n.articlefields_title,
      website: l10n.articlefields_website,
    );
    _sub = _articleRepository.watchData(articleId).listen((article) {
      if (article == null) return;
      _api.update(
        ArticleSheetData(
          title: article.title,
          link: article.url,
          domain: Uri.tryParse(article.url)?.host,
          readingTime: l10n.article_readingTime(article.readingTime),
          tags: article.tags,
          labels: labels,
        ),
      );
    });
    await _api.open();
  }

  Future<void> dismiss() async {
    await _api.close();
    await onClose();
  }

  @override
  Future<void> onClose() async {
    await _sub?.cancel();
    _sub = null;
    _controller = null;
  }

  @override
  Future<List<String>> getAllTags() => _controller!.allTags();

  @override
  Future<void> refetchContent() => _controller!.refetchContent();

  @override
  Future<void> setTags(List<String> tags) => _controller!.setTags(tags);
}
