import 'package:drift/drift.dart';

import '../database.dart';
import '../models/metadata.dart';
import '../models/metadata.drift.dart';
import 'metadata.drift.dart';

@DriftAccessor(tables: [Metadata])
class MetadataDao extends DatabaseAccessor<DB> with $MetadataDaoMixin {
  MetadataDao(super.db);

  Future<int?> getLastSyncTS() async {
    final data = await (select(metadata)
          ..where((m) => m.key.equals(mkLastRefreshTS)))
        .getSingleOrNull();
    return data != null ? int.parse(data.value) : null;
  }

  Future<int> setLastSyncTS(int ts) {
    return metadata.insertOne(
      MetadataCompanion.insert(
        key: mkLastRefreshTS,
        value: ts.toString(),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }
}

const mkLastRefreshTS = 'lastRefreshTS';
