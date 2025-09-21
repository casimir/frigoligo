// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/data/services/local/storage/database/database.dart'
    as i1;
import 'package:frigoligo/data/services/local/storage/database/models/app_log.drift.dart'
    as i2;
import 'package:drift/internal/modular.dart' as i3;

mixin $AppLogsDaoMixin on i0.DatabaseAccessor<i1.DB> {
  i2.AppLogs get appLogs => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i2.AppLogs>('app_logs');
}
