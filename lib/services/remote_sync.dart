import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';

import '../models/db.dart';
import '../models/remote_action.dart';
import '../providers/settings.dart';
import '../server/client.dart';
import 'remote_sync_actions/articles.dart';
import 'remote_sync_actions/base.dart';
import 'wallabag_storage.dart';

final _log = Logger('remote.sync');

class RemoteSyncer with ChangeNotifier {
  static const _refreshAction = RefreshArticlesAction();

  final DBInstance db = DB.get();
  final SettingsValues settings =
      SettingsValues(namespace: kDebugMode ? 'debug' : null);

  WallabagStorage? _storage;
  WallabagStorage? get wallabag {
    if (_storage == null && ServerInstance.isReady) {
      _storage = WallabagStorage(settings);
    }
    return _storage;
  }

  void invalidateWallabagInstance() => _storage = null;

  int get pendingCount => db.remoteActions.countSync();

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
    final existing =
        db.remoteActions.filter().keyEqualTo(action.hashCode).findFirstSync();
    if (existing == null) {
      db.writeTxnSync(
          () => db.remoteActions.putSync(RemoteAction.fromRSA(action)));
    }
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

    int i = 1;
    int actionsCount = 0;
    do {
      final actions = db.remoteActions.where().sortByCreatedAt().findAllSync();
      actionsCount += actions.length;
      for (final action in actions) {
        final rsa = action.toRSA();
        _log.info('running action: $rsa');
        await rsa.execute(this);
        final deleted =
            await db.writeTxn(() => db.remoteActions.delete(action.id!));
        if (!deleted) {
          _log.severe('action not deleted after execution: $action');
        }
        progressValue = i / actionsCount;
        i++;
      }
      // new actions might be added while the current batch was processed
      actionsCount += pendingCount;
    } while (i < actionsCount);
  }

  static final _instance = RemoteSyncer();
  static RemoteSyncer get instance => _instance;
}

final remoteSyncerProvider =
    ChangeNotifierProvider((ref) => RemoteSyncer.instance);
final storageProvider =
    ChangeNotifierProvider((ref) => RemoteSyncer.instance.wallabag!);
