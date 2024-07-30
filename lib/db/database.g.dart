// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AppLogsTable extends AppLogs with TableInfo<$AppLogsTable, AppLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
      'level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _loggerNameMeta =
      const VerificationMeta('loggerName');
  @override
  late final GeneratedColumn<String> loggerName = GeneratedColumn<String>(
      'logger_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stackTraceMeta =
      const VerificationMeta('stackTrace');
  @override
  late final GeneratedColumn<String> stackTrace = GeneratedColumn<String>(
      'stack_trace', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _loglineMeta =
      const VerificationMeta('logline');
  @override
  late final GeneratedColumn<String> logline = GeneratedColumn<String>(
      'logline', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, time, level, loggerName, message, error, stackTrace, logline];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_logs';
  @override
  VerificationContext validateIntegrity(Insertable<AppLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('logger_name')) {
      context.handle(
          _loggerNameMeta,
          loggerName.isAcceptableOrUnknown(
              data['logger_name']!, _loggerNameMeta));
    } else if (isInserting) {
      context.missing(_loggerNameMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('stack_trace')) {
      context.handle(
          _stackTraceMeta,
          stackTrace.isAcceptableOrUnknown(
              data['stack_trace']!, _stackTraceMeta));
    }
    if (data.containsKey('logline')) {
      context.handle(_loglineMeta,
          logline.isAcceptableOrUnknown(data['logline']!, _loglineMeta));
    } else if (isInserting) {
      context.missing(_loglineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])!,
      loggerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logger_name'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
      stackTrace: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stack_trace']),
      logline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logline'])!,
    );
  }

  @override
  $AppLogsTable createAlias(String alias) {
    return $AppLogsTable(attachedDatabase, alias);
  }
}

class AppLog extends DataClass implements Insertable<AppLog> {
  final int id;
  final DateTime time;
  final String level;
  final String loggerName;
  final String message;
  final String? error;
  final String? stackTrace;
  final String logline;
  const AppLog(
      {required this.id,
      required this.time,
      required this.level,
      required this.loggerName,
      required this.message,
      this.error,
      this.stackTrace,
      required this.logline});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['time'] = Variable<DateTime>(time);
    map['level'] = Variable<String>(level);
    map['logger_name'] = Variable<String>(loggerName);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    if (!nullToAbsent || stackTrace != null) {
      map['stack_trace'] = Variable<String>(stackTrace);
    }
    map['logline'] = Variable<String>(logline);
    return map;
  }

  AppLogsCompanion toCompanion(bool nullToAbsent) {
    return AppLogsCompanion(
      id: Value(id),
      time: Value(time),
      level: Value(level),
      loggerName: Value(loggerName),
      message: Value(message),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      stackTrace: stackTrace == null && nullToAbsent
          ? const Value.absent()
          : Value(stackTrace),
      logline: Value(logline),
    );
  }

  factory AppLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppLog(
      id: serializer.fromJson<int>(json['id']),
      time: serializer.fromJson<DateTime>(json['time']),
      level: serializer.fromJson<String>(json['level']),
      loggerName: serializer.fromJson<String>(json['loggerName']),
      message: serializer.fromJson<String>(json['message']),
      error: serializer.fromJson<String?>(json['error']),
      stackTrace: serializer.fromJson<String?>(json['stackTrace']),
      logline: serializer.fromJson<String>(json['logline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'time': serializer.toJson<DateTime>(time),
      'level': serializer.toJson<String>(level),
      'loggerName': serializer.toJson<String>(loggerName),
      'message': serializer.toJson<String>(message),
      'error': serializer.toJson<String?>(error),
      'stackTrace': serializer.toJson<String?>(stackTrace),
      'logline': serializer.toJson<String>(logline),
    };
  }

  AppLog copyWith(
          {int? id,
          DateTime? time,
          String? level,
          String? loggerName,
          String? message,
          Value<String?> error = const Value.absent(),
          Value<String?> stackTrace = const Value.absent(),
          String? logline}) =>
      AppLog(
        id: id ?? this.id,
        time: time ?? this.time,
        level: level ?? this.level,
        loggerName: loggerName ?? this.loggerName,
        message: message ?? this.message,
        error: error.present ? error.value : this.error,
        stackTrace: stackTrace.present ? stackTrace.value : this.stackTrace,
        logline: logline ?? this.logline,
      );
  AppLog copyWithCompanion(AppLogsCompanion data) {
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
      id, time, level, loggerName, message, error, stackTrace, logline);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLog &&
          other.id == this.id &&
          other.time == this.time &&
          other.level == this.level &&
          other.loggerName == this.loggerName &&
          other.message == this.message &&
          other.error == this.error &&
          other.stackTrace == this.stackTrace &&
          other.logline == this.logline);
}

