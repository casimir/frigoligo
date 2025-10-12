import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/article_data.dart';
import '../../domain/models/query.dart';
import '../repository_providers.dart';

part '_g/states.g.dart';

@riverpod
class ArticleState extends _$ArticleState {
  @override
  Future<ArticleData?> build(int articleId) async {
    final articleRepository = ref.watch(articleRepositoryProvider);
    final dataStream = articleRepository.watchData(articleId);

    final subscription = dataStream.listen((data) {
      state = AsyncValue.data(data);
    });
    ref.onDispose(() => subscription.cancel());

    return dataStream.first;
  }
}

@riverpod
Future<bool> articleExistsState(Ref ref, int articleId) {
  return ref.watch(
    articleStateProvider(articleId).selectAsync((data) => data != null),
  );
}

@riverpod
class ArticleContentState extends _$ArticleContentState {
  @override
  Future<String?> build(int articleId) async {
    final articleRepository = ref.watch(articleRepositoryProvider);
    final dataStream = articleRepository.watchContent(articleId);

    final subscription = dataStream.listen((data) {
      state = AsyncValue.data(data);
    });
    ref.onDispose(() => subscription.cancel());

    return dataStream.first;
  }
}

class QueryState with EquatableMixin {
  const QueryState({
    required this.query,
    required this.resultCount,
    required this.availableDomains,
    required this.availableTags,
  });

  final Query query;
  final int resultCount;
  final List<String> availableDomains;
  final List<String> availableTags;

  @override
  List<Object?> get props => [
    query,
    resultCount,
    availableDomains,
    availableTags,
  ];
}

@riverpod
Future<QueryState> queryState(Ref ref) async {
  final queryRepository = ref.watch(queryRepositoryProvider);

  final subscription = queryRepository.queryStream.listen((query) {
    ref.invalidateSelf();
  });
  ref.onDispose(() => subscription.cancel());

  late final int resultCount;
  late final List<String> availableDomains;
  late final List<String> availableTags;
  await Future.wait([
    queryRepository.getResultCount().then((count) => resultCount = count),
    queryRepository.listAvailableDomains().then(
      (domains) => availableDomains = domains,
    ),
    queryRepository.listAvailableTags().then((tags) => availableTags = tags),
  ]);

  return QueryState(
    query: queryRepository.query,
    resultCount: resultCount,
    availableDomains: availableDomains,
    availableTags: availableTags,
  );
}
