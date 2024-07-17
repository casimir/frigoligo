import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_log.dart';
import '../models/db.dart';

part 'logconsole.g.dart';

@riverpod
class LogConsole extends _$LogConsole {
  StreamSubscription? _watcher;

  @override
  void build() {
    _watcher?.cancel();
    _watcher = DB.get().appLogs.watchLazy().listen((_) => ref.invalidateSelf());
    ref.onDispose(() => _watcher?.cancel());
  }

  int getCount() => DB.get().appLogs.countSync();
  AppLog? index(int n) {
    final db = DB.get();
    final ids =
        db.appLogs.where().sortByTimeDesc().isarIdProperty().findAllSync();
    return db.appLogs.getSync(ids[n])!;
  }

  void clear() {
    final db = DB.get();
    db.writeTxnSync(() => db.appLogs.clearSync());
  }

  String exportCurrentRun() {
    final db = DB.get();

    final firstRecord = db.appLogs
        .filter()
        .messageEqualTo('starting app')
        .sortByTimeDesc()
        .findFirstSync();
    if (firstRecord == null) return '';

    final records = db.appLogs
        .filter()
        .timeGreaterThan(firstRecord.time)
        .sortByTime()
        .findAllSync();
    final lines = records.map((r) => r.logline).toList();
    return lines.join('\n');
  }

  Future<String> exportCurrentRunToFile() async {
    final tempDir = await getTemporaryDirectory();
    final filename = '${tempDir.path}/frigoligo.log';

    final file = await File(filename).create();
    final data = utf8.encode(exportCurrentRun());
    file.writeAsBytesSync(data);

    return filename;
  }
}
