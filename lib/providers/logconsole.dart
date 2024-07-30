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

  @override
  LogConsoleToken build() {
    final db = DB.get();
    _watcher?.cancel();
    _watcher = db.appLogs.select().watch().listen((_) => ref.invalidateSelf());
    ref.onDispose(() => _watcher?.cancel());
    return LogConsoleToken();
  }

  Future<int> getCount() => DB.get().managers.appLogs.count();
  Future<AppLog?> index(int n) async {
    final db = DB.get();
    final t1 = db.appLogs;
    final ids = await (t1.selectOnly()
          ..addColumns([t1.id])
          ..orderBy([OrderingTerm.desc(t1.time)]))
        .get() as List<int>;
    return (t1.select()..where((e) => e.id.equals(ids[n]))).getSingleOrNull();
  }

  Future<int> clear() => DB.get().appLogs.deleteAll();

  Future<int?> truncate() async {
    final db = DB.get();
    // FIXME this is way to brutal and clunky at the same time
    if (await getCount() > logCountResetThreshold) {
      return db.appLogs.deleteAll();
    }
    return null;
  }

  Future<String> exportCurrentRun() async {
    final db = DB.get();

    final firstRecord = await (db.appLogs.select()
          ..where((e) => e.message.equals('starting app'))
          ..orderBy([
            (e) => OrderingTerm(expression: e.time, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .getSingleOrNull();
    if (firstRecord == null) return '';

    final t1 = db.appLogs;
    final lines = await (db.appLogs.selectOnly()
          ..addColumns([t1.logline])
          ..where(t1.time.isBiggerOrEqualValue(firstRecord.time))
          ..orderBy([
            OrderingTerm(expression: t1.time, mode: OrderingMode.asc),
          ]))
        .get();
    return lines.join('\n');
  }

  Future<String> exportCurrentRunToFile() async {
    final tempDir = await getTemporaryDirectory();
    final filename = '${tempDir.path}/frigoligo.log';

    final file = await File(filename).create();
    final data = utf8.encode(await exportCurrentRun());
    file.writeAsBytesSync(data);

    return filename;
  }
}
