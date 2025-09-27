import 'package:flutter/widgets.dart';

/// A window size class is an opinionated breakpoint, the window size at which a
/// layout needs to change to match available space, device conventions, and
/// ergonomics.
///
/// See the following documentation for more details:
/// - https://m3.material.io/foundations/layout/applying-layout/window-size-classes
/// - https://developer.android.com/develop/ui/compose/layouts/adaptive/use-window-size-classes
enum WindowSizeClass {
  /// - Phone in portrait
  compact,

  /// - Tablet in portrait
  /// - Foldable in portrait (unfolded)
  medium,

  /// - Phone in landscape
  /// - Tablet in landscape
  /// - Foldable in landscape (unfolded)
  /// - Desktop
  expanded,

  /// - Desktop
  large,

  /// - Desktop
  /// - Ultra-wide monitors
  xlarge;

  /// The upper bound of each window size class, except for [xlarge] which is
  /// unbounded.
  static const breakpoints = {
    WindowSizeClass.compact: 600,
    WindowSizeClass.medium: 840,
    WindowSizeClass.expanded: 1200,
    WindowSizeClass.large: 1600,
  };

  /// Returns the window size class corresponding to the given width.
  static WindowSizeClass fromWidth(double width) {
    for (final entry in breakpoints.entries) {
      if (width < entry.value) return entry.key;
    }
    return WindowSizeClass.xlarge;
  }
}

/// The root widget that provides the window query data to its descendants.
class WindowQuery extends StatelessWidget {
  /// Creates a new window query.
  const WindowQuery({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return WindowQueryData(
      sizeClass: WindowSizeClass.fromWidth(width),
      child: child,
    );
  }

  /// The data of the [WindowQuery] that encloses the given context, or null if
  /// none is found.
  static WindowQueryData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WindowQueryData>();
  }

  /// The data of the [WindowQuery] that encloses the given context.
  ///
  /// If no instance is found, this method will assert in debug mode and throw
  /// an exception in release mode.
  static WindowQueryData of(BuildContext context) {
    return maybeOf(context)!;
  }
}

/// The data of the parent [WindowQuery] widget.
class WindowQueryData extends InheritedWidget {
  /// Creates a new window query data.
  const WindowQueryData({
    super.key,
    required this.sizeClass,
    required super.child,
  });

  /// The window size class for the current window.
  final WindowSizeClass sizeClass;

  @override
  bool updateShouldNotify(WindowQueryData oldWidget) {
    return sizeClass != oldWidget.sizeClass;
  }
}
