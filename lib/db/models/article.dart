import 'package:drift/drift.dart';

import '../converters/containers.dart';

class Articles extends Table {
  IntColumn get id => integer().unique()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get title => text()();
  TextColumn get domainName => text().nullable()();
  TextColumn get url => text()();

  TextColumn get content => text().nullable()();
  TextColumn get language => text().nullable()();
  IntColumn get readingTime => integer()();
  TextColumn get previewPicture => text().nullable()();

  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get starredAt => dateTime().nullable()();
  TextColumn get tags => text().map(const StringListConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class ArticleScrollPositions extends Table {
  IntColumn get id => integer().unique()();
  IntColumn get readingTime => integer()();
  RealColumn get progress => real()();

  @override
  Set<Column> get primaryKey => {id};
}
