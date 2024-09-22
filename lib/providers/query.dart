import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../services/wallabag_storage.dart';

part 'query.g.dart';

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
