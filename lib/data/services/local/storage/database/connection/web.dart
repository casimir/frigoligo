import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

QueryExecutor openConnection() => driftDatabase(
  name: 'offline${kDebugMode ? '-dev' : ''}',
  web: DriftWebOptions(
    sqlite3Wasm: Uri.parse('sqlite3.wasm'),
    driftWorker: Uri.parse('drift_worker.js'),
    onResult: (result) {
      if (result.missingFeatures.isNotEmpty) {
        debugPrint(
          'Using ${result.chosenImplementation} due to unsupported '
          'browser features: ${result.missingFeatures}',
        );
      }
    },
  ),
);
