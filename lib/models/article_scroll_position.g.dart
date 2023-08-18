// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_scroll_position.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetArticleScrollPositionCollection on Isar {
  IsarCollection<int, ArticleScrollPosition> get articleScrollPositions =>
      this.collection();
}

const ArticleScrollPositionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ArticleScrollPosition',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'readingTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'position',
        type: IsarType.double,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, ArticleScrollPosition>(
    serialize: serializeArticleScrollPosition,
    deserialize: deserializeArticleScrollPosition,
    deserializeProperty: deserializeArticleScrollPositionProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeArticleScrollPosition(
    IsarWriter writer, ArticleScrollPosition object) {
  IsarCore.writeLong(writer, 1, object.readingTime);
  IsarCore.writeDouble(writer, 2, object.position);
  return object.id;
}

@isarProtected
ArticleScrollPosition deserializeArticleScrollPosition(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final int _readingTime;
  _readingTime = IsarCore.readLong(reader, 1);
  final double _position;
  _position = IsarCore.readDouble(reader, 2);
  final object = ArticleScrollPosition(
    id: _id,
    readingTime: _readingTime,
    position: _position,
  );
  return object;
}

@isarProtected
dynamic deserializeArticleScrollPositionProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readLong(reader, 1);
    case 2:
      return IsarCore.readDouble(reader, 2);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ArticleScrollPositionUpdate {
  bool call({
    required int id,
    int? readingTime,
    double? position,
  });
}

class _ArticleScrollPositionUpdateImpl implements _ArticleScrollPositionUpdate {
  const _ArticleScrollPositionUpdateImpl(this.collection);

  final IsarCollection<int, ArticleScrollPosition> collection;

  @override
  bool call({
    required int id,
    Object? readingTime = ignore,
    Object? position = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (readingTime != ignore) 1: readingTime as int?,
          if (position != ignore) 2: position as double?,
        }) >
        0;
  }
}

sealed class _ArticleScrollPositionUpdateAll {
  int call({
    required List<int> id,
    int? readingTime,
    double? position,
  });
}

class _ArticleScrollPositionUpdateAllImpl
    implements _ArticleScrollPositionUpdateAll {
  const _ArticleScrollPositionUpdateAllImpl(this.collection);

  final IsarCollection<int, ArticleScrollPosition> collection;

  @override
  int call({
    required List<int> id,
    Object? readingTime = ignore,
    Object? position = ignore,
  }) {
    return collection.updateProperties(id, {
      if (readingTime != ignore) 1: readingTime as int?,
      if (position != ignore) 2: position as double?,
    });
  }
}

extension ArticleScrollPositionUpdate
    on IsarCollection<int, ArticleScrollPosition> {
  _ArticleScrollPositionUpdate get update =>
      _ArticleScrollPositionUpdateImpl(this);

  _ArticleScrollPositionUpdateAll get updateAll =>
      _ArticleScrollPositionUpdateAllImpl(this);
}

sealed class _ArticleScrollPositionQueryUpdate {
  int call({
    int? readingTime,
    double? position,
  });
}

class _ArticleScrollPositionQueryUpdateImpl
    implements _ArticleScrollPositionQueryUpdate {
  const _ArticleScrollPositionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ArticleScrollPosition> query;
  final int? limit;

  @override
  int call({
    Object? readingTime = ignore,
    Object? position = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (readingTime != ignore) 1: readingTime as int?,
      if (position != ignore) 2: position as double?,
    });
  }
}

extension ArticleScrollPositionQueryUpdate on IsarQuery<ArticleScrollPosition> {
  _ArticleScrollPositionQueryUpdate get updateFirst =>
      _ArticleScrollPositionQueryUpdateImpl(this, limit: 1);

  _ArticleScrollPositionQueryUpdate get updateAll =>
      _ArticleScrollPositionQueryUpdateImpl(this);
}

class _ArticleScrollPositionQueryBuilderUpdateImpl
    implements _ArticleScrollPositionQueryUpdate {
  const _ArticleScrollPositionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QOperations>
      query;
  final int? limit;

  @override
  int call({
    Object? readingTime = ignore,
    Object? position = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (readingTime != ignore) 1: readingTime as int?,
        if (position != ignore) 2: position as double?,
      });
    } finally {
      q.close();
    }
  }
}

extension ArticleScrollPositionQueryBuilderUpdate
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QOperations> {
  _ArticleScrollPositionQueryUpdate get updateFirst =>
      _ArticleScrollPositionQueryBuilderUpdateImpl(this, limit: 1);

  _ArticleScrollPositionQueryUpdate get updateAll =>
      _ArticleScrollPositionQueryBuilderUpdateImpl(this);
}

extension ArticleScrollPositionQueryFilter on QueryBuilder<
    ArticleScrollPosition, ArticleScrollPosition, QFilterCondition> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> positionEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> positionGreaterThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> positionGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> positionLessThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> positionLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> positionBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          epsilon: epsilon,
        ),
      );
    });
  }
}

extension ArticleScrollPositionQueryObject on QueryBuilder<
    ArticleScrollPosition, ArticleScrollPosition, QFilterCondition> {}

extension ArticleScrollPositionQuerySortBy
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QSortBy> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByReadingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByReadingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }
}

extension ArticleScrollPositionQuerySortThenBy
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QSortThenBy> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByReadingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByReadingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }
}

extension ArticleScrollPositionQueryWhereDistinct
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QDistinct> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterDistinct>
      distinctByReadingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterDistinct>
      distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }
}

extension ArticleScrollPositionQueryProperty1
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QProperty> {
  QueryBuilder<ArticleScrollPosition, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ArticleScrollPosition, int, QAfterProperty>
      readingTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ArticleScrollPosition, double, QAfterProperty>
      positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension ArticleScrollPositionQueryProperty2<R>
    on QueryBuilder<ArticleScrollPosition, R, QAfterProperty> {
  QueryBuilder<ArticleScrollPosition, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ArticleScrollPosition, (R, int), QAfterProperty>
      readingTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ArticleScrollPosition, (R, double), QAfterProperty>
      positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension ArticleScrollPositionQueryProperty3<R1, R2>
    on QueryBuilder<ArticleScrollPosition, (R1, R2), QAfterProperty> {
  QueryBuilder<ArticleScrollPosition, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ArticleScrollPosition, (R1, R2, int), QOperations>
      readingTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ArticleScrollPosition, (R1, R2, double), QOperations>
      positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}
