import 'package:drift/drift.dart';

class RemoteActions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get key => integer()();
  TextColumn get className => text()();
  TextColumn get jsonParams => text()();
}
