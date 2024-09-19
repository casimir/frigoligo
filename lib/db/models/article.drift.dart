// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/db/models/article.drift.dart' as i1;
import 'package:frigoligo/db/models/article.dart' as i2;
import 'package:frigoligo/db/converters/containers.dart' as i3;

class $ArticlesTable extends i2.Articles
    with i0.TableInfo<$ArticlesTable, i1.Article> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: false);
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>('created_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: true);
  static const i0.VerificationMeta _updatedAtMeta =
      const i0.VerificationMeta('updatedAt');
  @override
  late final i0.GeneratedColumn<DateTime> updatedAt =
      i0.GeneratedColumn<DateTime>('updated_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: true);
  static const i0.VerificationMeta _titleMeta =
      const i0.VerificationMeta('title');
  @override
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
      'title', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _domainNameMeta =
      const i0.VerificationMeta('domainName');
  @override
  late final i0.GeneratedColumn<String> domainName = i0.GeneratedColumn<String>(
      'domain_name', aliasedName, true,
      type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _urlMeta = const i0.VerificationMeta('url');
  @override
  late final i0.GeneratedColumn<String> url = i0.GeneratedColumn<String>(
      'url', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _contentMeta =
      const i0.VerificationMeta('content');
  @override
  late final i0.GeneratedColumn<String> content = i0.GeneratedColumn<String>(
      'content', aliasedName, true,
      type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _languageMeta =
      const i0.VerificationMeta('language');
  @override
  late final i0.GeneratedColumn<String> language = i0.GeneratedColumn<String>(
      'language', aliasedName, true,
      type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _readingTimeMeta =
      const i0.VerificationMeta('readingTime');
  @override
  late final i0.GeneratedColumn<int> readingTime = i0.GeneratedColumn<int>(
      'reading_time', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _previewPictureMeta =
      const i0.VerificationMeta('previewPicture');
  @override
  late final i0.GeneratedColumn<String> previewPicture =
      i0.GeneratedColumn<String>('preview_picture', aliasedName, true,
          type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _archivedAtMeta =
      const i0.VerificationMeta('archivedAt');
  @override
  late final i0.GeneratedColumn<DateTime> archivedAt =
      i0.GeneratedColumn<DateTime>('archived_at', aliasedName, true,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: false);
  static const i0.VerificationMeta _starredAtMeta =
      const i0.VerificationMeta('starredAt');
  @override
  late final i0.GeneratedColumn<DateTime> starredAt =
      i0.GeneratedColumn<DateTime>('starred_at', aliasedName, true,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: false);
  static const i0.VerificationMeta _tagsMeta =
      const i0.VerificationMeta('tags');
  @override
  late final i0.GeneratedColumnWithTypeConverter<List<String>, String> tags =
      i0.GeneratedColumn<String>('tags', aliasedName, false,
              type: i0.DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(i1.$ArticlesTable.$convertertags);
  @override
  List<i0.GeneratedColumn> get $columns => [
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
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Article> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
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
    context.handle(_tagsMeta, const i0.VerificationResult.success());
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Article(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      title: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}title'])!,
      domainName: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}domain_name']),
      url: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}url'])!,
      content: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}content']),
      language: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}language']),
      readingTime: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}reading_time'])!,
      previewPicture: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}preview_picture']),
      archivedAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}archived_at']),
      starredAt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.dateTime, data['${effectivePrefix}starred_at']),
      tags: i1.$ArticlesTable.$convertertags.fromSql(attachedDatabase
          .typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}tags'])!),
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }

  static i0.TypeConverter<List<String>, String> $convertertags =
      const i3.StringListConverter();
}

