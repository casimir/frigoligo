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
    final scope = NavigationSplitViewScope.maybeOf(context);

    if (scope == null) {
      return const BackButton();
    }

    final localizations = MaterialLocalizations.of(context);
    final isExpanded = scope.isContentExpanded;
    final effectiveExpandIcon = expandIcon ?? Icons.menu_open;
    final effectiveCollapseIcon = collapseIcon ?? Icons.menu;

    return IconButton(
      onPressed: () {
        NavigationSplitView.of(context).toggleContentExpansion();
      },
      tooltip:
          isExpanded
              ? localizations.expandedIconTapHint
              : localizations.collapsedIconTapHint,
      enableFeedback: true,
      icon: Icon(isExpanded ? effectiveCollapseIcon : effectiveExpandIcon),
    );
  }
}
