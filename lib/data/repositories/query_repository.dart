import 'dart:async';

import '../../domain/models/query.dart';
import '../../domain/repositories.dart';
import '../services/local/storage/storage_service.dart';

export '../../domain/models/query.dart';

class QueryRepositoryImpl extends QueryRepository {
  QueryRepositoryImpl({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;

  Query _query = const Query(state: StateFilter.unread);
  final StreamController<Query> _broadcaster = StreamController.broadcast();

  @override
  Query get query => _query;

  @override
  Stream<Query> get queryStream => _broadcaster.stream;

  @override
  set query(Query query) {
    if (_query == query) return;

    _query = query;
    _broadcaster.sink.add(query);
  }

  @override
  void dispose() {
    _broadcaster.close();
    super.dispose();
  }

  StorageQuery<int> _prepareResultCount() {
    return _localStorageService.articles.count(
      text: _query.text,
      textMode: _intoTextMode(_query.textMode),
      archived: _stateToBool(_query.state),
      onlyStarred: _query.onlyStarred,
      tags: _query.tags,
      domains: _query.domains,
    );
  }

  @override
  Future<int> getResultCount() {
    return _prepareResultCount().getSingle().then((value) => value!);
  }

  @override
  Stream<List<int>> watchArticleIds() {
    final controller = StreamController<List<int>>.broadcast();

    StreamSubscription setupListener() {
      return _localStorageService.articles
          .listIds(
            text: _query.text,
            textMode: _intoTextMode(_query.textMode),
            archived: _stateToBool(_query.state),
            onlyStarred: _query.onlyStarred,
            tags: _query.tags,
            domains: _query.domains,
          )
          .watch()
          .listen(controller.add, onError: controller.addError);
    }

    StreamSubscription subscription = setupListener();

    queryStream.listen((_) {
      subscription.cancel();
      subscription = setupListener();
    });

    return controller.stream;
  }

  @override
  Future<List<String>> listAvailableDomains() {
    return _localStorageService.articles.listDomains(
      text: _query.text,
      textMode: _intoTextMode(_query.textMode),
      archived: _stateToBool(_query.state),
      onlyStarred: _query.onlyStarred,
      tags: _query.tags,
    );
  }

  @override
  Future<List<String>> listAvailableTags() {
    return _localStorageService.articles.listTags(
      text: _query.text,
      textMode: _intoTextMode(_query.textMode),
      archived: _stateToBool(_query.state),
      onlyStarred: _query.onlyStarred,
      domains: _query.domains,
    );
  }
}

TextMode _intoTextMode(SearchTextMode? mode) => switch (mode) {
  SearchTextMode.all || null => TextMode.all,
  SearchTextMode.title => TextMode.title,
  SearchTextMode.content => TextMode.content,
};

bool? _stateToBool(StateFilter? state) => switch (state) {
  StateFilter.all || null => null,
  StateFilter.unread => false,
  StateFilter.archived => true,
};
