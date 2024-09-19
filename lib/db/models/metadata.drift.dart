// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/db/models/metadata.drift.dart' as i1;
import 'package:frigoligo/db/models/metadata.dart' as i2;

class $MetadataTable extends i2.Metadata
    with i0.TableInfo<$MetadataTable, i1.MetadataData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetadataTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          i0.GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const i0.VerificationMeta _keyMeta = const i0.VerificationMeta('key');
  @override
  late final i0.GeneratedColumn<String> key = i0.GeneratedColumn<String>(
      'key', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: i0.GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const i0.VerificationMeta _valueMeta =
      const i0.VerificationMeta('value');
  @override
  late final i0.GeneratedColumn<String> value = i0.GeneratedColumn<String>(
      'value', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<i0.GeneratedColumn> get $columns => [id, key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metadata';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.MetadataData> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.MetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.MetadataData(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}id'])!,
      key: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $MetadataTable createAlias(String alias) {
    return $MetadataTable(attachedDatabase, alias);
  }
}

class MetadataData extends i0.DataClass
    implements i0.Insertable<i1.MetadataData> {
  final int id;
  final String key;
  final String value;
  const MetadataData(
      {required this.id, required this.key, required this.value});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['key'] = i0.Variable<String>(key);
    map['value'] = i0.Variable<String>(value);
    return map;
  }

  i1.MetadataCompanion toCompanion(bool nullToAbsent) {
    return i1.MetadataCompanion(
      id: i0.Value(id),
      key: i0.Value(key),
      value: i0.Value(value),
    );
  }

  factory MetadataData.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return MetadataData(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  i1.MetadataData copyWith({int? id, String? key, String? value}) =>
      i1.MetadataData(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  MetadataData copyWithCompanion(i1.MetadataCompanion data) {
    return MetadataData(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetadataData(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.MetadataData &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value);
}

class MetadataCompanion extends i0.UpdateCompanion<i1.MetadataData> {
  final i0.Value<int> id;
  final i0.Value<String> key;
  final i0.Value<String> value;
  const MetadataCompanion({
    this.id = const i0.Value.absent(),
    this.key = const i0.Value.absent(),
    this.value = const i0.Value.absent(),
  });
  MetadataCompanion.insert({
    this.id = const i0.Value.absent(),
    required String key,
    required String value,
  })  : key = i0.Value(key),
        value = i0.Value(value);
  static i0.Insertable<i1.MetadataData> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? key,
    i0.Expression<String>? value,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  i1.MetadataCompanion copyWith(
      {i0.Value<int>? id, i0.Value<String>? key, i0.Value<String>? value}) {
    return i1.MetadataCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = i0.Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = i0.Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetadataCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

typedef $$MetadataTableCreateCompanionBuilder = i1.MetadataCompanion Function({
  i0.Value<int> id,
  required String key,
  required String value,
});
typedef $$MetadataTableUpdateCompanionBuilder = i1.MetadataCompanion Function({
  i0.Value<int> id,
  i0.Value<String> key,
  i0.Value<String> value,
});

class $$MetadataTableFilterComposer
    extends i0.FilterComposer<i0.GeneratedDatabase, i1.$MetadataTable> {
  $$MetadataTableFilterComposer(super.$state);
  i0.ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MetadataTableOrderingComposer
    extends i0.OrderingComposer<i0.GeneratedDatabase, i1.$MetadataTable> {
  $$MetadataTableOrderingComposer(super.$state);
  i0.ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$MetadataTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$MetadataTable,
    i1.MetadataData,
    i1.$$MetadataTableFilterComposer,
    i1.$$MetadataTableOrderingComposer,
    $$MetadataTableCreateCompanionBuilder,
    $$MetadataTableUpdateCompanionBuilder,
    (
      i1.MetadataData,
      i0
      .BaseReferences<i0.GeneratedDatabase, i1.$MetadataTable, i1.MetadataData>
    ),
    i1.MetadataData,
    i0.PrefetchHooks Function()> {
  $$MetadataTableTableManager(i0.GeneratedDatabase db, i1.$MetadataTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              i1.$$MetadataTableFilterComposer(i0.ComposerState(db, table)),
          orderingComposer:
              i1.$$MetadataTableOrderingComposer(i0.ComposerState(db, table)),
          updateCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            i0.Value<String> key = const i0.Value.absent(),
            i0.Value<String> value = const i0.Value.absent(),
          }) =>
              i1.MetadataCompanion(
            id: id,
            key: key,
            value: value,
          ),
          createCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            required String key,
            required String value,
          }) =>
              i1.MetadataCompanion.insert(
            id: id,
            key: key,
            value: value,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MetadataTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.$MetadataTable,
    i1.MetadataData,
    i1.$$MetadataTableFilterComposer,
    i1.$$MetadataTableOrderingComposer,
    $$MetadataTableCreateCompanionBuilder,
    $$MetadataTableUpdateCompanionBuilder,
    (
      i1.MetadataData,
      i0
      .BaseReferences<i0.GeneratedDatabase, i1.$MetadataTable, i1.MetadataData>
    ),
    i1.MetadataData,
    i0.PrefetchHooks Function()>;
