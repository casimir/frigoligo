import 'package:flutter/foundation.dart';

import '../constants.dart';
import '../services/wallabag_storage.dart';

class QueryProvider extends ChangeNotifier {
  WQuery _query = WQuery(state: StateFilter.unread);
  WQuery get query => _query;
  set query(WQuery value) {
    _query = value;
    notifyListeners();
  }

  void overrideWith(WQuery value) {
    _query = _query.override(value);
    notifyListeners();
  }
}
