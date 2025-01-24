import '../remote_sync.dart';
import '../wallabag_storage.dart';
import 'articles.dart';

typedef ActionParams = Map<String, dynamic>;
typedef ExecuteCallback = void Function(dynamic);

abstract class RemoteSyncAction {
  const RemoteSyncAction(this.key);

  final String key;

  @override
  bool operator ==(Object other) =>
      other is RemoteSyncAction && key == other.key;

  @override
  int get hashCode => key.hashCode;

  ActionParams params();

  factory RemoteSyncAction.fromParams(String className, ActionParams params) {
    if (!actionBuilderRegistry.containsKey(className)) {
      throw Exception('unknown RemoteSyncAction: $className');
    }
    return actionBuilderRegistry[className]!(params);
  }

  Future<dynamic> execute(RemoteSyncer syncer, WStorage storage);

  @override
  String toString() {
    return '$runtimeType[$key]';
  }
}

// TODO could not find a way to do it in dart without importing the other file
// TODO look into freezed union types
Map<String, RemoteSyncAction Function(ActionParams)> actionBuilderRegistry = {
  'RefreshArticlesAction': RefreshArticlesAction.fromParams,
  'DeleteArticleAction': DeleteArticleAction.fromParams,
  'EditArticleAction': EditArticleAction.fromParams,
  'SaveArticleAction': SaveArticleAction.fromParams,
};
