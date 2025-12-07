import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../domain/repositories.dart';

class HomeScreenController {
  const HomeScreenController({required QueryRepository queryRepository})
    : _queryRepository = queryRepository;

  final QueryRepository _queryRepository;

  Future<ItemCounter> getItemCounter() {
    final stream = _queryRepository.watchArticleIds();
    return ItemCounter.fromStream(stream);
  }
}

class ItemCounter extends ChangeNotifier implements ValueListenable<int> {
  ItemCounter(this._value, Stream<List<int>> stream) {
    _subscription = stream.listen((next) {
      _value = next;
      notifyListeners();
    });
  }

  late final StreamSubscription _subscription;
  List<int> _value;

  @override
  int get value => _value.length;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';

  int? getArticleId(int index) => _value.elementAtOrNull(index);

  int? getIndexForArticleId(int articleId) {
    final index = _value.indexOf(articleId);
    return index >= 0 ? index : null;
  }

  static Future<ItemCounter> fromStream(Stream<List<int>> stream) async {
    return ItemCounter(await stream.first, stream);
  }
}
