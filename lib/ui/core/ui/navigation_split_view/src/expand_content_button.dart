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
    final localizations = MaterialLocalizations.of(context);
    // FIXME use a better icons
    final effectiveExpandIcon = expandIcon ?? Icons.expand_more;
    final effectiveCollapseIcon = collapseIcon ?? Icons.expand_less;

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
