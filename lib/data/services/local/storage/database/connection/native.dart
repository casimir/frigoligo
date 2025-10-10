import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_foundation/path_provider_foundation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../../../../constants.dart';

Future<File> getDBPath(bool devmode, {bool container = true}) async {
  late Directory rootDir;
  if (UniversalPlatform.isIOS && container) {
    final containerPath = await PathProviderFoundation().getContainerPath(
      appGroupIdentifier: appGroupId,
    );
    rootDir = Directory(containerPath!);
  } else {
    rootDir = await getApplicationSupportDirectory();
  }
  final dir = '${rootDir.path}/offline${devmode ? '-dev' : ''}';
  return File('$dir/data.sqlite');
}

QueryExecutor openConnection() {
  return LazyDatabase(() async {
    // clean old db files in the background
    _cleanOldDBs();
    // move db from private directory to container (when applicable)
    await _moveToContainer(kDebugMode);

    // make sqlite use a sandboxed temp directory
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    final dbFile = await getDBPath(kDebugMode);
    if (kDebugMode) {
      print('DEBUG: database path:   "${dbFile.path}"');
      print('DEBUG: database exists: ${dbFile.existsSync()}');
    }
    return NativeDatabase.createInBackground(
      dbFile,
      logStatements: enableSqlLogs,
    );
  });
}

Future<void> _cleanOldDBs() async {
  final dir = (await getDBPath(kDebugMode)).parent.path;
  final dbFile = File('$dir/data.isar');
  final lockFile = File('$dir/data.isar.lock');

  for (final file in [dbFile, lockFile]) {
    if (await file.exists()) {
      await file.delete();
    }
  }
}

Future<void> _moveToContainer(bool devmode) async {
  if (!UniversalPlatform.isIOS) return;

  final source = await getDBPath(devmode, container: false);
  if (source.existsSync()) {
    final dest = await getDBPath(devmode);
    if (!dest.parent.existsSync()) {
      dest.parent.createSync(recursive: true);
    }
    source.copySync(dest.path);
    source.deleteSync();
  }
}

QueryExecutor inMemory() {
  return DatabaseConnection(
    NativeDatabase.memory(logStatements: enableSqlLogs),
    closeStreamsSynchronously: true,
  );
}