class Article extends i0.DataClass implements i0.Insertable<i1.Article> {
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
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    map['updated_at'] = i0.Variable<DateTime>(updatedAt);
    map['title'] = i0.Variable<String>(title);
    if (!nullToAbsent || domainName != null) {
      map['domain_name'] = i0.Variable<String>(domainName);
    }
    map['url'] = i0.Variable<String>(url);
    if (!nullToAbsent || content != null) {
      map['content'] = i0.Variable<String>(content);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = i0.Variable<String>(language);
    }
    map['reading_time'] = i0.Variable<int>(readingTime);
    if (!nullToAbsent || previewPicture != null) {
      map['preview_picture'] = i0.Variable<String>(previewPicture);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = i0.Variable<DateTime>(archivedAt);
    }
    if (!nullToAbsent || starredAt != null) {
      map['starred_at'] = i0.Variable<DateTime>(starredAt);
    }
    {
      map['tags'] =
          i0.Variable<String>(i1.$ArticlesTable.$convertertags.toSql(tags));
    }
    return map;
  }

  i1.ArticlesCompanion toCompanion(bool nullToAbsent) {
    return i1.ArticlesCompanion(
      id: i0.Value(id),
      createdAt: i0.Value(createdAt),
      updatedAt: i0.Value(updatedAt),
      title: i0.Value(title),
      domainName: domainName == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(domainName),
      url: i0.Value(url),
      content: content == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(content),
      language: language == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(language),
      readingTime: i0.Value(readingTime),
      previewPicture: previewPicture == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(previewPicture),
      archivedAt: archivedAt == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(archivedAt),
      starredAt: starredAt == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(starredAt),
      tags: i0.Value(tags),
    );
  }

  factory Article.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
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

  i1.Article copyWith(
          {int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? title,
          i0.Value<String?> domainName = const i0.Value.absent(),
          String? url,
          i0.Value<String?> content = const i0.Value.absent(),
          i0.Value<String?> language = const i0.Value.absent(),
          int? readingTime,
          i0.Value<String?> previewPicture = const i0.Value.absent(),
          i0.Value<DateTime?> archivedAt = const i0.Value.absent(),
          i0.Value<DateTime?> starredAt = const i0.Value.absent(),
          List<String>? tags}) =>
      i1.Article(
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
  Article copyWithCompanion(i1.ArticlesCompanion data) {
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
      (other is i1.Article &&
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

class ArticlesCompanion extends i0.UpdateCompanion<i1.Article> {
  final i0.Value<int> id;
  final i0.Value<DateTime> createdAt;
  final i0.Value<DateTime> updatedAt;
  final i0.Value<String> title;
  final i0.Value<String?> domainName;
  final i0.Value<String> url;
  final i0.Value<String?> content;
  final i0.Value<String?> language;
  final i0.Value<int> readingTime;
  final i0.Value<String?> previewPicture;
  final i0.Value<DateTime?> archivedAt;
  final i0.Value<DateTime?> starredAt;
  final i0.Value<List<String>> tags;
  const ArticlesCompanion({
    this.id = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.updatedAt = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.domainName = const i0.Value.absent(),
    this.url = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.language = const i0.Value.absent(),
    this.readingTime = const i0.Value.absent(),
    this.previewPicture = const i0.Value.absent(),
    this.archivedAt = const i0.Value.absent(),
    this.starredAt = const i0.Value.absent(),
    this.tags = const i0.Value.absent(),
  });
  ArticlesCompanion.insert({
    this.id = const i0.Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String title,
    this.domainName = const i0.Value.absent(),
    required String url,
    this.content = const i0.Value.absent(),
    this.language = const i0.Value.absent(),
    required int readingTime,
    this.previewPicture = const i0.Value.absent(),
    this.archivedAt = const i0.Value.absent(),
    this.starredAt = const i0.Value.absent(),
    required List<String> tags,
  })  : createdAt = i0.Value(createdAt),
        updatedAt = i0.Value(updatedAt),
        title = i0.Value(title),
        url = i0.Value(url),
        readingTime = i0.Value(readingTime),
        tags = i0.Value(tags);
  static i0.Insertable<i1.Article> custom({
    i0.Expression<int>? id,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<DateTime>? updatedAt,
    i0.Expression<String>? title,
    i0.Expression<String>? domainName,
    i0.Expression<String>? url,
    i0.Expression<String>? content,
    i0.Expression<String>? language,
    i0.Expression<int>? readingTime,
    i0.Expression<String>? previewPicture,
    i0.Expression<DateTime>? archivedAt,
    i0.Expression<DateTime>? starredAt,
    i0.Expression<String>? tags,
  }) {
    return i0.RawValuesInsertable({
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
    });
  }

  i1.ArticlesCompanion copyWith(
      {i0.Value<int>? id,
      i0.Value<DateTime>? createdAt,
      i0.Value<DateTime>? updatedAt,
      i0.Value<String>? title,
      i0.Value<String?>? domainName,
      i0.Value<String>? url,
      i0.Value<String?>? content,
      i0.Value<String?>? language,
      i0.Value<int>? readingTime,
      i0.Value<String?>? previewPicture,
      i0.Value<DateTime?>? archivedAt,
      i0.Value<DateTime?>? starredAt,
      i0.Value<List<String>>? tags}) {
    return i1.ArticlesCompanion(
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
    if (updatedAt.present) {
      map['updated_at'] = i0.Variable<DateTime>(updatedAt.value);
    }
    if (title.present) {
      map['title'] = i0.Variable<String>(title.value);
    }
    if (domainName.present) {
      map['domain_name'] = i0.Variable<String>(domainName.value);
    }
    if (url.present) {
      map['url'] = i0.Variable<String>(url.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<String>(content.value);
    }
    if (language.present) {
      map['language'] = i0.Variable<String>(language.value);
    }
    if (readingTime.present) {
      map['reading_time'] = i0.Variable<int>(readingTime.value);
    }
    if (previewPicture.present) {
      map['preview_picture'] = i0.Variable<String>(previewPicture.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = i0.Variable<DateTime>(archivedAt.value);
    }
    if (starredAt.present) {
      map['starred_at'] = i0.Variable<DateTime>(starredAt.value);
    }
    if (tags.present) {
      map['tags'] = i0.Variable<String>(
          i1.$ArticlesTable.$convertertags.toSql(tags.value));
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
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

typedef $$ArticlesTableCreateCompanionBuilder = i1.ArticlesCompanion Function({
  i0.Value<int> id,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String title,
  i0.Value<String?> domainName,
  required String url,
  i0.Value<String?> content,
  i0.Value<String?> language,
  required int readingTime,
  i0.Value<String?> previewPicture,
  i0.Value<DateTime?> archivedAt,
  i0.Value<DateTime?> starredAt,
  required List<String> tags,
});
typedef $$ArticlesTableUpdateCompanionBuilder = i1.ArticlesCompanion Function({
  i0.Value<int> id,
  i0.Value<DateTime> createdAt,
  i0.Value<DateTime> updatedAt,
  i0.Value<String> title,
  i0.Value<String?> domainName,
  i0.Value<String> url,
  i0.Value<String?> content,
  i0.Value<String?> language,
  i0.Value<int> readingTime,
  i0.Value<String?> previewPicture,
  i0.Value<DateTime?> archivedAt,
  i0.Value<DateTime?> starredAt,
  i0.Value<List<String>> tags,
});

class $$ArticlesTableFilterComposer
    extends i0.FilterComposer<i0.GeneratedDatabase, i1.$ArticlesTable> {
  $$ArticlesTableFilterComposer(super.$state);
  i0.ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get domainName => $state.composableBuilder(
      column: $state.table.domainName,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<int> get readingTime => $state.composableBuilder(
      column: $state.table.readingTime,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<String> get previewPicture => $state.composableBuilder(
      column: $state.table.previewPicture,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<DateTime> get archivedAt => $state.composableBuilder(
      column: $state.table.archivedAt,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<DateTime> get starredAt => $state.composableBuilder(
      column: $state.table.starredAt,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get tags => $state.composableBuilder(
          column: $state.table.tags,
          builder: (column, joinBuilders) => i0.ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$ArticlesTableOrderingComposer
    extends i0.OrderingComposer<i0.GeneratedDatabase, i1.$ArticlesTable> {
  $$ArticlesTableOrderingComposer(super.$state);
  i0.ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get domainName => $state.composableBuilder(
      column: $state.table.domainName,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<int> get readingTime => $state.composableBuilder(
      column: $state.table.readingTime,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get previewPicture => $state.composableBuilder(
      column: $state.table.previewPicture,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<DateTime> get archivedAt => $state.composableBuilder(
      column: $state.table.archivedAt,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<DateTime> get starredAt => $state.composableBuilder(
      column: $state.table.starredAt,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<String> get tags => $state.composableBuilder(
      column: $state.table.tags,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$ArticlesTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$ArticlesTable,
    i1.Article,
    i1.$$ArticlesTableFilterComposer,
    i1.$$ArticlesTableOrderingComposer,
    $$ArticlesTableCreateCompanionBuilder,
    $$ArticlesTableUpdateCompanionBuilder,
    (
      i1.Article,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$ArticlesTable, i1.Article>
    ),
    i1.Article,
    i0.PrefetchHooks Function()> {
  $$ArticlesTableTableManager(i0.GeneratedDatabase db, i1.$ArticlesTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              i1.$$ArticlesTableFilterComposer(i0.ComposerState(db, table)),
          orderingComposer:
              i1.$$ArticlesTableOrderingComposer(i0.ComposerState(db, table)),
          updateCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<DateTime> updatedAt = const i0.Value.absent(),
            i0.Value<String> title = const i0.Value.absent(),
            i0.Value<String?> domainName = const i0.Value.absent(),
            i0.Value<String> url = const i0.Value.absent(),
            i0.Value<String?> content = const i0.Value.absent(),
            i0.Value<String?> language = const i0.Value.absent(),
            i0.Value<int> readingTime = const i0.Value.absent(),
            i0.Value<String?> previewPicture = const i0.Value.absent(),
            i0.Value<DateTime?> archivedAt = const i0.Value.absent(),
            i0.Value<DateTime?> starredAt = const i0.Value.absent(),
            i0.Value<List<String>> tags = const i0.Value.absent(),
          }) =>
              i1.ArticlesCompanion(
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
          ),
          createCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            required String title,
            i0.Value<String?> domainName = const i0.Value.absent(),
            required String url,
            i0.Value<String?> content = const i0.Value.absent(),
            i0.Value<String?> language = const i0.Value.absent(),
            required int readingTime,
            i0.Value<String?> previewPicture = const i0.Value.absent(),
            i0.Value<DateTime?> archivedAt = const i0.Value.absent(),
            i0.Value<DateTime?> starredAt = const i0.Value.absent(),
            required List<String> tags,
          }) =>
              i1.ArticlesCompanion.insert(
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
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArticlesTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.$ArticlesTable,
    i1.Article,
    i1.$$ArticlesTableFilterComposer,
    i1.$$ArticlesTableOrderingComposer,
    $$ArticlesTableCreateCompanionBuilder,
    $$ArticlesTableUpdateCompanionBuilder,
    (
      i1.Article,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$ArticlesTable, i1.Article>
    ),
    i1.Article,
    i0.PrefetchHooks Function()>;

class $ArticleScrollPositionsTable extends i2.ArticleScrollPositions
    with i0.TableInfo<$ArticleScrollPositionsTable, i1.ArticleScrollPosition> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticleScrollPositionsTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: false);
  static const i0.VerificationMeta _readingTimeMeta =
      const i0.VerificationMeta('readingTime');
  @override
  late final i0.GeneratedColumn<int> readingTime = i0.GeneratedColumn<int>(
      'reading_time', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _progressMeta =
      const i0.VerificationMeta('progress');
  @override
  late final i0.GeneratedColumn<double> progress = i0.GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: i0.DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<i0.GeneratedColumn> get $columns => [id, readingTime, progress];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'article_scroll_positions';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.ArticleScrollPosition> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.ArticleScrollPosition map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ArticleScrollPosition(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}id'])!,
      readingTime: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}reading_time'])!,
      progress: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.double, data['${effectivePrefix}progress'])!,
    );
  }

  @override
  $ArticleScrollPositionsTable createAlias(String alias) {
    return $ArticleScrollPositionsTable(attachedDatabase, alias);
  }
}

class ArticleScrollPosition extends i0.DataClass
    implements i0.Insertable<i1.ArticleScrollPosition> {
  final int id;
  final int readingTime;
  final double progress;
  const ArticleScrollPosition(
      {required this.id, required this.readingTime, required this.progress});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['reading_time'] = i0.Variable<int>(readingTime);
    map['progress'] = i0.Variable<double>(progress);
    return map;
  }

  i1.ArticleScrollPositionsCompanion toCompanion(bool nullToAbsent) {
    return i1.ArticleScrollPositionsCompanion(
      id: i0.Value(id),
      readingTime: i0.Value(readingTime),
      progress: i0.Value(progress),
    );
  }

  factory ArticleScrollPosition.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ArticleScrollPosition(
      id: serializer.fromJson<int>(json['id']),
      readingTime: serializer.fromJson<int>(json['readingTime']),
      progress: serializer.fromJson<double>(json['progress']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'readingTime': serializer.toJson<int>(readingTime),
      'progress': serializer.toJson<double>(progress),
    };
  }

  i1.ArticleScrollPosition copyWith(
          {int? id, int? readingTime, double? progress}) =>
      i1.ArticleScrollPosition(
        id: id ?? this.id,
        readingTime: readingTime ?? this.readingTime,
        progress: progress ?? this.progress,
      );
  ArticleScrollPosition copyWithCompanion(
      i1.ArticleScrollPositionsCompanion data) {
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
      (other is i1.ArticleScrollPosition &&
          other.id == this.id &&
          other.readingTime == this.readingTime &&
          other.progress == this.progress);
}

class ArticleScrollPositionsCompanion
    extends i0.UpdateCompanion<i1.ArticleScrollPosition> {
  final i0.Value<int> id;
  final i0.Value<int> readingTime;
  final i0.Value<double> progress;
  const ArticleScrollPositionsCompanion({
    this.id = const i0.Value.absent(),
    this.readingTime = const i0.Value.absent(),
    this.progress = const i0.Value.absent(),
  });
  ArticleScrollPositionsCompanion.insert({
    this.id = const i0.Value.absent(),
    required int readingTime,
    required double progress,
  })  : readingTime = i0.Value(readingTime),
        progress = i0.Value(progress);
  static i0.Insertable<i1.ArticleScrollPosition> custom({
    i0.Expression<int>? id,
    i0.Expression<int>? readingTime,
    i0.Expression<double>? progress,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (readingTime != null) 'reading_time': readingTime,
      if (progress != null) 'progress': progress,
    });
  }

  i1.ArticleScrollPositionsCompanion copyWith(
      {i0.Value<int>? id,
      i0.Value<int>? readingTime,
      i0.Value<double>? progress}) {
    return i1.ArticleScrollPositionsCompanion(
      id: id ?? this.id,
      readingTime: readingTime ?? this.readingTime,
      progress: progress ?? this.progress,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (readingTime.present) {
      map['reading_time'] = i0.Variable<int>(readingTime.value);
    }
    if (progress.present) {
      map['progress'] = i0.Variable<double>(progress.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleScrollPositionsCompanion(')
          ..write('id: $id, ')
          ..write('readingTime: $readingTime, ')
          ..write('progress: $progress')
          ..write(')'))
        .toString();
  }
}

typedef $$ArticleScrollPositionsTableCreateCompanionBuilder
    = i1.ArticleScrollPositionsCompanion Function({
  i0.Value<int> id,
  required int readingTime,
  required double progress,
});
typedef $$ArticleScrollPositionsTableUpdateCompanionBuilder
    = i1.ArticleScrollPositionsCompanion Function({
  i0.Value<int> id,
  i0.Value<int> readingTime,
  i0.Value<double> progress,
});

class $$ArticleScrollPositionsTableFilterComposer extends i0
    .FilterComposer<i0.GeneratedDatabase, i1.$ArticleScrollPositionsTable> {
  $$ArticleScrollPositionsTableFilterComposer(super.$state);
  i0.ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<int> get readingTime => $state.composableBuilder(
      column: $state.table.readingTime,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));

  i0.ColumnFilters<double> get progress => $state.composableBuilder(
      column: $state.table.progress,
      builder: (column, joinBuilders) =>
          i0.ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ArticleScrollPositionsTableOrderingComposer extends i0
    .OrderingComposer<i0.GeneratedDatabase, i1.$ArticleScrollPositionsTable> {
  $$ArticleScrollPositionsTableOrderingComposer(super.$state);
  i0.ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<int> get readingTime => $state.composableBuilder(
      column: $state.table.readingTime,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));

  i0.ColumnOrderings<double> get progress => $state.composableBuilder(
      column: $state.table.progress,
      builder: (column, joinBuilders) =>
          i0.ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$ArticleScrollPositionsTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$ArticleScrollPositionsTable,
    i1.ArticleScrollPosition,
    i1.$$ArticleScrollPositionsTableFilterComposer,
    i1.$$ArticleScrollPositionsTableOrderingComposer,
    $$ArticleScrollPositionsTableCreateCompanionBuilder,
    $$ArticleScrollPositionsTableUpdateCompanionBuilder,
    (
      i1.ArticleScrollPosition,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$ArticleScrollPositionsTable,
          i1.ArticleScrollPosition>
    ),
    i1.ArticleScrollPosition,
    i0.PrefetchHooks Function()> {
  $$ArticleScrollPositionsTableTableManager(
      i0.GeneratedDatabase db, i1.$ArticleScrollPositionsTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          filteringComposer: i1.$$ArticleScrollPositionsTableFilterComposer(
              i0.ComposerState(db, table)),
          orderingComposer: i1.$$ArticleScrollPositionsTableOrderingComposer(
              i0.ComposerState(db, table)),
          updateCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            i0.Value<int> readingTime = const i0.Value.absent(),
            i0.Value<double> progress = const i0.Value.absent(),
          }) =>
              i1.ArticleScrollPositionsCompanion(
            id: id,
            readingTime: readingTime,
            progress: progress,
          ),
          createCompanionCallback: ({
            i0.Value<int> id = const i0.Value.absent(),
            required int readingTime,
            required double progress,
          }) =>
              i1.ArticleScrollPositionsCompanion.insert(
            id: id,
            readingTime: readingTime,
            progress: progress,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArticleScrollPositionsTableProcessedTableManager
    = i0.ProcessedTableManager<
        i0.GeneratedDatabase,
        i1.$ArticleScrollPositionsTable,
        i1.ArticleScrollPosition,
        i1.$$ArticleScrollPositionsTableFilterComposer,
        i1.$$ArticleScrollPositionsTableOrderingComposer,
        $$ArticleScrollPositionsTableCreateCompanionBuilder,
        $$ArticleScrollPositionsTableUpdateCompanionBuilder,
        (
          i1.ArticleScrollPosition,
          i0.BaseReferences<i0.GeneratedDatabase,
              i1.$ArticleScrollPositionsTable, i1.ArticleScrollPosition>
        ),
        i1.ArticleScrollPosition,
        i0.PrefetchHooks Function()>;
