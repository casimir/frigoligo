// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/data/services/local/storage/database/database.dart'
    as i1;
import 'package:frigoligo/data/services/local/storage/database/models/metadata.drift.dart'
    as i2;
import 'package:drift/internal/modular.dart' as i3;

mixin $MetadataDaoMixin on i0.DatabaseAccessor<i1.DB> {
  i2.Metadata get metadata => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i2.Metadata>('metadata');
}
