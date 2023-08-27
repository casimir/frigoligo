import 'package:flutter/foundation.dart';

class Expander extends ChangeNotifier {
  Expander({bool? expanded}) : _expanded = expanded ?? false;

  bool _expanded;

  bool get expanded => _expanded;
  set expanded(bool value) {
    if (_expanded != value) {
      _expanded = value;
      notifyListeners();
    }
  }

  void toggle() {
    expanded = !expanded;
    notifyListeners();
  }
}
