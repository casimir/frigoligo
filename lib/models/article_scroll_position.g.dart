// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_scroll_position.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetArticleScrollPositionCollection on Isar {
  IsarCollection<ArticleScrollPosition> get articleScrollPositions =>
      this.collection();
}

const ArticleScrollPositionSchema = CollectionSchema(
  name: r'ArticleScrollPosition',
  id: -9173229516223812652,
  properties: {
    r'progress': PropertySchema(
      id: 0,
      name: r'progress',
      type: IsarType.double,
    ),
    r'readingTime': PropertySchema(
      id: 1,
      name: r'readingTime',
      type: IsarType.long,
    )
  },
  estimateSize: _articleScrollPositionEstimateSize,
  serialize: _articleScrollPositionSerialize,
  deserialize: _articleScrollPositionDeserialize,
  deserializeProp: _articleScrollPositionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _articleScrollPositionGetId,
  getLinks: _articleScrollPositionGetLinks,
  attach: _articleScrollPositionAttach,
  version: '3.1.4',
);

int _articleScrollPositionEstimateSize(
  ArticleScrollPosition object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _articleScrollPositionSerialize(
  ArticleScrollPosition object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.progress);
  writer.writeLong(offsets[1], object.readingTime);
}

ArticleScrollPosition _articleScrollPositionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ArticleScrollPosition();
  object.id = id;
  object.progress = reader.readDouble(offsets[0]);
  object.readingTime = reader.readLong(offsets[1]);
  return object;
}

P _articleScrollPositionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _articleScrollPositionGetId(ArticleScrollPosition object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _articleScrollPositionGetLinks(
    ArticleScrollPosition object) {
  return [];
}

void _articleScrollPositionAttach(
    IsarCollection<dynamic> col, Id id, ArticleScrollPosition object) {
  object.id = id;
}

extension ArticleScrollPositionQueryWhereSort
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QWhere> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ArticleScrollPositionQueryWhere on QueryBuilder<ArticleScrollPosition,
    ArticleScrollPosition, QWhereClause> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ArticleScrollPositionQueryFilter on QueryBuilder<
    ArticleScrollPosition, ArticleScrollPosition, QFilterCondition> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> progressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> progressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> progressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> progressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'readingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'readingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'readingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition,
      QAfterFilterCondition> readingTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'readingTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ArticleScrollPositionQueryObject on QueryBuilder<
    ArticleScrollPosition, ArticleScrollPosition, QFilterCondition> {}

extension ArticleScrollPositionQueryLinks on QueryBuilder<ArticleScrollPosition,
    ArticleScrollPosition, QFilterCondition> {}

extension ArticleScrollPositionQuerySortBy
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QSortBy> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByReadingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingTime', Sort.asc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      sortByReadingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingTime', Sort.desc);
    });
  }
}

extension ArticleScrollPositionQuerySortThenBy
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QSortThenBy> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByReadingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingTime', Sort.asc);
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QAfterSortBy>
      thenByReadingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingTime', Sort.desc);
    });
  }
}

extension ArticleScrollPositionQueryWhereDistinct
    on QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QDistinct> {
  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QDistinct>
      distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<ArticleScrollPosition, ArticleScrollPosition, QDistinct>
      distinctByReadingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readingTime');
    });
  }
}

extension ArticleScrollPositionQueryProperty on QueryBuilder<
    ArticleScrollPosition, ArticleScrollPosition, QQueryProperty> {
  QueryBuilder<ArticleScrollPosition, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ArticleScrollPosition, double, QQueryOperations>
      progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<ArticleScrollPosition, int, QQueryOperations>
      readingTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readingTime');
    });
  }
}
