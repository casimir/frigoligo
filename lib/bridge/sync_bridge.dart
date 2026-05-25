// coverage:ignore-file
import 'dart:async';

import '../domain/sync/sync_manager.dart';
import '../pigeon/sync.g.dart';

class SyncBridge {
  SyncBridge() {
    SyncManager.instance.addListener(_onSyncState);
  }

  final _api = SyncApi();

  void _onSyncState(SyncState state) {
    final status = switch (state) {
      _ when state.isWorking => SyncIndicatorStatus.syncing,
      _ when state.isNoInternet => SyncIndicatorStatus.noInternet,
      _ when state.isServerUnreachable => SyncIndicatorStatus.serverUnreachable,
      _ when state.isAuthFailure => SyncIndicatorStatus.authFailure,
      _ when state.lastError != null => SyncIndicatorStatus.syncError,
      _ => SyncIndicatorStatus.allGood,
    };
    unawaited(
      _api.updateSyncState(
        SyncIndicatorState(
          status: status,
          progressValue: state.progressValue,
          pendingCount: state.pendingCount,
          lastSyncTimestamp: state.lastSyncTimestamp,
          errorDetail: state.lastError?.toString(),
        ),
      ),
    );
  }

  void dispose() => SyncManager.instance.removeListener(_onSyncState);
}
