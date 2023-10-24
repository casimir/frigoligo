import 'dart:collection';

import 'package:flutter/widgets.dart';

enum SyncAction {
  refresh,
}

class RemoteSync with ChangeNotifier {
  final ListQueue<SyncAction> _queue = ListQueue();
  final Map<SyncAction, double?> _progress = {};

  bool get isWorking => _queue.isNotEmpty;
  double? get progressValue {
    if (_progress.isEmpty) return null;

    var sum = 0.0;
    for (final value in _progress.values) {
      if (value == null) return null;
      sum += value;
    }
    return sum / _progress.length;
  }

  void setProgress(SyncAction action, double? value) {
    if (!_queue.contains(action)) _queue.add(action);
    _progress[action] = value;
    notifyListeners();
  }

  void finish(SyncAction action) {
    _queue.remove(action);
    _progress.remove(action);
    notifyListeners();
  }

  static final _instance = RemoteSync();
  static RemoteSync get instance => _instance;
}
