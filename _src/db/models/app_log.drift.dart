// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/db/models/app_log.drift.dart' as i1;

typedef $AppLogsCreateCompanionBuilder =
    i1.AppLogsCompanion Function({
      i0.Value<int> id,
      required DateTime time,
      required String level,
      required String loggerName,
      required String message,
      i0.Value<String?> error,
      i0.Value<String?> stackTrace,
      required String logline,
    });
typedef $AppLogsUpdateCompanionBuilder =
    i1.AppLogsCompanion Function({
      i0.Value<int> id,
      i0.Value<DateTime> time,
      i0.Value<String> level,
      i0.Value<String> loggerName,
      i0.Value<String> message,
      i0.Value<String?> error,
      i0.Value<String?> stackTrace,
      i0.Value<String> logline,
    });

class $AppLogsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AppLogs> {
  $AppLogsFilterComposer({
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

  i0.ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get loggerName => $composableBuilder(
    column: $table.loggerName,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get stackTrace => $composableBuilder(
    column: $table.stackTrace,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get logline => $composableBuilder(
    column: $table.logline,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $AppLogsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AppLogs> {
  $AppLogsOrderingComposer({
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

  i0.ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get loggerName => $composableBuilder(
    column: $table.loggerName,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get stackTrace => $composableBuilder(
    column: $table.stackTrace,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get logline => $composableBuilder(
    column: $table.logline,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $AppLogsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AppLogs> {
  $AppLogsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  i0.GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  i0.GeneratedColumn<String> get loggerName => $composableBuilder(
    column: $table.loggerName,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  i0.GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  i0.GeneratedColumn<String> get stackTrace => $composableBuilder(
    column: $table.stackTrace,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get logline =>
      $composableBuilder(column: $table.logline, builder: (column) => column);
}

class $AppLogsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.AppLogs,
          i1.AppLog,
          i1.$AppLogsFilterComposer,
          i1.$AppLogsOrderingComposer,
          i1.$AppLogsAnnotationComposer,
          $AppLogsCreateCompanionBuilder,
          $AppLogsUpdateCompanionBuilder,
          (
            i1.AppLog,
            i0.BaseReferences<i0.GeneratedDatabase, i1.AppLogs, i1.AppLog>,
          ),
          i1.AppLog,
          i0.PrefetchHooks Function()
        > {
  $AppLogsTableManager(i0.GeneratedDatabase db, i1.AppLogs table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => i1.$AppLogsFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => i1.$AppLogsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => i1.$AppLogsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<DateTime> time = const i0.Value.absent(),
                i0.Value<String> level = const i0.Value.absent(),
                i0.Value<String> loggerName = const i0.Value.absent(),
                i0.Value<String> message = const i0.Value.absent(),
                i0.Value<String?> error = const i0.Value.absent(),
                i0.Value<String?> stackTrace = const i0.Value.absent(),
                i0.Value<String> logline = const i0.Value.absent(),
              }) => i1.AppLogsCompanion(
                id: id,
                time: time,
                level: level,
                loggerName: loggerName,
                message: message,
                error: error,
                stackTrace: stackTrace,
                logline: logline,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required DateTime time,
                required String level,
                required String loggerName,
                required String message,
                i0.Value<String?> error = const i0.Value.absent(),
                i0.Value<String?> stackTrace = const i0.Value.absent(),
                required String logline,
              }) => i1.AppLogsCompanion.insert(
                id: id,
                time: time,
                level: level,
                loggerName: loggerName,
                message: message,
                error: error,
                stackTrace: stackTrace,
                logline: logline,
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

typedef $AppLogsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.AppLogs,
      i1.AppLog,
      i1.$AppLogsFilterComposer,
      i1.$AppLogsOrderingComposer,
      i1.$AppLogsAnnotationComposer,
      $AppLogsCreateCompanionBuilder,
      $AppLogsUpdateCompanionBuilder,
      (
        i1.AppLog,
        i0.BaseReferences<i0.GeneratedDatabase, i1.AppLogs, i1.AppLog>,
      ),
      i1.AppLog,
      i0.PrefetchHooks Function()
    >;

class AppLogs extends i0.Table with i0.TableInfo<AppLogs, i1.AppLog> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  AppLogs(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _timeMeta = const i0.VerificationMeta(
    'time',
  );
  late final i0.GeneratedColumn<DateTime> time = i0.GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: i0.DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _levelMeta = const i0.VerificationMeta(
    'level',
  );
  late final i0.GeneratedColumn<String> level = i0.GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _loggerNameMeta = const i0.VerificationMeta(
    'loggerName',
  );
  late final i0.GeneratedColumn<String> loggerName = i0.GeneratedColumn<String>(
    'logger_name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _messageMeta = const i0.VerificationMeta(
    'message',
  );
  late final i0.GeneratedColumn<String> message = i0.GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _errorMeta = const i0.VerificationMeta(
    'error',
  );
  late final i0.GeneratedColumn<String> error = i0.GeneratedColumn<String>(
    'error',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _stackTraceMeta = const i0.VerificationMeta(
    'stackTrace',
  );
  late final i0.GeneratedColumn<String> stackTrace = i0.GeneratedColumn<String>(
    'stack_trace',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _loglineMeta = const i0.VerificationMeta(
    'logline',
  );
  late final i0.GeneratedColumn<String> logline = i0.GeneratedColumn<String>(
    'logline',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    time,
    level,
    loggerName,
    message,
    error,
    stackTrace,
    logline,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_logs';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.AppLog> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('logger_name')) {
      context.handle(
        _loggerNameMeta,
        loggerName.isAcceptableOrUnknown(data['logger_name']!, _loggerNameMeta),
      );
    } else if (isInserting) {
      context.missing(_loggerNameMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('error')) {
      context.handle(
        _errorMeta,
        error.isAcceptableOrUnknown(data['error']!, _errorMeta),
      );
    }
    if (data.containsKey('stack_trace')) {
      context.handle(
        _stackTraceMeta,
        stackTrace.isAcceptableOrUnknown(data['stack_trace']!, _stackTraceMeta),
      );
    }
    if (data.containsKey('logline')) {
      context.handle(
        _loglineMeta,
        logline.isAcceptableOrUnknown(data['logline']!, _loglineMeta),
      );
    } else if (isInserting) {
      context.missing(_loglineMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.AppLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.AppLog(
      id:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      time:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.dateTime,
            data['${effectivePrefix}time'],
          )!,
      level:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}level'],
          )!,
      loggerName:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}logger_name'],
          )!,
      message:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}message'],
          )!,
      error: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}error'],
      ),
      stackTrace: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}stack_trace'],
      ),
      logline:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}logline'],
          )!,
    );
  }

  @override
  AppLogs createAlias(String alias) {
    return AppLogs(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class AppLog extends i0.DataClass implements i0.Insertable<i1.AppLog> {
  final int id;
  final DateTime time;
  final String level;
  final String loggerName;
  final String message;
  final String? error;
  final String? stackTrace;
  final String logline;
  const AppLog({
    required this.id,
    required this.time,
    required this.level,
    required this.loggerName,
    required this.message,
    this.error,
    this.stackTrace,
    required this.logline,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['time'] = i0.Variable<DateTime>(time);
    map['level'] = i0.Variable<String>(level);
    map['logger_name'] = i0.Variable<String>(loggerName);
    map['message'] = i0.Variable<String>(message);
    if (!nullToAbsent || error != null) {
      map['error'] = i0.Variable<String>(error);
    }
    if (!nullToAbsent || stackTrace != null) {
      map['stack_trace'] = i0.Variable<String>(stackTrace);
    }
    map['logline'] = i0.Variable<String>(logline);
    return map;
  }

  i1.AppLogsCompanion toCompanion(bool nullToAbsent) {
    return i1.AppLogsCompanion(
      id: i0.Value(id),
      time: i0.Value(time),
      level: i0.Value(level),
      loggerName: i0.Value(loggerName),
      message: i0.Value(message),
      error:
          error == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(error),
      stackTrace:
          stackTrace == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(stackTrace),
      logline: i0.Value(logline),
    );
  }

  factory AppLog.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return AppLog(
      id: serializer.fromJson<int>(json['id']),
      time: serializer.fromJson<DateTime>(json['time']),
      level: serializer.fromJson<String>(json['level']),
      loggerName: serializer.fromJson<String>(json['logger_name']),
      message: serializer.fromJson<String>(json['message']),
      error: serializer.fromJson<String?>(json['error']),
      stackTrace: serializer.fromJson<String?>(json['stack_trace']),
      logline: serializer.fromJson<String>(json['logline']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'time': serializer.toJson<DateTime>(time),
      'level': serializer.toJson<String>(level),
      'logger_name': serializer.toJson<String>(loggerName),
      'message': serializer.toJson<String>(message),
      'error': serializer.toJson<String?>(error),
      'stack_trace': serializer.toJson<String?>(stackTrace),
      'logline': serializer.toJson<String>(logline),
    };
  }

  i1.AppLog copyWith({
    int? id,
    DateTime? time,
    String? level,
    String? loggerName,
    String? message,
    i0.Value<String?> error = const i0.Value.absent(),
    i0.Value<String?> stackTrace = const i0.Value.absent(),
    String? logline,
  }) => i1.AppLog(
    id: id ?? this.id,
    time: time ?? this.time,
    level: level ?? this.level,
    loggerName: loggerName ?? this.loggerName,
    message: message ?? this.message,
    error: error.present ? error.value : this.error,
    stackTrace: stackTrace.present ? stackTrace.value : this.stackTrace,
    logline: logline ?? this.logline,
  );
  AppLog copyWithCompanion(i1.AppLogsCompanion data) {
    return AppLog(
      id: data.id.present ? data.id.value : this.id,
      time: data.time.present ? data.time.value : this.time,
      level: data.level.present ? data.level.value : this.level,
      loggerName:
          data.loggerName.present ? data.loggerName.value : this.loggerName,
      message: data.message.present ? data.message.value : this.message,
      error: data.error.present ? data.error.value : this.error,
      stackTrace:
          data.stackTrace.present ? data.stackTrace.value : this.stackTrace,
      logline: data.logline.present ? data.logline.value : this.logline,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppLog(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('level: $level, ')
          ..write('loggerName: $loggerName, ')
          ..write('message: $message, ')
          ..write('error: $error, ')
          ..write('stackTrace: $stackTrace, ')
          ..write('logline: $logline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    time,
    level,
    loggerName,
    message,
    error,
    stackTrace,
    logline,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.AppLog &&
          other.id == this.id &&
          other.time == this.time &&
          other.level == this.level &&
          other.loggerName == this.loggerName &&
          other.message == this.message &&
          other.error == this.error &&
          other.stackTrace == this.stackTrace &&
          other.logline == this.logline);
}

class AppLogsCompanion extends i0.UpdateCompanion<i1.AppLog> {
  final i0.Value<int> id;
  final i0.Value<DateTime> time;
  final i0.Value<String> level;
  final i0.Value<String> loggerName;
  final i0.Value<String> message;
  final i0.Value<String?> error;
  final i0.Value<String?> stackTrace;
  final i0.Value<String> logline;
  const AppLogsCompanion({
    this.id = const i0.Value.absent(),
    this.time = const i0.Value.absent(),
    this.level = const i0.Value.absent(),
    this.loggerName = const i0.Value.absent(),
    this.message = const i0.Value.absent(),
    this.error = const i0.Value.absent(),
    this.stackTrace = const i0.Value.absent(),
    this.logline = const i0.Value.absent(),
  });
  AppLogsCompanion.insert({
    this.id = const i0.Value.absent(),
    required DateTime time,
    required String level,
    required String loggerName,
    required String message,
    this.error = const i0.Value.absent(),
    this.stackTrace = const i0.Value.absent(),
    required String logline,
  }) : time = i0.Value(time),
       level = i0.Value(level),
       loggerName = i0.Value(loggerName),
       message = i0.Value(message),
       logline = i0.Value(logline);
  static i0.Insertable<i1.AppLog> custom({
    i0.Expression<int>? id,
    i0.Expression<DateTime>? time,
    i0.Expression<String>? level,
    i0.Expression<String>? loggerName,
    i0.Expression<String>? message,
    i0.Expression<String>? error,
    i0.Expression<String>? stackTrace,
    i0.Expression<String>? logline,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (level != null) 'level': level,
      if (loggerName != null) 'logger_name': loggerName,
      if (message != null) 'message': message,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stack_trace': stackTrace,
      if (logline != null) 'logline': logline,
    });
  }

  i1.AppLogsCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<DateTime>? time,
    i0.Value<String>? level,
    i0.Value<String>? loggerName,
    i0.Value<String>? message,
    i0.Value<String?>? error,
    i0.Value<String?>? stackTrace,
    i0.Value<String>? logline,
  }) {
    return i1.AppLogsCompanion(
      id: id ?? this.id,
      time: time ?? this.time,
      level: level ?? this.level,
      loggerName: loggerName ?? this.loggerName,
      message: message ?? this.message,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      logline: logline ?? this.logline,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (time.present) {
      map['time'] = i0.Variable<DateTime>(time.value);
    }
    if (level.present) {
      map['level'] = i0.Variable<String>(level.value);
    }
    if (loggerName.present) {
      map['logger_name'] = i0.Variable<String>(loggerName.value);
    }
    if (message.present) {
      map['message'] = i0.Variable<String>(message.value);
    }
    if (error.present) {
      map['error'] = i0.Variable<String>(error.value);
    }
    if (stackTrace.present) {
      map['stack_trace'] = i0.Variable<String>(stackTrace.value);
    }
    if (logline.present) {
      map['logline'] = i0.Variable<String>(logline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppLogsCompanion(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('level: $level, ')
          ..write('loggerName: $loggerName, ')
          ..write('message: $message, ')
          ..write('error: $error, ')
          ..write('stackTrace: $stackTrace, ')
          ..write('logline: $logline')
          ..write(')'))
        .toString();
  }
}
