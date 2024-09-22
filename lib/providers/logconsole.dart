import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
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
    final db = DB.get();
    final t1 = db.appLogs;

    _watcher?.cancel();
    _watcher = (t1.selectOnly()..addColumns([t1.id])).watch().listen((ids) {
      () async {
        // FIXME logs should be truncated without then need to open the console
        var count = ids.length;
        if (count > logCountThreshold) {
          final deletedCount = await db.appLogsDao.truncate();
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

  Future<String> exportCurrentRunToFile() async {
    final tempDir = await getTemporaryDirectory();
    final filename = '${tempDir.path}/frigoligo.log';

    final lines = await DB.get().appLogsDao.currentRunLoglines();
    final data = utf8.encode(lines.join('\n'));
    final file = await File(filename).create();
    file.writeAsBytesSync(data);

    return filename;
  }
}
