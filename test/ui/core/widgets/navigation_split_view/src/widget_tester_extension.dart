import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  void setSize(Size size) {
    view.physicalSize = size;
    view.devicePixelRatio = 1;
  }

  void setExpandedSize() => setSize(const Size(900, 600));

  void setMediumSize() => setSize(const Size(700, 600));
}
