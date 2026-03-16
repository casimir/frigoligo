import 'dart:async';

import '../domain/models/article_data.dart';
import '../domain/repositories.dart';
import '../domain/sync/sync_manager.dart';
import '../pigeon/bridges.g.dart';
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

  Future<void> open(int articleId) async {
    await _sub?.cancel();
    _sub = null;
    _controller = ArticleSheetController(
      syncManager: _syncManager,
      tagRepository: _tagRepository,
      articleId: articleId,
    );
    _sub = _articleRepository.watchData(articleId).listen((article) {
      if (article == null) return;
      _api.update(
        ArticleSheetData(
          title: article.title,
          link: article.url,
          domain: Uri.tryParse(article.url)?.host,
          readingTime: article.readingTime,
          tags: article.tags,
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
