// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/data/services/local/storage/database/models/remote_action.drift.dart'
    as i1;

typedef $RemoteActionsCreateCompanionBuilder =
    i1.RemoteActionsCompanion Function({
      i0.Value<int> id,
      required DateTime createdAt,
      required int key,
      required String className,
      required String jsonParams,
    });
typedef $RemoteActionsUpdateCompanionBuilder =
    i1.RemoteActionsCompanion Function({
      i0.Value<int> id,
      i0.Value<DateTime> createdAt,
      i0.Value<int> key,
      i0.Value<String> className,
      i0.Value<String> jsonParams,
    });

class $RemoteActionsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.RemoteActions> {
  $RemoteActionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get jsonParams => $composableBuilder(
    column: $table.jsonParams,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $RemoteActionsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.RemoteActions> {
  $RemoteActionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get jsonParams => $composableBuilder(
    column: $table.jsonParams,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $RemoteActionsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.RemoteActions> {
  $RemoteActionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  i0.GeneratedColumn<int> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  i0.GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  i0.GeneratedColumn<String> get jsonParams => $composableBuilder(
    column: $table.jsonParams,
    builder: (column) => column,
  );
}

class $RemoteActionsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.RemoteActions,
          i1.RemoteAction,
          i1.$RemoteActionsFilterComposer,
          i1.$RemoteActionsOrderingComposer,
          i1.$RemoteActionsAnnotationComposer,
          $RemoteActionsCreateCompanionBuilder,
          $RemoteActionsUpdateCompanionBuilder,
          (
            i1.RemoteAction,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.RemoteActions,
              i1.RemoteAction
            >,
          ),
          i1.RemoteAction,
          i0.PrefetchHooks Function()
        > {
  $RemoteActionsTableManager(i0.GeneratedDatabase db, i1.RemoteActions table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => i1.$RemoteActionsFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => i1.$RemoteActionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => i1.$RemoteActionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
                i0.Value<int> key = const i0.Value.absent(),
                i0.Value<String> className = const i0.Value.absent(),
                i0.Value<String> jsonParams = const i0.Value.absent(),
              }) => i1.RemoteActionsCompanion(
                id: id,
                createdAt: createdAt,
                key: key,
                className: className,
                jsonParams: jsonParams,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required DateTime createdAt,
                required int key,
                required String className,
                required String jsonParams,
              }) => i1.RemoteActionsCompanion.insert(
                id: id,
                createdAt: createdAt,
                key: key,
                className: className,
                jsonParams: jsonParams,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          i0.BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $RemoteActionsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.RemoteActions,
      i1.RemoteAction,
      i1.$RemoteActionsFilterComposer,
      i1.$RemoteActionsOrderingComposer,
      i1.$RemoteActionsAnnotationComposer,
      $RemoteActionsCreateCompanionBuilder,
      $RemoteActionsUpdateCompanionBuilder,
      (
        i1.RemoteAction,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.RemoteActions,
          i1.RemoteAction
        >,
      ),
      i1.RemoteAction,
      i0.PrefetchHooks Function()
    >;

class RemoteActions extends i0.Table
    with i0.TableInfo<RemoteActions, i1.RemoteAction> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  RemoteActions(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const i0.VerificationMeta _createdAtMeta = const i0.VerificationMeta(
    'createdAt',
  );
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>(
        'created_at',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _keyMeta = const i0.VerificationMeta('key');
  late final i0.GeneratedColumn<int> key = i0.GeneratedColumn<int>(
    'key',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _classNameMeta = const i0.VerificationMeta(
    'className',
  );
  late final i0.GeneratedColumn<String> className = i0.GeneratedColumn<String>(
    'class_name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _jsonParamsMeta = const i0.VerificationMeta(
    'jsonParams',
  );
  late final i0.GeneratedColumn<String> jsonParams = i0.GeneratedColumn<String>(
    'json_params',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    createdAt,
    key,
    className,
    jsonParams,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'remote_actions';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.RemoteAction> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('class_name')) {
      context.handle(
        _classNameMeta,
        className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta),
      );
    } else if (isInserting) {
      context.missing(_classNameMeta);
    }
    if (data.containsKey('json_params')) {
      context.handle(
        _jsonParamsMeta,
        jsonParams.isAcceptableOrUnknown(data['json_params']!, _jsonParamsMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonParamsMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.RemoteAction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.RemoteAction(
      id:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      key:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.int,
            data['${effectivePrefix}key'],
          )!,
      className:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}class_name'],
          )!,
      jsonParams:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}json_params'],
          )!,
    );
  }

  @override
  RemoteActions createAlias(String alias) {
    return RemoteActions(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class RemoteAction extends i0.DataClass
    implements i0.Insertable<i1.RemoteAction> {
  final int id;
  final DateTime createdAt;
  final int key;
  final String className;
  final String jsonParams;
  const RemoteAction({
    required this.id,
    required this.createdAt,
    required this.key,
    required this.className,
    required this.jsonParams,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    map['key'] = i0.Variable<int>(key);
    map['class_name'] = i0.Variable<String>(className);
    map['json_params'] = i0.Variable<String>(jsonParams);
    return map;
  }

  i1.RemoteActionsCompanion toCompanion(bool nullToAbsent) {
    return i1.RemoteActionsCompanion(
      id: i0.Value(id),
      createdAt: i0.Value(createdAt),
      key: i0.Value(key),
      className: i0.Value(className),
      jsonParams: i0.Value(jsonParams),
    );
  }

  factory RemoteAction.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return RemoteAction(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      key: serializer.fromJson<int>(json['key']),
      className: serializer.fromJson<String>(json['class_name']),
      jsonParams: serializer.fromJson<String>(json['json_params']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'key': serializer.toJson<int>(key),
      'class_name': serializer.toJson<String>(className),
      'json_params': serializer.toJson<String>(jsonParams),
    };
  }

  i1.RemoteAction copyWith({
    int? id,
    DateTime? createdAt,
    int? key,
    String? className,
    String? jsonParams,
  }) => i1.RemoteAction(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    key: key ?? this.key,
    className: className ?? this.className,
    jsonParams: jsonParams ?? this.jsonParams,
  );
  RemoteAction copyWithCompanion(i1.RemoteActionsCompanion data) {
    return RemoteAction(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      key: data.key.present ? data.key.value : this.key,
      className: data.className.present ? data.className.value : this.className,
      jsonParams:
          data.jsonParams.present ? data.jsonParams.value : this.jsonParams,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RemoteAction(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('key: $key, ')
          ..write('className: $className, ')
          ..write('jsonParams: $jsonParams')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, key, className, jsonParams);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.RemoteAction &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.key == this.key &&
          other.className == this.className &&
          other.jsonParams == this.jsonParams);
}

class RemoteActionsCompanion extends i0.UpdateCompanion<i1.RemoteAction> {
  final i0.Value<int> id;
  final i0.Value<DateTime> createdAt;
  final i0.Value<int> key;
  final i0.Value<String> className;
  final i0.Value<String> jsonParams;
  const RemoteActionsCompanion({
    this.id = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.key = const i0.Value.absent(),
    this.className = const i0.Value.absent(),
    this.jsonParams = const i0.Value.absent(),
  });
  RemoteActionsCompanion.insert({
    this.id = const i0.Value.absent(),
    required DateTime createdAt,
    required int key,
    required String className,
    required String jsonParams,
  }) : createdAt = i0.Value(createdAt),
       key = i0.Value(key),
       className = i0.Value(className),
       jsonParams = i0.Value(jsonParams);
  static i0.Insertable<i1.RemoteAction> custom({
    i0.Expression<int>? id,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<int>? key,
    i0.Expression<String>? className,
    i0.Expression<String>? jsonParams,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (key != null) 'key': key,
      if (className != null) 'class_name': className,
      if (jsonParams != null) 'json_params': jsonParams,
    });
  }

  i1.RemoteActionsCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<DateTime>? createdAt,
    i0.Value<int>? key,
    i0.Value<String>? className,
    i0.Value<String>? jsonParams,
  }) {
    return i1.RemoteActionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      key: key ?? this.key,
      className: className ?? this.className,
      jsonParams: jsonParams ?? this.jsonParams,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (key.present) {
      map['key'] = i0.Variable<int>(key.value);
    }
    if (className.present) {
      map['class_name'] = i0.Variable<String>(className.value);
    }
    if (jsonParams.present) {
      map['json_params'] = i0.Variable<String>(jsonParams.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemoteActionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('key: $key, ')
          ..write('className: $className, ')
          ..write('jsonParams: $jsonParams')
          ..write(')'))
        .toString();
  }
}
