import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The type of app widget wrapping the given context.
/// This is detected based on the presence of a [MaterialApp] or [CupertinoApp]
/// in the context.
/// If neither is present, the app is assumed to be a [WidgetsApp].
enum AppType {
  cupertino,
  material,
  widgets;

  static AppType? _detectedType;

  /// Detects the type of app widget wrapping the given context.
  ///
  /// As the app widget is not likely to change during runtime, the result of
  /// this detection is cached and reused for the lifetime of the context.
  static AppType detect(BuildContext context) {
    if (_detectedType != null) return _detectedType!;

    // Detection is performed in order of likelihood for better performance.
    if (context.findAncestorWidgetOfExactType<MaterialApp>() != null) {
      _detectedType = AppType.material;
    } else if (context.findAncestorWidgetOfExactType<CupertinoApp>() != null) {
      _detectedType = AppType.cupertino;
    } else {
      _detectedType = AppType.widgets;
    }

    return _detectedType!;
  }

  @visibleForTesting
  static AppType detectWithCallback(
    BuildContext context,
    void Function(bool) onDetected,
  ) {
    onDetected(_detectedType == null);
    return detect(context);
  }

  /// Clears the cached detection result. It should never be needed in
  /// production code.
  ///
  /// This is primarily for testing purposes to reset state between tests.
  static void clearCache() {
    _detectedType = null;
  }
}

/// Create a page route that adapts to the app widget.
PageRoute<T> adaptivePageRouteBuilder<T>(
  BuildContext context,
  WidgetBuilder builder,
) {
  switch (AppType.detect(context)) {
    case AppType.material:
      return MaterialPageRoute<T>(builder: builder);
    case AppType.cupertino:
      return CupertinoPageRoute<T>(builder: builder);
    case AppType.widgets:
      return PageRouteBuilder<T>(
        pageBuilder:
            (context, animation, secondaryAnimation) => builder(context),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
  }
}
