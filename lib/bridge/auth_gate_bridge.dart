// coverage:ignore-file
import '../domain/repositories.dart';
import '../domain/sync/sync_manager.dart';
import '../pigeon/auth_gate.g.dart';
import '../server/clients.dart';

class AuthGateBridge {
  static final _api = AuthGateApi();

  AuthGateBridge({required ServerSessionRepository serverSessionRepository}) {
    if (serverSessionRepository.getSession() == null) {
      _api.requireLogin();
    }
    SyncManager.instance.addListener(_onSyncState);
  }

  Exception? _lastSyncError;

  void _onSyncState(SyncState state) {
    final error = state.lastError;
    if (error != null &&
        error != _lastSyncError &&
        error is ServerError &&
        error.isInvalidTokenError) {
      _api.reauthRequired();
    }
    _lastSyncError = error;
  }

  void dispose() => SyncManager.instance.removeListener(_onSyncState);

  static void notifyLoginComplete() => _api.loginDidComplete();
}
