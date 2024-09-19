// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/db/database.dart' as i1;
import 'package:frigoligo/db/models/app_log.drift.dart' as i2;
import 'package:drift/internal/modular.dart' as i3;

mixin $AppLogsDaoMixin on i0.DatabaseAccessor<i1.DB> {
  i2.$AppLogsTable get appLogs => i3.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i2.$AppLogsTable>('app_logs');
}
