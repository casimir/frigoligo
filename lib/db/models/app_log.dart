import 'package:drift/drift.dart';

class AppLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get time => dateTime()();
  TextColumn get level => text()();
  TextColumn get loggerName => text()();
  TextColumn get message => text()();
  TextColumn get error => text().nullable()();
  TextColumn get stackTrace => text().nullable()();
  TextColumn get logline => text()();
}
