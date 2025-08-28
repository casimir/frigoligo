import 'package:flutter/material.dart';

import 'navigation_split_view.dart';

/// A button that toggles the content pane expansion. It can be used for
/// example, in the content pane's app bar.
class ExpandContentButton extends StatelessWidget {
  /// Creates a new expand content button.
  const ExpandContentButton({super.key, this.expandIcon, this.collapseIcon});

  /// Icon to use for the expand action.
  final IconData? expandIcon;

  /// Icon to use for the collapse action.
  final IconData? collapseIcon;

  @override
  Widget build(BuildContext context) {
    final view = NavigationSplitView.maybeOf(context);

    if (view == null) {
      return const BackButton();
    }

    final isExpanded = view.isContentExpanded;
    // FIXME use a better icons
    final effectiveExpandIcon = expandIcon ?? Icons.expand_more;
    final effectiveCollapseIcon = collapseIcon ?? Icons.expand_less;

    return IconButton(
      onPressed: () {
        NavigationSplitView.of(context).toggleContentExpansion();
      },
      // TODO localize
      tooltip: isExpanded ? 'Collapse content' : 'Expand content',
      enableFeedback: true,
      icon: Icon(isExpanded ? effectiveCollapseIcon : effectiveExpandIcon),
    );
  }
}
