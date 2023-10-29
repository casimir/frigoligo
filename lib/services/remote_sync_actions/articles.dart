import 'base.dart';

class RefreshArticlesAction extends RemoteSyncAction {
  const RefreshArticlesAction() : super('refreshArticles');

  @override
  Future<void> execute(syncer) async {
    await syncer.wallabag!.incrementalRefresh(
      onProgress: (progress) => syncer.progressValue = progress,
    );
  }
}

class ClearArticlesAction extends RemoteSyncAction {
  const ClearArticlesAction() : super('clearArticles');

  @override
  Future<void> execute(syncer) async {
    await syncer.wallabag!.clearArticles();
  }
}
