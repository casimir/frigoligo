import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../db/database.dart';
import '../db/extensions/remote_action.dart';
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
    required int pendingCount,
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
      pendingCount: 0,
    );
  }

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

  Future<int> _fetchPendingCount() => DB.get().managers.remoteActions.count();

  Future<void> add(RemoteSyncAction action) async {
    final db = DB.get();

    final exists = await db.managers.remoteActions
        .filter((f) => f.key.equals(action.hashCode))
        .exists();
    if (!exists) {
      await db.managers.remoteActions.create((o) => o(
            key: action.hashCode,
            createdAt: DateTime.now(),
            className: action.runtimeType.toString(),
            jsonParams: jsonEncode(action.params()),
          ));
    }
  }

  Future<void> synchronize({bool withFinalRefresh = false}) async {
    _log.info('starting remote synchronization');
    if (state.isWorking) {
      _log.info('sync already in progress, skipping...');
      return;
    }
    state = SyncState(
      isWorking: true,
      progressValue: null,
      pendingCount: await _fetchPendingCount(),
    );

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
        pendingCount: await _fetchPendingCount(),
      );
    }
  }

  Future<void> _executeActions() async {
    final db = DB.get();

    setProgress(null);
    int i = 1;
    int actionsCount = 0;
    do {
      final actions = await (db.managers.remoteActions
            ..orderBy((o) => o.createdAt.asc()))
          .get();
      actionsCount += actions.length;
      for (final action in actions) {
        final rsa = action.toRSA();
        _log.info('running action: $rsa');
        await rsa.execute(this, ref.read(wStorageProvider.notifier));
        final deleted = await db.managers.remoteActions
            .filter((f) => f.id.equals(action.id))
            .delete();
        if (deleted == 0) {
          _log.severe('action not deleted after execution: $action');
        }
        state = state.copyWith(
          progressValue: i / actionsCount,
          pendingCount: state.pendingCount - 1,
        );
        i++;
      }
      // new actions might be added while the current batch was processed
      actionsCount += await _fetchPendingCount();
    } while (i < actionsCount);
  }
}
