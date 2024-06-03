// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_action.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetRemoteActionCollection on Isar {
  IsarCollection<int, RemoteAction> get remoteActions => this.collection();
}

const RemoteActionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'RemoteAction',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'createdAt',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'keyCode',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'className',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'jsonParams',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, RemoteAction>(
    serialize: serializeRemoteAction,
    deserialize: deserializeRemoteAction,
    deserializeProperty: deserializeRemoteActionProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeRemoteAction(IsarWriter writer, RemoteAction object) {
  IsarCore.writeLong(writer, 1,
      object.createdAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808);
  IsarCore.writeLong(writer, 2, object.keyCode ?? -9223372036854775808);
  {
    final value = object.className;
    if (value == null) {
      IsarCore.writeNull(writer, 3);
    } else {
      IsarCore.writeString(writer, 3, value);
    }
  }
  {
    final value = object.jsonParams;
    if (value == null) {
      IsarCore.writeNull(writer, 4);
    } else {
      IsarCore.writeString(writer, 4, value);
    }
  }
  return object.id;
}

@isarProtected
RemoteAction deserializeRemoteAction(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final DateTime? _createdAt;
  {
    final value = IsarCore.readLong(reader, 1);
    if (value == -9223372036854775808) {
      _createdAt = null;
    } else {
      _createdAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final int? _keyCode;
  {
    final value = IsarCore.readLong(reader, 2);
    if (value == -9223372036854775808) {
      _keyCode = null;
    } else {
      _keyCode = value;
    }
  }
  final String? _className;
  _className = IsarCore.readString(reader, 3);
  final String? _jsonParams;
  _jsonParams = IsarCore.readString(reader, 4);
  final object = RemoteAction(
    id: _id,
    createdAt: _createdAt,
    keyCode: _keyCode,
    className: _className,
    jsonParams: _jsonParams,
  );
  return object;
}

@isarProtected
dynamic deserializeRemoteActionProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      {
        final value = IsarCore.readLong(reader, 1);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 2:
      {
        final value = IsarCore.readLong(reader, 2);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return value;
        }
      }
    case 3:
      return IsarCore.readString(reader, 3);
    case 4:
      return IsarCore.readString(reader, 4);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _RemoteActionUpdate {
  bool call({
    required int id,
    DateTime? createdAt,
    int? keyCode,
    String? className,
    String? jsonParams,
  });
}

class _RemoteActionUpdateImpl implements _RemoteActionUpdate {
  const _RemoteActionUpdateImpl(this.collection);

  final IsarCollection<int, RemoteAction> collection;

  @override
  bool call({
    required int id,
    Object? createdAt = ignore,
    Object? keyCode = ignore,
    Object? className = ignore,
    Object? jsonParams = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (createdAt != ignore) 1: createdAt as DateTime?,
          if (keyCode != ignore) 2: keyCode as int?,
          if (className != ignore) 3: className as String?,
          if (jsonParams != ignore) 4: jsonParams as String?,
        }) >
        0;
  }
}

sealed class _RemoteActionUpdateAll {
  int call({
    required List<int> id,
    DateTime? createdAt,
    int? keyCode,
    String? className,
    String? jsonParams,
  });
}

class _RemoteActionUpdateAllImpl implements _RemoteActionUpdateAll {
  const _RemoteActionUpdateAllImpl(this.collection);

  final IsarCollection<int, RemoteAction> collection;

  @override
  int call({
    required List<int> id,
    Object? createdAt = ignore,
    Object? keyCode = ignore,
    Object? className = ignore,
    Object? jsonParams = ignore,
  }) {
    return collection.updateProperties(id, {
      if (createdAt != ignore) 1: createdAt as DateTime?,
      if (keyCode != ignore) 2: keyCode as int?,
      if (className != ignore) 3: className as String?,
      if (jsonParams != ignore) 4: jsonParams as String?,
    });
  }
}

extension RemoteActionUpdate on IsarCollection<int, RemoteAction> {
  _RemoteActionUpdate get update => _RemoteActionUpdateImpl(this);

  _RemoteActionUpdateAll get updateAll => _RemoteActionUpdateAllImpl(this);
}

sealed class _RemoteActionQueryUpdate {
  int call({
    DateTime? createdAt,
    int? keyCode,
    String? className,
    String? jsonParams,
  });
}

class _RemoteActionQueryUpdateImpl implements _RemoteActionQueryUpdate {
  const _RemoteActionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<RemoteAction> query;
  final int? limit;

  @override
  int call({
    Object? createdAt = ignore,
    Object? keyCode = ignore,
    Object? className = ignore,
    Object? jsonParams = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (createdAt != ignore) 1: createdAt as DateTime?,
      if (keyCode != ignore) 2: keyCode as int?,
      if (className != ignore) 3: className as String?,
      if (jsonParams != ignore) 4: jsonParams as String?,
    });
  }
}

extension RemoteActionQueryUpdate on IsarQuery<RemoteAction> {
  _RemoteActionQueryUpdate get updateFirst =>
      _RemoteActionQueryUpdateImpl(this, limit: 1);

  _RemoteActionQueryUpdate get updateAll => _RemoteActionQueryUpdateImpl(this);
}

class _RemoteActionQueryBuilderUpdateImpl implements _RemoteActionQueryUpdate {
  const _RemoteActionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<RemoteAction, RemoteAction, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? createdAt = ignore,
    Object? keyCode = ignore,
    Object? className = ignore,
    Object? jsonParams = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (createdAt != ignore) 1: createdAt as DateTime?,
        if (keyCode != ignore) 2: keyCode as int?,
        if (className != ignore) 3: className as String?,
        if (jsonParams != ignore) 4: jsonParams as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension RemoteActionQueryBuilderUpdate
    on QueryBuilder<RemoteAction, RemoteAction, QOperations> {
  _RemoteActionQueryUpdate get updateFirst =>
      _RemoteActionQueryBuilderUpdateImpl(this, limit: 1);

  _RemoteActionQueryUpdate get updateAll =>
      _RemoteActionQueryBuilderUpdateImpl(this);
}

extension RemoteActionQueryFilter
    on QueryBuilder<RemoteAction, RemoteAction, QFilterCondition> {
  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      idLessThanOrEqualTo(
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      createdAtEqualTo(
    DateTime? value,
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value,
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      createdAtGreaterThanOrEqualTo(
    DateTime? value,
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value,
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      createdAtLessThanOrEqualTo(
    DateTime? value,
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper,
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

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      keyCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      keyCodeIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      keyCodeEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      keyCodeGreaterThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      keyCodeGreaterThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      keyCodeLessThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      keyCodeLessThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      keyCodeBetween(
    int? lower,
    int? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      classNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterFilterCondition>
      jsonParamsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }
}

extension RemoteActionQueryObject
    on QueryBuilder<RemoteAction, RemoteAction, QFilterCondition> {}

extension RemoteActionQuerySortBy
    on QueryBuilder<RemoteAction, RemoteAction, QSortBy> {
  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByKeyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByKeyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByClassName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByClassNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByJsonParams(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> sortByJsonParamsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension RemoteActionQuerySortThenBy
    on QueryBuilder<RemoteAction, RemoteAction, QSortThenBy> {
  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByKeyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByKeyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByClassName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByClassNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByJsonParams(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterSortBy> thenByJsonParamsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension RemoteActionQueryWhereDistinct
    on QueryBuilder<RemoteAction, RemoteAction, QDistinct> {
  QueryBuilder<RemoteAction, RemoteAction, QAfterDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterDistinct> distinctByKeyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterDistinct> distinctByClassName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RemoteAction, RemoteAction, QAfterDistinct> distinctByJsonParams(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }
}

extension RemoteActionQueryProperty1
    on QueryBuilder<RemoteAction, RemoteAction, QProperty> {
  QueryBuilder<RemoteAction, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RemoteAction, DateTime?, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RemoteAction, int?, QAfterProperty> keyCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RemoteAction, String?, QAfterProperty> classNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RemoteAction, String?, QAfterProperty> jsonParamsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension RemoteActionQueryProperty2<R>
    on QueryBuilder<RemoteAction, R, QAfterProperty> {
  QueryBuilder<RemoteAction, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RemoteAction, (R, DateTime?), QAfterProperty>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RemoteAction, (R, int?), QAfterProperty> keyCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RemoteAction, (R, String?), QAfterProperty> classNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RemoteAction, (R, String?), QAfterProperty>
      jsonParamsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension RemoteActionQueryProperty3<R1, R2>
    on QueryBuilder<RemoteAction, (R1, R2), QAfterProperty> {
  QueryBuilder<RemoteAction, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RemoteAction, (R1, R2, DateTime?), QOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RemoteAction, (R1, R2, int?), QOperations> keyCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RemoteAction, (R1, R2, String?), QOperations>
      classNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RemoteAction, (R1, R2, String?), QOperations>
      jsonParamsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
