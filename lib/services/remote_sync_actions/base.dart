import '../remote_sync.dart';

abstract class RemoteSyncAction {
  const RemoteSyncAction(String key) : _key = key;

  final String _key;

  @override
  bool operator ==(Object other) =>
      other is RemoteSyncAction && _key == other._key;

  @override
  int get hashCode => _key.hashCode;

  Future<void> execute(RemoteSync syncer);

  @override
  String toString() {
    return '$runtimeType[$_key]';
  }
}
