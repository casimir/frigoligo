import 'package:flutter/material.dart';

/// The minimum width of the navigation pane in side-by-side layouts.
///
/// This is based on Material 3 navigation drawer width and Material 3
/// expression navigation rail expanded max width.
const double kNavigationPaneWidth = 360;
const double kNavigationPaneMaxWidth = 560;

/// An animated container that allows [NavigationSplitView]'s navigation pane
/// to slide in and out of view.
class AnimatedNavigationPaneSlider extends StatelessWidget {
  /// Creates a new animated navigation pane slider.
  const AnimatedNavigationPaneSlider({
    super.key,
    required this.isContentExpanded,
    required this.navigationPane,
  });

  final bool isContentExpanded;
  final Widget navigationPane;

  @override
  Widget build(BuildContext context) {
    final paneWidth = (MediaQuery.sizeOf(context).width * 0.35)
        .clamp(kNavigationPaneWidth, kNavigationPaneMaxWidth)
        .toDouble();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) => SizeTransition(
        axis: Axis.horizontal,
        sizeFactor: animation,
        child: child,
      ),
      child: isContentExpanded
          ? const SizedBox(key: ValueKey(0))
          : SizedBox(
              key: const ValueKey(1),
              width: paneWidth,
              child: navigationPane,
            ),
    );
  }
}
