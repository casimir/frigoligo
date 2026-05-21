// coverage:ignore-file
import 'dart:async';

import '../domain/sync/sync_manager.dart';
import '../pigeon/sync.g.dart';

class SyncBridge {
  SyncBridge() {
    SyncManager.instance.addListener(_onSyncState);
  }

  final _api = SyncApi();
  SyncIndicatorStatus? _lastStatus;
  double? _lastProgressValue;

  void _onSyncState(SyncState state) {
    final status = switch (state) {
      _ when state.isWorking => SyncIndicatorStatus.syncing,
      _ when state.isNoInternet => SyncIndicatorStatus.noInternet,
      _ when state.isAuthFailure => SyncIndicatorStatus.authFailure,
      _ when state.lastError != null => SyncIndicatorStatus.syncError,
      _ => SyncIndicatorStatus.allGood,
    };
    if (status == _lastStatus && state.progressValue == _lastProgressValue) {
      return;
    }
    _lastStatus = status;
    _lastProgressValue = state.progressValue;
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
