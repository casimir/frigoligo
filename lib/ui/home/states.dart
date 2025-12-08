import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/query.dart';
import '../repository_providers.dart';

part '_g/states.g.dart';

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

  Set<int>? articleIds;
  final subscription = queryRepository.watchArticleIds().listen((result) {
    if (articleIds == null) {
      articleIds = result.toSet();
    } else if (articleIds != result.toSet()) {
      ref.invalidateSelf();
    }
  });
  ref.onDispose(() => subscription.cancel());

  final query = queryRepository.query;
  var availableDomains = query.domains.isNotEmpty ? query.domains : null;
  var availableTags = query.tags.isNotEmpty ? query.tags : null;

  late final int resultCount;
  await Future.wait([
    queryRepository.getResultCount().then((count) => resultCount = count),
    if (query.domains.isEmpty)
      queryRepository.listAvailableDomains().then(
        (domains) => availableDomains = domains,
      ),
    if (query.tags.isEmpty)
      queryRepository.listAvailableTags().then((tags) => availableTags = tags),
  ]);

  return QueryState(
    query: query,
    resultCount: resultCount,
    availableDomains: availableDomains!,
    availableTags: availableTags!,
  );
}
