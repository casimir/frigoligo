import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../providers/settings.dart';
import '../wallabag/wallabag.dart';
import 'remote_sync_actions/articles.dart';
import 'remote_sync_actions/base.dart';
import 'wallabag_storage.dart';

final _log = Logger('remote.sync');

class RemoteSyncer with ChangeNotifier {
  static const _refreshAction = RefreshArticlesAction();

  SettingsProvider settings =
      SettingsProvider(namespace: kDebugMode ? 'debug' : null);

  WallabagStorage? _storage;
  WallabagStorage? get wallabag {
    if (_storage == null && WallabagInstance.isReady) {
      _storage = WallabagStorage(settings);
    }
    return _storage;
  }

  void invalidateWallabagInstance() => _storage = null;

  final Set<RemoteSyncAction> _queue = {};
  int get pendingCount => _queue.length;

  bool _isWorking = false;
  bool get isWorking => _isWorking;
  set isWorking(bool value) {
    if (value == _isWorking) return;
    _isWorking = value;
    notifyListeners();
  }

  double? _progressValue;
  double? get progressValue => _progressValue;
  set progressValue(double? value) {
    if (value == _progressValue) return;
    _progressValue = value;
    notifyListeners();
  }

  void _resetWorkingState() {
    isWorking = false;
    _progressValue = null;
    notifyListeners();
  }

  Exception? _error;
  Exception? get lastError {
    final error = _error;
    _error = null;
    return error;
  }

  void add(RemoteSyncAction action) {
    _queue.add(action);
  }

  Future<void> synchronize({bool withFinalRefresh = false}) async {
    _log.info('starting remote synchronization');
    if (wallabag == null) {
      _log.info('still in intialization mode, skipping...');
      return;
    }
    if (isWorking) {
      _log.info('sync already in progress, skipping...');
      return;
    }
    isWorking = true;

    try {
      await _executeActions();
      if (withFinalRefresh) {
        progressValue = null;
        _log.info('running action: $_refreshAction');
        await _refreshAction.execute(this);
      }
    } on Exception catch (e, st) {
      _log.severe('error while executing actions', e, st);
      _error = e;
    } finally {
      _resetWorkingState();
    }
  }

  Future<void> _executeActions() async {
    progressValue = null;
    int actionsCount = _queue.length;
    List<RemoteSyncAction> actions = _queue.toList();
    int i = 1;
    while (_queue.isNotEmpty) {
      for (final action in actions) {
        _log.info('running action: $action');
        await action.execute(this);
        _queue.remove(action);
        progressValue = i / actionsCount;
      }
      actionsCount += _queue.length;
      actions = _queue.toList();
    }
  }

  static final _instance = RemoteSyncer();
  static RemoteSyncer get instance => _instance;
}
