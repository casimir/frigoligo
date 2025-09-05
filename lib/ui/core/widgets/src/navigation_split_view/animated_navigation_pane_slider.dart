import 'package:flutter/material.dart';

/// The width of the navigation pane when the layout is side by side.
///
/// This is based on Material 3 navigation drawer width and Material 3
/// expression navigation rail expanded max width.
const double kNavigationPaneWidth = 360;

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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      transitionBuilder:
          (child, animation) => SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: animation,
            child: child,
          ),
      child:
          isContentExpanded
              ? const SizedBox(key: ValueKey(0))
              : SizedBox(
                key: const ValueKey(1),
                width: kNavigationPaneWidth,
                child: navigationPane,
              ),
    );
  }
}
