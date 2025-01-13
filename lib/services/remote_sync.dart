import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../db/database.dart';
import '../db/extensions/remote_action.dart';
import '../wallabag/client.dart';
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

  Future<int> _fetchPendingCount() =>
      DB().managers.remoteActions.count(distinct: false);

  Future<void> add(RemoteSyncAction action) async {
    final db = DB();

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

  Future<Map<String, dynamic>> synchronize(
      {bool withFinalRefresh = false}) async {
    Map<String, dynamic> res = {};

    _log.info('starting remote synchronization');
    if (state.isWorking) {
      _log.info('sync already in progress, skipping...');
      return res;
    }
    state = SyncState(
      isWorking: true,
      progressValue: null,
      pendingCount: await _fetchPendingCount(),
    );

    try {
      final storage = ref.read(wStorageProvider.notifier);

      res.addAll(await _executeActions(storage));
      if (withFinalRefresh) {
        setProgress(null);
        _log.info('running action: $_refreshAction');
        await _refreshAction.execute(this, storage);
      }
      await storage.updateAppBadge();
    } on ServerError catch (e) {
      _log.severe('communication error', e);
      // Report error in the UI only if it's not a network issue. In that case
      // the sync will just stop and be tried again later.
      if (e.source is! ClientException) {
        _error = e;
      }
    } on Exception catch (e) {
      _log.severe('sync failed', e);
      _error = e;
    } finally {
      state = SyncState(
        isWorking: false,
        progressValue: null,
        lastError: _popLastError(),
        pendingCount: await _fetchPendingCount(),
      );
    }

    return res;
  }

  Future<Map<String, dynamic>> _executeActions(WStorage storage) async {
    final Map<String, dynamic> res = {};
    final db = DB();

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
        res[rsa.key] = await rsa.execute(this, storage);
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

    return res;
  }
}
