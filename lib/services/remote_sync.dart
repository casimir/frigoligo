import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'remote_sync_actions/articles.dart';
import 'remote_sync_actions/base.dart';
import 'wallabag_storage.dart';

final _log = Logger('remote.sync');

class RemoteSync with ChangeNotifier {
  static const _refreshAction = RefreshArticlesAction();

// FIXME it should come from the contructor or as a singleton
  WallabagStorage? wallabag;

  final Set<RemoteSyncAction> _queue = {};
  int get pendingCount => _queue.length;

  bool isWorking = false;

  double? _progressValue;
  double? get progressValue => _progressValue;
  set progressValue(double? value) {
    if (value == _progressValue) return;
    _progressValue = value;
    notifyListeners();
  }

  bool _withFinalRefresh = false;

  void _resetWorkingState() {
    isWorking = false;
    _progressValue = null;
    _withFinalRefresh = false;
    notifyListeners();
  }

  Exception? _error;
  Exception? get lastError {
    final error = _error;
    _error = null;
    return error;
  }

  // TODO keep withFinalRefresh?
  RemoteSync add(RemoteSyncAction action, {bool withFinalRefresh = false}) {
    _queue.add(action);
    _withFinalRefresh |= withFinalRefresh;
    return this;
  }

  Future<void> synchronize({bool withFinalRefresh = false}) async {
    _log.info('starting remote synchronization');
    if (isWorking) {
      _log.info('sync already in progress, skipping...');
      return;
    }
    isWorking = true;

    try {
      await _executeActions();
      if (_withFinalRefresh || withFinalRefresh) {
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
    int i = 0;
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

  static final _instance = RemoteSync();
  static RemoteSync get instance => _instance;
}
