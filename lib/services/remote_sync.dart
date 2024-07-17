import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/db.dart';
import '../models/remote_action.dart';
import 'remote_sync_actions/articles.dart';
import 'remote_sync_actions/base.dart';
import 'wallabag_storage.dart';

part 'remote_sync.freezed.dart';
part 'remote_sync.g.dart';

final _log = Logger('remote.sync');

@freezed
class SyncState with _$SyncState {
  const factory SyncState({
    required bool isWorking,
    required double? progressValue,
    @Default(null) Exception? lastError,
  }) = _SyncState;
}

@riverpod
class RemoteSyncer extends _$RemoteSyncer {
  static const _refreshAction = RefreshArticlesAction();

  @override
  SyncState build() {
    return SyncState(
      isWorking: false,
      progressValue: null,
      lastError: _popLastError(),
    );
  }

  int getPendingCount() => DB.get().remoteActions.countSync();

  bool setProgress(double? value) {
    if (value == state.progressValue) return false;
    state = state.copyWith(progressValue: value);
    return true;
  }

  Exception? _error;
  Exception? _popLastError() {
    final error = _error;
    _error = null;
    return error;
  }

  void add(RemoteSyncAction action) {
    final db = DB.get();

    final existing =
        db.remoteActions.filter().keyEqualTo(action.hashCode).findFirstSync();
    if (existing == null) {
      db.writeTxnSync(
          () => db.remoteActions.putSync(RemoteAction.fromRSA(action)));
    }
  }

  Future<void> synchronize({bool withFinalRefresh = false}) async {
    _log.info('starting remote synchronization');
    if (state.isWorking) {
      _log.info('sync already in progress, skipping...');
      return;
    }
    state = const SyncState(isWorking: true, progressValue: null);

    try {
      await _executeActions();
      if (withFinalRefresh) {
        setProgress(null);
        _log.info('running action: $_refreshAction');
        await _refreshAction.execute(this, ref.read(wStorageProvider.notifier));
      }
    } on Exception catch (e) {
      _log.severe('error while executing actions', e);
      _error = e;
    } finally {
      state = SyncState(
        isWorking: false,
        progressValue: null,
        lastError: _popLastError(),
      );
    }
  }

  Future<void> _executeActions() async {
    final db = DB.get();

    setProgress(null);
    int i = 1;
    int actionsCount = 0;
    do {
      final actions = db.remoteActions.where().sortByCreatedAt().findAllSync();
      actionsCount += actions.length;
      for (final action in actions) {
        final rsa = action.toRSA();
        _log.info('running action: $rsa');
        await rsa.execute(this, ref.read(wStorageProvider.notifier));
        final deleted =
            await db.writeTxn(() => db.remoteActions.delete(action.id!));
        if (!deleted) {
          _log.severe('action not deleted after execution: $action');
        }
        state = state.copyWith(progressValue: i / actionsCount);
        i++;
      }
      // new actions might be added while the current batch was processed
      actionsCount += getPendingCount();
    } while (i < actionsCount);
  }
}