class AppLogsCompanion extends UpdateCompanion<AppLog> {
  final Value<int> id;
  final Value<DateTime> time;
  final Value<String> level;
  final Value<String> loggerName;
  final Value<String> message;
  final Value<String?> error;
  final Value<String?> stackTrace;
  final Value<String> logline;
  const AppLogsCompanion({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.level = const Value.absent(),
    this.loggerName = const Value.absent(),
    this.message = const Value.absent(),
    this.error = const Value.absent(),
    this.stackTrace = const Value.absent(),
    this.logline = const Value.absent(),
  });
  AppLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime time,
    required String level,
    required String loggerName,
    required String message,
    this.error = const Value.absent(),
    this.stackTrace = const Value.absent(),
    required String logline,
  })  : time = Value(time),
        level = Value(level),
        loggerName = Value(loggerName),
        message = Value(message),
        logline = Value(logline);
  static Insertable<AppLog> custom({
    Expression<int>? id,
    Expression<DateTime>? time,
    Expression<String>? level,
    Expression<String>? loggerName,
    Expression<String>? message,
    Expression<String>? error,
    Expression<String>? stackTrace,
    Expression<String>? logline,
  }) {
    return RawValuesInsertable({
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

  AppLogsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? time,
      Value<String>? level,
      Value<String>? loggerName,
      Value<String>? message,
      Value<String?>? error,
      Value<String?>? stackTrace,
      Value<String>? logline}) {
    return AppLogsCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (loggerName.present) {
      map['logger_name'] = Variable<String>(loggerName.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (stackTrace.present) {
      map['stack_trace'] = Variable<String>(stackTrace.value);
    }
    if (logline.present) {
      map['logline'] = Variable<String>(logline.value);
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

class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _domainNameMeta =
      const VerificationMeta('domainName');
  @override
  late final GeneratedColumn<String> domainName = GeneratedColumn<String>(
      'domain_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _readingTimeMeta =
      const VerificationMeta('readingTime');
  @override
  late final GeneratedColumn<int> readingTime = GeneratedColumn<int>(
      'reading_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _previewPictureMeta =
      const VerificationMeta('previewPicture');
  @override
  late final GeneratedColumn<String> previewPicture = GeneratedColumn<String>(
      'preview_picture', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _archivedAtMeta =
      const VerificationMeta('archivedAt');
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
      'archived_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _starredAtMeta =
      const VerificationMeta('starredAt');
  @override
  late final GeneratedColumn<DateTime> starredAt = GeneratedColumn<DateTime>(
      'starred_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> tags =
      GeneratedColumn<String>('tags', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($ArticlesTable.$convertertags);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        title,
        domainName,
        url,
        content,
        language,
        readingTime,
        previewPicture,
        archivedAt,
        starredAt,
        tags
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(Insertable<Article> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('domain_name')) {
      context.handle(
          _domainNameMeta,
          domainName.isAcceptableOrUnknown(
              data['domain_name']!, _domainNameMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('reading_time')) {
      context.handle(
          _readingTimeMeta,
          readingTime.isAcceptableOrUnknown(
              data['reading_time']!, _readingTimeMeta));
    } else if (isInserting) {
      context.missing(_readingTimeMeta);
    }
    if (data.containsKey('preview_picture')) {
      context.handle(
          _previewPictureMeta,
          previewPicture.isAcceptableOrUnknown(
              data['preview_picture']!, _previewPictureMeta));
    }
    if (data.containsKey('archived_at')) {
      context.handle(
          _archivedAtMeta,
          archivedAt.isAcceptableOrUnknown(
              data['archived_at']!, _archivedAtMeta));
    }
    if (data.containsKey('starred_at')) {
      context.handle(_starredAtMeta,
          starredAt.isAcceptableOrUnknown(data['starred_at']!, _starredAtMeta));
    }
    context.handle(_tagsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      domainName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}domain_name']),
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language']),
      readingTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reading_time'])!,
      previewPicture: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}preview_picture']),
      archivedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}archived_at']),
      starredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}starred_at']),
      tags: $ArticlesTable.$convertertags.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!),
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertertags =
      const StringListConverter();
}

class Article extends DataClass implements Insertable<Article> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String? domainName;
  final String url;
  final String? content;
  final String? language;
  final int readingTime;
  final String? previewPicture;
  final DateTime? archivedAt;
  final DateTime? starredAt;
  final List<String> tags;
  const Article(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.title,
      this.domainName,
      required this.url,
      this.content,
      this.language,
      required this.readingTime,
      this.previewPicture,
      this.archivedAt,
      this.starredAt,
      required this.tags});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || domainName != null) {
      map['domain_name'] = Variable<String>(domainName);
    }
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    map['reading_time'] = Variable<int>(readingTime);
    if (!nullToAbsent || previewPicture != null) {
      map['preview_picture'] = Variable<String>(previewPicture);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    if (!nullToAbsent || starredAt != null) {
      map['starred_at'] = Variable<DateTime>(starredAt);
    }
    {
      map['tags'] = Variable<String>($ArticlesTable.$convertertags.toSql(tags));
    }
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      title: Value(title),
      domainName: domainName == null && nullToAbsent
          ? const Value.absent()
          : Value(domainName),
      url: Value(url),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      readingTime: Value(readingTime),
      previewPicture: previewPicture == null && nullToAbsent
          ? const Value.absent()
          : Value(previewPicture),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      starredAt: starredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(starredAt),
      tags: Value(tags),
    );
  }

  factory Article.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      title: serializer.fromJson<String>(json['title']),
      domainName: serializer.fromJson<String?>(json['domainName']),
      url: serializer.fromJson<String>(json['url']),
      content: serializer.fromJson<String?>(json['content']),
      language: serializer.fromJson<String?>(json['language']),
      readingTime: serializer.fromJson<int>(json['readingTime']),
      previewPicture: serializer.fromJson<String?>(json['previewPicture']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      starredAt: serializer.fromJson<DateTime?>(json['starredAt']),
      tags: serializer.fromJson<List<String>>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'title': serializer.toJson<String>(title),
      'domainName': serializer.toJson<String?>(domainName),
      'url': serializer.toJson<String>(url),
      'content': serializer.toJson<String?>(content),
      'language': serializer.toJson<String?>(language),
      'readingTime': serializer.toJson<int>(readingTime),
      'previewPicture': serializer.toJson<String?>(previewPicture),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'starredAt': serializer.toJson<DateTime?>(starredAt),
      'tags': serializer.toJson<List<String>>(tags),
    };
  }

  Article copyWith(
          {int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? title,
          Value<String?> domainName = const Value.absent(),
          String? url,
          Value<String?> content = const Value.absent(),
          Value<String?> language = const Value.absent(),
          int? readingTime,
          Value<String?> previewPicture = const Value.absent(),
          Value<DateTime?> archivedAt = const Value.absent(),
          Value<DateTime?> starredAt = const Value.absent(),
          List<String>? tags}) =>
      Article(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        domainName: domainName.present ? domainName.value : this.domainName,
        url: url ?? this.url,
        content: content.present ? content.value : this.content,
        language: language.present ? language.value : this.language,
        readingTime: readingTime ?? this.readingTime,
        previewPicture:
            previewPicture.present ? previewPicture.value : this.previewPicture,
        archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
        starredAt: starredAt.present ? starredAt.value : this.starredAt,
        tags: tags ?? this.tags,
      );
  Article copyWithCompanion(ArticlesCompanion data) {
    return Article(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      title: data.title.present ? data.title.value : this.title,
      domainName:
          data.domainName.present ? data.domainName.value : this.domainName,
      url: data.url.present ? data.url.value : this.url,
      content: data.content.present ? data.content.value : this.content,
      language: data.language.present ? data.language.value : this.language,
      readingTime:
          data.readingTime.present ? data.readingTime.value : this.readingTime,
      previewPicture: data.previewPicture.present
          ? data.previewPicture.value
          : this.previewPicture,
      archivedAt:
          data.archivedAt.present ? data.archivedAt.value : this.archivedAt,
      starredAt: data.starredAt.present ? data.starredAt.value : this.starredAt,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('domainName: $domainName, ')
          ..write('url: $url, ')
          ..write('content: $content, ')
          ..write('language: $language, ')
          ..write('readingTime: $readingTime, ')
          ..write('previewPicture: $previewPicture, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('starredAt: $starredAt, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      updatedAt,
      title,
      domainName,
      url,
      content,
      language,
      readingTime,
      previewPicture,
      archivedAt,
      starredAt,
      tags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.title == this.title &&
          other.domainName == this.domainName &&
          other.url == this.url &&
          other.content == this.content &&
          other.language == this.language &&
          other.readingTime == this.readingTime &&
          other.previewPicture == this.previewPicture &&
          other.archivedAt == this.archivedAt &&
          other.starredAt == this.starredAt &&
          other.tags == this.tags);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> title;
  final Value<String?> domainName;
  final Value<String> url;
  final Value<String?> content;
  final Value<String?> language;
  final Value<int> readingTime;
  final Value<String?> previewPicture;
  final Value<DateTime?> archivedAt;
  final Value<DateTime?> starredAt;
  final Value<List<String>> tags;
  final Value<int> rowid;
  const ArticlesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.domainName = const Value.absent(),
    this.url = const Value.absent(),
    this.content = const Value.absent(),
    this.language = const Value.absent(),
    this.readingTime = const Value.absent(),
    this.previewPicture = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.starredAt = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticlesCompanion.insert({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String title,
    this.domainName = const Value.absent(),
    required String url,
    this.content = const Value.absent(),
    this.language = const Value.absent(),
    required int readingTime,
    this.previewPicture = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.starredAt = const Value.absent(),
    required List<String> tags,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        title = Value(title),
        url = Value(url),
        readingTime = Value(readingTime),
        tags = Value(tags);
  static Insertable<Article> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<String>? domainName,
    Expression<String>? url,
    Expression<String>? content,
    Expression<String>? language,
    Expression<int>? readingTime,
    Expression<String>? previewPicture,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? starredAt,
    Expression<String>? tags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (domainName != null) 'domain_name': domainName,
      if (url != null) 'url': url,
      if (content != null) 'content': content,
      if (language != null) 'language': language,
      if (readingTime != null) 'reading_time': readingTime,
      if (previewPicture != null) 'preview_picture': previewPicture,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (starredAt != null) 'starred_at': starredAt,
      if (tags != null) 'tags': tags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticlesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<String?>? domainName,
      Value<String>? url,
      Value<String?>? content,
      Value<String?>? language,
      Value<int>? readingTime,
      Value<String?>? previewPicture,
      Value<DateTime?>? archivedAt,
      Value<DateTime?>? starredAt,
      Value<List<String>>? tags,
      Value<int>? rowid}) {
    return ArticlesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      domainName: domainName ?? this.domainName,
      url: url ?? this.url,
      content: content ?? this.content,
      language: language ?? this.language,
      readingTime: readingTime ?? this.readingTime,
      previewPicture: previewPicture ?? this.previewPicture,
      archivedAt: archivedAt ?? this.archivedAt,
      starredAt: starredAt ?? this.starredAt,
      tags: tags ?? this.tags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (domainName.present) {
      map['domain_name'] = Variable<String>(domainName.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (readingTime.present) {
      map['reading_time'] = Variable<int>(readingTime.value);
    }
    if (previewPicture.present) {
      map['preview_picture'] = Variable<String>(previewPicture.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (starredAt.present) {
      map['starred_at'] = Variable<DateTime>(starredAt.value);
    }
    if (tags.present) {
      map['tags'] =
          Variable<String>($ArticlesTable.$convertertags.toSql(tags.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('domainName: $domainName, ')
          ..write('url: $url, ')
          ..write('content: $content, ')
          ..write('language: $language, ')
          ..write('readingTime: $readingTime, ')
          ..write('previewPicture: $previewPicture, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('starredAt: $starredAt, ')
          ..write('tags: $tags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArticleScrollPositionsTable extends ArticleScrollPositions
    with TableInfo<$ArticleScrollPositionsTable, ArticleScrollPosition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticleScrollPositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _readingTimeMeta =
      const VerificationMeta('readingTime');
  @override
  late final GeneratedColumn<int> readingTime = GeneratedColumn<int>(
      'reading_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, readingTime, progress];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'article_scroll_positions';
  @override
  VerificationContext validateIntegrity(
      Insertable<ArticleScrollPosition> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('reading_time')) {
      context.handle(
          _readingTimeMeta,
          readingTime.isAcceptableOrUnknown(
              data['reading_time']!, _readingTimeMeta));
    } else if (isInserting) {
      context.missing(_readingTimeMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ArticleScrollPosition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticleScrollPosition(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      readingTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reading_time'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
    );
  }

  @override
  $ArticleScrollPositionsTable createAlias(String alias) {
    return $ArticleScrollPositionsTable(attachedDatabase, alias);
  }
}

class ArticleScrollPosition extends DataClass
    implements Insertable<ArticleScrollPosition> {
  final int id;
  final int readingTime;
  final double progress;
  const ArticleScrollPosition(
      {required this.id, required this.readingTime, required this.progress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reading_time'] = Variable<int>(readingTime);
    map['progress'] = Variable<double>(progress);
    return map;
  }

  ArticleScrollPositionsCompanion toCompanion(bool nullToAbsent) {
    return ArticleScrollPositionsCompanion(
      id: Value(id),
      readingTime: Value(readingTime),
      progress: Value(progress),
    );
  }

  factory ArticleScrollPosition.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticleScrollPosition(
      id: serializer.fromJson<int>(json['id']),
      readingTime: serializer.fromJson<int>(json['readingTime']),
      progress: serializer.fromJson<double>(json['progress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'readingTime': serializer.toJson<int>(readingTime),
      'progress': serializer.toJson<double>(progress),
    };
  }

  ArticleScrollPosition copyWith(
          {int? id, int? readingTime, double? progress}) =>
      ArticleScrollPosition(
        id: id ?? this.id,
        readingTime: readingTime ?? this.readingTime,
        progress: progress ?? this.progress,
      );
  ArticleScrollPosition copyWithCompanion(
      ArticleScrollPositionsCompanion data) {
    return ArticleScrollPosition(
      id: data.id.present ? data.id.value : this.id,
      readingTime:
          data.readingTime.present ? data.readingTime.value : this.readingTime,
      progress: data.progress.present ? data.progress.value : this.progress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticleScrollPosition(')
          ..write('id: $id, ')
          ..write('readingTime: $readingTime, ')
          ..write('progress: $progress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, readingTime, progress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleScrollPosition &&
          other.id == this.id &&
          other.readingTime == this.readingTime &&
          other.progress == this.progress);
}

class ArticleScrollPositionsCompanion
    extends UpdateCompanion<ArticleScrollPosition> {
  final Value<int> id;
  final Value<int> readingTime;
  final Value<double> progress;
  final Value<int> rowid;
  const ArticleScrollPositionsCompanion({
    this.id = const Value.absent(),
    this.readingTime = const Value.absent(),
    this.progress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticleScrollPositionsCompanion.insert({
    required int id,
    required int readingTime,
    required double progress,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        readingTime = Value(readingTime),
        progress = Value(progress);
  static Insertable<ArticleScrollPosition> custom({
    Expression<int>? id,
    Expression<int>? readingTime,
    Expression<double>? progress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (readingTime != null) 'reading_time': readingTime,
      if (progress != null) 'progress': progress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticleScrollPositionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? readingTime,
      Value<double>? progress,
      Value<int>? rowid}) {
    return ArticleScrollPositionsCompanion(
      id: id ?? this.id,
      readingTime: readingTime ?? this.readingTime,
      progress: progress ?? this.progress,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (readingTime.present) {
      map['reading_time'] = Variable<int>(readingTime.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleScrollPositionsCompanion(')
          ..write('id: $id, ')
          ..write('readingTime: $readingTime, ')
          ..write('progress: $progress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemoteActionsTable extends RemoteActions
    with TableInfo<$RemoteActionsTable, RemoteAction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemoteActionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<int> key = GeneratedColumn<int>(
      'key', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _classNameMeta =
      const VerificationMeta('className');
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
      'class_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jsonParamsMeta =
      const VerificationMeta('jsonParams');
  @override
  late final GeneratedColumn<String> jsonParams = GeneratedColumn<String>(
      'json_params', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, key, className, jsonParams];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'remote_actions';
  @override
  VerificationContext validateIntegrity(Insertable<RemoteAction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('class_name')) {
      context.handle(_classNameMeta,
          className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta));
    } else if (isInserting) {
      context.missing(_classNameMeta);
    }
    if (data.containsKey('json_params')) {
      context.handle(
          _jsonParamsMeta,
          jsonParams.isAcceptableOrUnknown(
              data['json_params']!, _jsonParamsMeta));
    } else if (isInserting) {
      context.missing(_jsonParamsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RemoteAction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemoteAction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}key'])!,
      className: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}class_name'])!,
      jsonParams: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}json_params'])!,
    );
  }

  @override
  $RemoteActionsTable createAlias(String alias) {
    return $RemoteActionsTable(attachedDatabase, alias);
  }
}

class RemoteAction extends DataClass implements Insertable<RemoteAction> {
  final int id;
  final DateTime createdAt;
  final int key;
  final String className;
  final String jsonParams;
  const RemoteAction(
      {required this.id,
      required this.createdAt,
      required this.key,
      required this.className,
      required this.jsonParams});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['key'] = Variable<int>(key);
    map['class_name'] = Variable<String>(className);
    map['json_params'] = Variable<String>(jsonParams);
    return map;
  }

  RemoteActionsCompanion toCompanion(bool nullToAbsent) {
    return RemoteActionsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      key: Value(key),
      className: Value(className),
      jsonParams: Value(jsonParams),
    );
  }

  factory RemoteAction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemoteAction(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      key: serializer.fromJson<int>(json['key']),
      className: serializer.fromJson<String>(json['className']),
      jsonParams: serializer.fromJson<String>(json['jsonParams']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'key': serializer.toJson<int>(key),
      'className': serializer.toJson<String>(className),
      'jsonParams': serializer.toJson<String>(jsonParams),
    };
  }

  RemoteAction copyWith(
          {int? id,
          DateTime? createdAt,
          int? key,
          String? className,
          String? jsonParams}) =>
      RemoteAction(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        key: key ?? this.key,
        className: className ?? this.className,
        jsonParams: jsonParams ?? this.jsonParams,
      );
  RemoteAction copyWithCompanion(RemoteActionsCompanion data) {
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
      (other is RemoteAction &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.key == this.key &&
          other.className == this.className &&
          other.jsonParams == this.jsonParams);
}

class RemoteActionsCompanion extends UpdateCompanion<RemoteAction> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<int> key;
  final Value<String> className;
  final Value<String> jsonParams;
  const RemoteActionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.key = const Value.absent(),
    this.className = const Value.absent(),
    this.jsonParams = const Value.absent(),
  });
  RemoteActionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required int key,
    required String className,
    required String jsonParams,
  })  : createdAt = Value(createdAt),
        key = Value(key),
        className = Value(className),
        jsonParams = Value(jsonParams);
  static Insertable<RemoteAction> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? key,
    Expression<String>? className,
    Expression<String>? jsonParams,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (key != null) 'key': key,
      if (className != null) 'class_name': className,
      if (jsonParams != null) 'json_params': jsonParams,
    });
  }

  RemoteActionsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? createdAt,
      Value<int>? key,
      Value<String>? className,
      Value<String>? jsonParams}) {
    return RemoteActionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      key: key ?? this.key,
      className: className ?? this.className,
      jsonParams: jsonParams ?? this.jsonParams,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (key.present) {
      map['key'] = Variable<int>(key.value);
    }
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (jsonParams.present) {
      map['json_params'] = Variable<String>(jsonParams.value);
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

abstract class _$DB extends GeneratedDatabase {
  _$DB(QueryExecutor e) : super(e);
  $DBManager get managers => $DBManager(this);
  late final $AppLogsTable appLogs = $AppLogsTable(this);
  late final $ArticlesTable articles = $ArticlesTable(this);
  late final $ArticleScrollPositionsTable articleScrollPositions =
      $ArticleScrollPositionsTable(this);
  late final $RemoteActionsTable remoteActions = $RemoteActionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [appLogs, articles, articleScrollPositions, remoteActions];
}

typedef $$AppLogsTableCreateCompanionBuilder = AppLogsCompanion Function({
  Value<int> id,
  required DateTime time,
  required String level,
  required String loggerName,
  required String message,
  Value<String?> error,
  Value<String?> stackTrace,
  required String logline,
});
typedef $$AppLogsTableUpdateCompanionBuilder = AppLogsCompanion Function({
  Value<int> id,
  Value<DateTime> time,
  Value<String> level,
  Value<String> loggerName,
  Value<String> message,
  Value<String?> error,
  Value<String?> stackTrace,
  Value<String> logline,
});

class $$AppLogsTableTableManager extends RootTableManager<
    _$DB,
    $AppLogsTable,
    AppLog,
    $$AppLogsTableFilterComposer,
    $$AppLogsTableOrderingComposer,
    $$AppLogsTableCreateCompanionBuilder,
    $$AppLogsTableUpdateCompanionBuilder> {
  $$AppLogsTableTableManager(_$DB db, $AppLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AppLogsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AppLogsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<String> loggerName = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<String?> stackTrace = const Value.absent(),
            Value<String> logline = const Value.absent(),
          }) =>
              AppLogsCompanion(
            id: id,
            time: time,
            level: level,
            loggerName: loggerName,
            message: message,
            error: error,
            stackTrace: stackTrace,
            logline: logline,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime time,
            required String level,
            required String loggerName,
            required String message,
            Value<String?> error = const Value.absent(),
            Value<String?> stackTrace = const Value.absent(),
            required String logline,
          }) =>
              AppLogsCompanion.insert(
            id: id,
            time: time,
            level: level,
            loggerName: loggerName,
            message: message,
            error: error,
            stackTrace: stackTrace,
            logline: logline,
          ),
        ));
}

class $$AppLogsTableFilterComposer extends FilterComposer<_$DB, $AppLogsTable> {
  $$AppLogsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get level => $state.composableBuilder(
      column: $state.table.level,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get loggerName => $state.composableBuilder(
      column: $state.table.loggerName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get error => $state.composableBuilder(
      column: $state.table.error,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get stackTrace => $state.composableBuilder(
      column: $state.table.stackTrace,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get logline => $state.composableBuilder(
      column: $state.table.logline,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AppLogsTableOrderingComposer
    extends OrderingComposer<_$DB, $AppLogsTable> {
  $$AppLogsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get level => $state.composableBuilder(
      column: $state.table.level,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get loggerName => $state.composableBuilder(
      column: $state.table.loggerName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get error => $state.composableBuilder(
      column: $state.table.error,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get stackTrace => $state.composableBuilder(
      column: $state.table.stackTrace,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get logline => $state.composableBuilder(
      column: $state.table.logline,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ArticlesTableCreateCompanionBuilder = ArticlesCompanion Function({
  required int id,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String title,
  Value<String?> domainName,
  required String url,
  Value<String?> content,
  Value<String?> language,
  required int readingTime,
  Value<String?> previewPicture,
  Value<DateTime?> archivedAt,
  Value<DateTime?> starredAt,
  required List<String> tags,
  Value<int> rowid,
});
typedef $$ArticlesTableUpdateCompanionBuilder = ArticlesCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> title,
  Value<String?> domainName,
  Value<String> url,
  Value<String?> content,
  Value<String?> language,
  Value<int> readingTime,
  Value<String?> previewPicture,
  Value<DateTime?> archivedAt,
  Value<DateTime?> starredAt,
  Value<List<String>> tags,
  Value<int> rowid,
});

class $$ArticlesTableTableManager extends RootTableManager<
    _$DB,
    $ArticlesTable,
    Article,
    $$ArticlesTableFilterComposer,
    $$ArticlesTableOrderingComposer,
    $$ArticlesTableCreateCompanionBuilder,
    $$ArticlesTableUpdateCompanionBuilder> {
  $$ArticlesTableTableManager(_$DB db, $ArticlesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ArticlesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ArticlesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> domainName = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<String?> content = const Value.absent(),
            Value<String?> language = const Value.absent(),
            Value<int> readingTime = const Value.absent(),
            Value<String?> previewPicture = const Value.absent(),
            Value<DateTime?> archivedAt = const Value.absent(),
            Value<DateTime?> starredAt = const Value.absent(),
            Value<List<String>> tags = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArticlesCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            title: title,
            domainName: domainName,
            url: url,
            content: content,
            language: language,
            readingTime: readingTime,
            previewPicture: previewPicture,
            archivedAt: archivedAt,
            starredAt: starredAt,
            tags: tags,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int id,
            required DateTime createdAt,
            required DateTime updatedAt,
            required String title,
            Value<String?> domainName = const Value.absent(),
            required String url,
            Value<String?> content = const Value.absent(),
            Value<String?> language = const Value.absent(),
            required int readingTime,
            Value<String?> previewPicture = const Value.absent(),
            Value<DateTime?> archivedAt = const Value.absent(),
            Value<DateTime?> starredAt = const Value.absent(),
            required List<String> tags,
            Value<int> rowid = const Value.absent(),
          }) =>
              ArticlesCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            title: title,
            domainName: domainName,
            url: url,
            content: content,
            language: language,
            readingTime: readingTime,
            previewPicture: previewPicture,
            archivedAt: archivedAt,
            starredAt: starredAt,
            tags: tags,
            rowid: rowid,
          ),
        ));
}

class $$ArticlesTableFilterComposer
    extends FilterComposer<_$DB, $ArticlesTable> {
  $$ArticlesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get domainName => $state.composableBuilder(
      column: $state.table.domainName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get readingTime => $state.composableBuilder(
      column: $state.table.readingTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get previewPicture => $state.composableBuilder(
      column: $state.table.previewPicture,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get archivedAt => $state.composableBuilder(
      column: $state.table.archivedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get starredAt => $state.composableBuilder(
      column: $state.table.starredAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String> get tags =>
      $state.composableBuilder(
          column: $state.table.tags,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$ArticlesTableOrderingComposer
    extends OrderingComposer<_$DB, $ArticlesTable> {
  $$ArticlesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get domainName => $state.composableBuilder(
      column: $state.table.domainName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get readingTime => $state.composableBuilder(
      column: $state.table.readingTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get previewPicture => $state.composableBuilder(
      column: $state.table.previewPicture,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get archivedAt => $state.composableBuilder(
      column: $state.table.archivedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get starredAt => $state.composableBuilder(
      column: $state.table.starredAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tags => $state.composableBuilder(
      column: $state.table.tags,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ArticleScrollPositionsTableCreateCompanionBuilder
    = ArticleScrollPositionsCompanion Function({
  required int id,
  required int readingTime,
  required double progress,
  Value<int> rowid,
});
typedef $$ArticleScrollPositionsTableUpdateCompanionBuilder
    = ArticleScrollPositionsCompanion Function({
  Value<int> id,
  Value<int> readingTime,
  Value<double> progress,
  Value<int> rowid,
});

class $$ArticleScrollPositionsTableTableManager extends RootTableManager<
    _$DB,
    $ArticleScrollPositionsTable,
    ArticleScrollPosition,
    $$ArticleScrollPositionsTableFilterComposer,
    $$ArticleScrollPositionsTableOrderingComposer,
    $$ArticleScrollPositionsTableCreateCompanionBuilder,
    $$ArticleScrollPositionsTableUpdateCompanionBuilder> {
  $$ArticleScrollPositionsTableTableManager(
      _$DB db, $ArticleScrollPositionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ArticleScrollPositionsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ArticleScrollPositionsTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> readingTime = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArticleScrollPositionsCompanion(
            id: id,
            readingTime: readingTime,
            progress: progress,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int id,
            required int readingTime,
            required double progress,
            Value<int> rowid = const Value.absent(),
          }) =>
              ArticleScrollPositionsCompanion.insert(
            id: id,
            readingTime: readingTime,
            progress: progress,
            rowid: rowid,
          ),
        ));
}

class $$ArticleScrollPositionsTableFilterComposer
    extends FilterComposer<_$DB, $ArticleScrollPositionsTable> {
  $$ArticleScrollPositionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get readingTime => $state.composableBuilder(
      column: $state.table.readingTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get progress => $state.composableBuilder(
      column: $state.table.progress,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ArticleScrollPositionsTableOrderingComposer
    extends OrderingComposer<_$DB, $ArticleScrollPositionsTable> {
  $$ArticleScrollPositionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get readingTime => $state.composableBuilder(
      column: $state.table.readingTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get progress => $state.composableBuilder(
      column: $state.table.progress,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$RemoteActionsTableCreateCompanionBuilder = RemoteActionsCompanion
    Function({
  Value<int> id,
  required DateTime createdAt,
  required int key,
  required String className,
  required String jsonParams,
});
typedef $$RemoteActionsTableUpdateCompanionBuilder = RemoteActionsCompanion
    Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<int> key,
  Value<String> className,
  Value<String> jsonParams,
});

class $$RemoteActionsTableTableManager extends RootTableManager<
    _$DB,
    $RemoteActionsTable,
    RemoteAction,
    $$RemoteActionsTableFilterComposer,
    $$RemoteActionsTableOrderingComposer,
    $$RemoteActionsTableCreateCompanionBuilder,
    $$RemoteActionsTableUpdateCompanionBuilder> {
  $$RemoteActionsTableTableManager(_$DB db, $RemoteActionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RemoteActionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RemoteActionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> key = const Value.absent(),
            Value<String> className = const Value.absent(),
            Value<String> jsonParams = const Value.absent(),
          }) =>
              RemoteActionsCompanion(
            id: id,
            createdAt: createdAt,
            key: key,
            className: className,
            jsonParams: jsonParams,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime createdAt,
            required int key,
            required String className,
            required String jsonParams,
          }) =>
              RemoteActionsCompanion.insert(
            id: id,
            createdAt: createdAt,
            key: key,
            className: className,
            jsonParams: jsonParams,
          ),
        ));
}

class $$RemoteActionsTableFilterComposer
    extends FilterComposer<_$DB, $RemoteActionsTable> {
  $$RemoteActionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get className => $state.composableBuilder(
      column: $state.table.className,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get jsonParams => $state.composableBuilder(
      column: $state.table.jsonParams,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$RemoteActionsTableOrderingComposer
    extends OrderingComposer<_$DB, $RemoteActionsTable> {
  $$RemoteActionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get className => $state.composableBuilder(
      column: $state.table.className,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get jsonParams => $state.composableBuilder(
      column: $state.table.jsonParams,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $DBManager {
  final _$DB _db;
  $DBManager(this._db);
  $$AppLogsTableTableManager get appLogs =>
      $$AppLogsTableTableManager(_db, _db.appLogs);
  $$ArticlesTableTableManager get articles =>
      $$ArticlesTableTableManager(_db, _db.articles);
  $$ArticleScrollPositionsTableTableManager get articleScrollPositions =>
      $$ArticleScrollPositionsTableTableManager(
          _db, _db.articleScrollPositions);
  $$RemoteActionsTableTableManager get remoteActions =>
      $$RemoteActionsTableTableManager(_db, _db.remoteActions);
}
