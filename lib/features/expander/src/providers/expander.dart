import 'package:flutter_riverpod/flutter_riverpod.dart';

class Expander extends StateNotifier<bool> {
  Expander({bool? expanded}) : super(expanded ?? false);

  bool get isExpanded => state;

  void toggle() {
    state = !state;
  }
}

final expanderProvider = StateNotifierProvider<Expander, bool>((ref) {
  return Expander();
});
