import 'package:flutter/material.dart';

// Implementation of https://m3.material.io/foundations/layout/applying-layout/window-size-classes

const double mediumBreakpoint = 600;
const double expandedBreakpoint = 840;

enum WindowClass {
  /// Phone in portrait.
  compact,

  /// Tablet in portrait.
  medium,

  /// Phone/tablet in landscape and Desktop.
  expanded;

  factory WindowClass.fromWidth(double width) {
    if (width < mediumBreakpoint) return WindowClass.compact;
    if (width < expandedBreakpoint) return WindowClass.expanded;
    return WindowClass.medium;
  }
}

class Layout {
  static WindowClass windowClass(BuildContext context) =>
      WindowClass.fromWidth(MediaQuery.of(context).size.width);

  static bool isCompact(BuildContext context) {
    return windowClass(context) == WindowClass.compact;
  }

  static bool isMedium(BuildContext context) {
    return windowClass(context) == WindowClass.medium;
  }

  static bool isExpanded(BuildContext context) {
    return windowClass(context) == WindowClass.expanded;
  }
}
