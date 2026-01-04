import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';

import '../../app_info.dart';
import '../../data/services/local/storage/config_store_service.dart';
import '../../data/services/local/storage/database/extensions/remote_action.dart';
import '../../data/services/local/storage/storage_service.dart';
import '../../data/services/platform/appbadge_service.dart';
import '../../providers/settings.dart';
import '../../server/clients.dart';
import '../client_factory.dart';
import '../repositories.dart';
import 'remote_actions.dart';

export 'remote_actions.dart';

final _log = Logger('sync.manager');

const _refreshAction = RefreshArticlesAction();

class SyncState {
  const SyncState({
    required this.isWorking,
    required this.progressValue,
    required this.lastError,
    required this.pendingCount,
  });

  final bool isWorking;
  final double? progressValue;
  final Exception? lastError;
  final int pendingCount;

  SyncState copyWith({
    bool? isWorking,
    double? progressValue,
    Exception? lastError,
    int? pendingCount,
  }) {
    return SyncState(
      isWorking: isWorking ?? this.isWorking,
      progressValue: progressValue ?? this.progressValue,
      lastError: lastError ?? this.lastError,
      pendingCount: pendingCount ?? this.pendingCount,
    );
  }
}

/// Domain service for sync queue management and action execution.
///
/// This service handles:
/// - Adding actions to the queue with deduplication
/// - Executing queued actions in order
/// - Managing the action execution lifecycle
///
/// Access the singleton instance via [SyncManager.instance].
class SyncManager {
  static late SyncManager _instance;
  static SyncManager get instance => _instance;

  static void init({
    required LocalStorageService storage,
    required ServerSessionRepository sessionRepo,
    required ConfigStoreService configStore,
    required AppBadgeService appBadge,
  }) {
    _instance = SyncManager(
      storage: storage,
      sessionRepo: sessionRepo,
      configStore: configStore,
      appBadge: appBadge,
    );
  }

  SyncManager({
    required LocalStorageService storage,
    required ServerSessionRepository sessionRepo,
    required ConfigStoreService configStore,
    required AppBadgeService appBadge,
  }) : _storage = storage,
       _sessionRepo = sessionRepo,
       _configStore = configStore,
       _appBadge = appBadge,
       _state = const SyncState(
         isWorking: false,
         progressValue: null,
         lastError: null,
         pendingCount: 0,
       );

  final LocalStorageService _storage;
  final ServerSessionRepository _sessionRepo;
  final ConfigStoreService _configStore;
  final AppBadgeService _appBadge;

  SyncState _state;
  SyncState get state => _state;

  final List<void Function(SyncState)> _listeners = [];

  void addListener(void Function(SyncState) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(SyncState) listener) {
    _listeners.remove(listener);
  }

  void _updateState(SyncState newState) {
    _state = newState;
    for (final listener in _listeners) {
      listener(newState);
    }
  }

  void _setProgress(double? value) {
    if (value != _state.progressValue) {
      _updateState(_state.copyWith(progressValue: value));
    }
  }

  Future<void> addAction(RemoteAction action) async {
    final exists = await _storage.db.managers.remoteActions
        .filter((f) => f.key.equals(action.hashCode))
        .exists();
    if (!exists) {
      await _storage.db.managers.remoteActions.create(
        (o) => o(
          key: action.hashCode,
          createdAt: DateTime.now(),
          className: action.type.name,
          jsonParams: jsonEncode(action.params),
        ),
      );
      _updateState(_state.copyWith(pendingCount: await getPendingCount()));
    }
  }

  Future<int> getPendingCount() {
    return _storage.db.managers.remoteActions.count(distinct: false);
  }

  Future<Map<String, dynamic>> executeAllPendingActions({
    required ProgressCallback onProgress,
  }) async {
    final Map<String, dynamic> res = {};
    final api = _sessionRepo.createClient(userAgent: AppInfo.userAgent);

    onProgress(null);
    int i = 1;
    int actionsCount = 0;

    do {
      final actions =
          await (_storage.db.managers.remoteActions
                ..orderBy((o) => o.createdAt.asc()))
              .get();
      actionsCount += actions.length;

      for (final action in actions) {
        final remoteAction = action.toRemoteAction();
        _log.info('running action: $remoteAction');
        res[remoteAction.key] = await remoteAction.execute(
          api,
          _storage,
          onProgress,
        );

        final deleted = await _storage.db.managers.remoteActions
            .filter((f) => f.id.equals(action.id))
            .delete();
        if (deleted == 0) {
          _log.severe('action not deleted after execution: $action');
        }

        onProgress(i / actionsCount);
        i++;
      }

      // new actions might be added while the current batch was processed
      actionsCount += await getPendingCount();
    } while (i < actionsCount);

    return res;
  }

  Future<Map<String, dynamic>> synchronize({
    required bool withFinalRefresh,
  }) async {
    Map<String, dynamic> res = {};

    _log.info('starting remote synchronization');
    if (_state.isWorking) {
      _log.info('sync already in progress, skipping...');
      return res;
    }

    _updateState(
      SyncState(
        isWorking: true,
        progressValue: null,
        lastError: null,
        pendingCount: await getPendingCount(),
      ),
    );

    Exception? error;

    try {
      res.addAll(await executeAllPendingActions(onProgress: _setProgress));

      if (withFinalRefresh) {
        _setProgress(null);
        _log.info('running action: $_refreshAction');
        final api = _sessionRepo.createClient(userAgent: AppInfo.userAgent);
        await _refreshAction.execute(api, _storage, _setProgress);
      }

      await _updateAppBadge();
    } on ServerError catch (e) {
      _log.severe('communication error', e);
      if (e.source is! ClientException) {
        error = e;
      }
    } on Exception catch (e) {
      _log.severe('sync failed', e);
      error = e;
    } finally {
      _updateState(
        SyncState(
          isWorking: false,
          progressValue: null,
          lastError: error,
          pendingCount: await getPendingCount(),
        ),
      );
    }

    return res;
  }

  Future<void> _updateAppBadge() async {
    final badgeEnabled = _configStore.get<bool>(Sk.appBadge.key) ?? false;
    if (!AppBadgeService.isSupportedSync || !badgeEnabled) return;

    final unread = await _storage.countUnread();
    await _appBadge.update(unread);
    _log.fine('updated app badge: $unread unread');
  }
}
