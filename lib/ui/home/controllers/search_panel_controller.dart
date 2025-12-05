import '../../../domain/models/query.dart';
import '../../../domain/repositories.dart';

class SearchPanelController {
  const SearchPanelController({required QueryRepository queryRepository})
    : _queryRepository = queryRepository;

  final QueryRepository _queryRepository;

  void setText(String text) {
    _queryRepository.query = _queryRepository.query.copyWith(text: text);
  }

  void setTextMode(SearchTextMode textMode) {
    _queryRepository.query = _queryRepository.query.copyWith(
      textMode: textMode,
    );
  }

  void setState(StateFilter state) {
    _queryRepository.query = _queryRepository.query.copyWith(state: state);
  }

  void setOnlyStarred(bool onlyStarred) {
    _queryRepository.query = _queryRepository.query.copyWith(
      onlyStarred: onlyStarred,
    );
  }

  void setDomains(List<String> domains) {
    _queryRepository.query = _queryRepository.query.copyWith(domains: domains);
  }

  void setTags(List<String> tags) {
    _queryRepository.query = _queryRepository.query.copyWith(tags: tags);
  }
}
