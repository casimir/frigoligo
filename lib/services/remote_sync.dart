import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app_info.dart';
import '../config/dependencies.dart';
import '../data/services/local/storage/config_store_service.dart';
import '../data/services/local/storage/database/extensions/remote_action.dart';
import '../data/services/local/storage/storage_service.dart';
import '../data/services/platform/appbadge_service.dart';
import '../domain/client_factory.dart';
import '../providers/settings.dart';
import '../server/clients.dart';
import 'remote_sync_actions.dart';

export '../server/clients.dart' show ServerError;

part '_g/remote_sync.freezed.dart';
part '_g/remote_sync.g.dart';

final _log = Logger('remote.sync');

@freezed
sealed class SyncState with _$SyncState {
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

  Future<int> _fetchPendingCount() {
    final LocalStorageService storageService = dependencies.get();
    return storageService.db.managers.remoteActions.count(distinct: false);
  }

  Future<void> add(RemoteSyncAction action) async {
    final LocalStorageService storageService = dependencies.get();
    final db = storageService.db;

    final exists = await db.managers.remoteActions
        .filter((f) => f.key.equals(action.hashCode))
        .exists();
    if (!exists) {
      await db.managers.remoteActions.create(
        (o) => o(
          key: action.hashCode,
          createdAt: DateTime.now(),
          className: action.type.name,
          jsonParams: jsonEncode(action.params),
        ),
      );
    }
  }

  Future<Map<String, dynamic>> synchronize({
    bool withFinalRefresh = false,
  }) async {
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
      res.addAll(await _executeActions());
      if (withFinalRefresh) {
        setProgress(null);
        _log.info('running action: $_refreshAction');
        final sessionRepo = dependencies.get<ServerSessionRepository>();
        final storage = dependencies.get<LocalStorageService>();
        final api = sessionRepo.createClient(userAgent: AppInfo.userAgent);
        await _refreshAction.execute(api, storage, setProgress);
      }

      // Systematic badge update after all actions complete
      await _updateAppBadge();
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

  Future<Map<String, dynamic>> _executeActions() async {
    final storage = dependencies.get<LocalStorageService>();
    final sessionRepo = dependencies.get<ServerSessionRepository>();

    final Map<String, dynamic> res = {};
    final db = storage.db;

    // Create API client once for all actions
    final api = sessionRepo.createClient(userAgent: AppInfo.userAgent);

    setProgress(null);
    int i = 1;
    int actionsCount = 0;
    do {
      final actions =
          await (db.managers.remoteActions..orderBy((o) => o.createdAt.asc()))
              .get();
      actionsCount += actions.length;
      for (final action in actions) {
        final rsa = action.toRSA();
        _log.info('running action: $rsa');
        res[rsa.key] = await rsa.execute(api, storage, setProgress);
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

  Future<void> _updateAppBadge() async {
    final configStore = dependencies.get<ConfigStoreService>();
    final storage = dependencies.get<LocalStorageService>();
    final appBadge = dependencies.get<AppBadgeService>();

    final badgeEnabled = configStore.get<bool>(Sk.appBadge.key) ?? false;
    if (!AppBadgeService.isSupportedSync || !badgeEnabled) return;

    final unread = await storage.countUnread();
    await appBadge.update(unread);
    _log.fine('updated app badge: $unread unread');
  }
}
