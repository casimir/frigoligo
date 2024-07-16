import '../remote_sync.dart';
import '../wallabag_storage.dart';
import 'articles.dart';

typedef ActionParams = Map<String, dynamic>;

abstract class RemoteSyncAction {
  const RemoteSyncAction(String key) : _key = key;

  final String _key;

  @override
  bool operator ==(Object other) =>
      other is RemoteSyncAction && _key == other._key;

  @override
  int get hashCode => _key.hashCode;

  ActionParams params();

  factory RemoteSyncAction.fromParams(String className, ActionParams params) {
    if (!actionBuilderRegistry.containsKey(className)) {
      throw Exception('unknown RemoteSyncAction: $className');
    }
    return actionBuilderRegistry[className]!(params);
  }

  Future<void> execute(RemoteSyncer syncer, WStorage storage);

  @override
  String toString() {
    return '$runtimeType[$_key]';
  }
}

// TODO could not find a way to do it in dart without importing the other file
// TODO look into freezed union types
Map<String, RemoteSyncAction Function(ActionParams)> actionBuilderRegistry = {
  'RefreshArticlesAction': RefreshArticlesAction.fromParams,
  'DeleteArticleAction': DeleteArticleAction.fromParams,
  'EditArticleAction': EditArticleAction.fromParams,
};
