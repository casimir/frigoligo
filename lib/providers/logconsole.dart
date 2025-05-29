import 'dart:async';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../db/database.dart';

part 'logconsole.g.dart';

class LogConsoleToken {}

@riverpod
class LogConsole extends _$LogConsole {
  StreamSubscription? _watcher;
  int? _lastTableCount;

  @override
  LogConsoleToken build() {
    final t1 = DB().appLogs;

    _watcher?.cancel();
    _watcher = (t1.selectOnly()..addColumns([t1.id])).watch().listen((ids) {
      () async {
        // FIXME logs should be truncated without the need to open the console
        var count = ids.length;
        if (count > logCountThreshold) {
          final deletedCount = await DB().appLogsDao.truncate();
          count -= deletedCount;
        }

        if (_lastTableCount == count) return;

        _lastTableCount = count;
        ref.invalidateSelf();
      }();
    });
    ref.onDispose(() => _watcher?.cancel());
    return LogConsoleToken();
  }
}
