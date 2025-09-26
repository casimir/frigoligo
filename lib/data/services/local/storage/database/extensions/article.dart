import '../../../../../../constants.dart';
import '../models/article.drift.dart';

extension ArticleExtension on Article {
  StateFilter get stateValue =>
      archivedAt != null ? StateFilter.archived : StateFilter.unread;

  StarredFilter get starredValue =>
      starredAt != null ? StarredFilter.starred : StarredFilter.unstarred;
}
