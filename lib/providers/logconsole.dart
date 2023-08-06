import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/app_log.dart';
import '../models/db.dart';

class LogConsoleProvider extends ChangeNotifier {
  final db = DB.get();
  StreamSubscription? _watcher;

  LogConsoleProvider() {
    _watcher = db.appLogs.watchLazy().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _watcher?.cancel();
    super.dispose();
  }

  int get count => db.appLogs.countSync();
  AppLog? index(int n) {
    final ids =
        db.appLogs.where().sortByTimeDesc().isarIdProperty().findAllSync();
    return db.appLogs.getSync(ids[n])!;
  }

  void clear() => db.writeTxnSync(() => db.appLogs.clearSync());

  String exportCurrentRun() {
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
