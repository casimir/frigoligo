import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../db/daos/articles.dart';
import '../db/database.dart';
import '../db/models/article.drift.dart';

part 'query.g.dart';

// FIXME use sentinel values to avoid needing clear*() methods
class WQuery {
  WQuery({
    this.text,
    this.textMode,
    this.state,
    this.starred,
    this.tags,
    this.domains,
  });

  String? text;
  SearchTextMode? textMode;
  StateFilter? state;
  StarredFilter? starred;
  List<String>? tags;
  List<String>? domains;

  WQuery dup() => WQuery(
        text: text,
        textMode: textMode,
        state: state,
        starred: starred,
        tags: tags,
        domains: domains,
      );

  WQuery override(WQuery wq) => WQuery(
        text: wq.text ?? text,
        textMode: wq.textMode ?? textMode,
        state: wq.state ?? state,
        starred: wq.starred ?? starred,
        tags: wq.tags ?? tags,
        domains: wq.domains ?? domains,
      );
}

@Riverpod(keepAlive: true)
class Query extends _$Query {
  @override
  WQuery build() => WQuery(state: StateFilter.unread);

  void set(WQuery value) {
    state = value;
  }

  void overrideWith(WQuery value) {
    state = state.override(value);
  }

  void clearTags() {
    state = state.dup()..tags = null;
  }

  void clearText() {
    state = state.dup()..text = null;
  }

  void clearDomains() {
    state = state.dup()..domains = null;
  }
}

Expression<bool> _buildFilters(Articles t, WQuery wq) {
  final filters = <Expression<bool>>[];

  if (wq.state != null && wq.state != StateFilter.all) {
    filters.add(wq.state == StateFilter.archived
        ? t.archivedAt.isNotNull()
        : t.archivedAt.isNull());
  }

  if (wq.starred == StarredFilter.starred) {
    filters.add(t.starredAt.isNotNull());
  }

  if (wq.tags != null) {
    filters.add(Expression.or(wq.tags!.map((tag) => t.tags.contains(tag))));
  }

  if (wq.domains != null) {
    filters.add(Expression.or(
        wq.domains!.map((domain) => t.domainName.contains(domain))));
  }

  return Expression.and(filters);
}

Selectable<int> _buildIdsQuery(WQuery wq) {
  if (wq.text != null) {
    return DB().articlesDao.selectArticleIdsForText(
          wq.text!,
          mode: wq.textMode ?? SearchTextMode.all,
          where: (t) => _buildFilters(t, wq),
        );
  } else {
    final t1 = DB().articles;
    return (t1.selectOnly()
          ..addColumns([t1.id])
          ..where(_buildFilters(t1, wq))
          ..orderBy([OrderingTerm.desc(t1.createdAt)]))
        .map((row) => row.read(t1.id)!);
  }
}

class QueryState {
  const QueryState({
    required this.query,
    required this.ids,
  });

  final WQuery query;
  final List<int> ids;

  int get count => ids.length;
}

@riverpod
class QueryMeta extends _$QueryMeta {
  StreamSubscription? _watcher;

  @override
  Future<QueryState> build() async {
    final wq = ref.watch(queryProvider);
    final qs = QueryState(
      query: wq,
      ids: await _buildIdsQuery(wq).get(),
    );

    _watch();

    return qs;
  }

  void _watch() async {
    _watcher?.cancel();

    _watcher = _buildIdsQuery(ref.read(queryProvider)).watch().listen((ids) {
      final selectedIds =
          state.maybeWhen(orElse: () => null, data: (qs) => qs.ids);
      if (selectedIds != null && !listEquals(ids, selectedIds)) {
        ref.invalidateSelf();
      }
    });

    ref.onDispose(() => _watcher?.cancel());
  }
}
