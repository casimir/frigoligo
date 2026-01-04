import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/article_data.dart';
import '../../domain/sync/sync_manager.dart';
import '../repository_providers.dart';

export '../../domain/sync/sync_manager.dart' show SyncState;
export '../../server/clients.dart' show ServerError;

part '_g/states.g.dart';

@riverpod
class ArticleState extends _$ArticleState {
  @override
  Future<ArticleData?> build(int articleId) async {
    final articleRepository = ref.watch(articleRepositoryProvider);
    final dataStream = articleRepository.watchData(articleId);

    final subscription = dataStream.listen((data) {
      state = AsyncValue.data(data);
    });
    ref.onDispose(() => subscription.cancel());

    return dataStream.first;
  }
}

@riverpod
Future<bool> articleExistsState(Ref ref, int articleId) {
  return ref.watch(
    articleStateProvider(articleId).selectAsync((data) => data != null),
  );
}

/// Riverpod provider that exposes SyncManager state for UI consumption.
///
/// This provider listens to SyncManager state changes and rebuilds widgets.
/// All business logic is in SyncManager - this is purely for UI reactivity.
@riverpod
class SyncManagerState extends _$SyncManagerState {
  @override
  SyncState build() {
    void listener(SyncState newState) {
      state = newState;
    }

    SyncManager.instance.addListener(listener);
    ref.onDispose(() => SyncManager.instance.removeListener(listener));

    return SyncManager.instance.state;
  }
}
