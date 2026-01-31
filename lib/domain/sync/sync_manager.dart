import 'package:http/http.dart';
import 'package:logging/logging.dart';

import '../../app_info.dart';
import '../../data/services/local/storage/config_store_service.dart';
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
const autoSyncThrottleSeconds = 15 * 60;

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
    required AppBadgeService appBadgeService,
    required ConfigStoreService configStoreService,
    required LocalStorageService localStorageService,
    required ArticleRepository articleRepository,
    required RemoteActionRepository remoteActionRepository,
    required ServerSessionRepository serverSessionRepository,
  }) {
    _instance = SyncManager(
      appBadgeService: appBadgeService,
      configStoreService: configStoreService,
      localStorageService: localStorageService,
      articleRepository: articleRepository,
      remoteActionRepository: remoteActionRepository,
      serverSessionRepository: serverSessionRepository,
    );
  }

  SyncManager({
    required AppBadgeService appBadgeService,
    required ConfigStoreService configStoreService,
    required LocalStorageService localStorageService,
    required ArticleRepository articleRepository,
    required RemoteActionRepository remoteActionRepository,
    required ServerSessionRepository serverSessionRepository,
  }) : _appBadgeService = appBadgeService,
       _configStoreService = configStoreService,
       _localStorageService = localStorageService,
       _articleRepository = articleRepository,
       _remoteActionRepository = remoteActionRepository,
       _serverSessionRepository = serverSessionRepository,
       _state = const SyncState(
         isWorking: false,
         progressValue: null,
         lastError: null,
         pendingCount: 0,
       );

  final AppBadgeService _appBadgeService;
  final ConfigStoreService _configStoreService;
  final LocalStorageService _localStorageService;
  final ArticleRepository _articleRepository;
  final RemoteActionRepository _remoteActionRepository;
  final ServerSessionRepository _serverSessionRepository;

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
    final exists = await _remoteActionRepository.exists(action);
    if (!exists) {
      final session = _serverSessionRepository.getSession();
      final context = ActionContext(
        localStorageService: _localStorageService,
        articleRepository: _articleRepository,
        isLocalSession: session?.type == ServerType.local,
      );
      await action.onAdd(context);
      await _remoteActionRepository.create(action);
      _updateState(_state.copyWith(pendingCount: await getPendingCount()));
    }
  }

  Future<int> getPendingCount() {
    return _remoteActionRepository.count();
  }

  Future<Map<String, dynamic>> executeAllPendingActions({
    required ProgressCallback onProgress,
  }) async {
    final Map<String, dynamic> res = {};
    final api = _serverSessionRepository.createClient(
      userAgent: AppInfo.userAgent,
    );

    onProgress(null);
    int i = 1;
    int actionsCount = 0;

    do {
      final actions = await _remoteActionRepository.getAllOrderedByCreation();
      actionsCount += actions.length;

      for (final action in actions) {
        _log.info('running action: $action');
        res[action.key] = await action.execute(
          api,
          _localStorageService,
          onProgress,
        );

        final deleted = await _remoteActionRepository.delete(action);
        if (!deleted) {
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

    if (_serverSessionRepository.getSession() == null) {
      _log.info('no active session, skipping sync');
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
        final api = _serverSessionRepository.createClient(
          userAgent: AppInfo.userAgent,
        );
        await _refreshAction.execute(api, _localStorageService, _setProgress);
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
    } catch (e, st) {
      // Backgroud sync needs to be bulletproof, try too catch ANYTHING else
      _log.severe('sync failed (badly)', e, st);
      error = Exception(e.toString());
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

  Future<Map<String, dynamic>> throttledSynchronize({
    required bool withFinalRefresh,
  }) async {
    final int? lastSync = await _localStorageService.metadata.getLastSyncTS();
    if (lastSync != null) {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final elapsed = now - lastSync;
      if (elapsed < autoSyncThrottleSeconds) {
        _log.info(
          'sync throttled (${elapsed}s < ${autoSyncThrottleSeconds}s since last sync)',
        );
        return {};
      }
    }
    return synchronize(withFinalRefresh: withFinalRefresh);
  }

  Future<void> _updateAppBadge() async {
    final badgeSupported = await _appBadgeService.isSupported();
    if (!badgeSupported) return;

    final badgeEnabled =
        _configStoreService.get<bool>(Sk.appBadge.key) ?? false;
    if (!badgeEnabled) return;

    final unread = await _localStorageService.articles.countUnread();
    await _appBadgeService.update(unread);
    _log.fine('updated app badge: $unread unread');
  }
}
