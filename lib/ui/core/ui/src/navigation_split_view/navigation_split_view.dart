import 'package:cadanse/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LogicalKeyboardKey;

import '../../adaptive.dart';
import 'animated_navigation_pane_slider.dart';

/// A view that present a navigation pane and a content pane. The layout depends
/// on the available width. It is inspired by [Scaffold] for the architecture
/// and SwiftUI's NavigationSplitView for the adaptive layout.
///
/// On large width, panes are shown side by side. Choosing an item from the
/// the navigation pane updates the content pane. The content pane can be
/// expanded to take the full width of the view, hiding the navigation pane.
///
/// On small width, the navigation is shown full width. Choosing an item
/// from the navigation pane pushes the content pane to the navigation stack.
///
/// By default, keyboard shortcuts can be used to expand the content pane with
/// `F` and to collapse it with `Escape`. On small width, `Escape` will pop the
/// content pane from the navigation stack.
///
/// [NavigationSplitView] uses components that require a [Material] ancestor.
/// Such ancestor is typically provided by [Scaffold].
class NavigationSplitView extends StatefulWidget {
  /// Creates a new navigation view.
  const NavigationSplitView({
    super.key,
    required this.itemCount,
    required this.navigationItemBuilder,
    this.navigationContainerBuilder,
    this.navigationPlaceholder,
    required this.contentBuilder,
    this.contentPlaceholder,
    this.initialIndex,
    this.enableShortcuts = true,
    this.highlightColor,
    this.restorationId,
  }) : _layout = null;

  /// Total count of items in the navigation pane.
  final int itemCount;

  /// Builder for the navigation pane items.
  final NullableIndexedWidgetBuilder navigationItemBuilder;

  /// Builder for the navigation pane container. Can be used to wrap the
  /// navigation list in a custom container.
  final NavigationContainerBuilder? navigationContainerBuilder;

  /// Placeholder for the navigation pane when no items are provided.
  final Widget? navigationPlaceholder;

  /// Builder for the content pane.
  final IndexedWidgetBuilder contentBuilder;

  /// Placeholder for the content pane when no item is selected.
  final Widget? contentPlaceholder;

  /// Initial selected index. When not provided, the first item is selected.
  final int? initialIndex;

  /// Feature flag to enable keyboard shortcuts.
  final bool enableShortcuts;

  /// Color to use to highlight the selected item in the navigation pane.
  final Color? highlightColor;

  /// Restoration ID to save and restore the state of the [NavigationSplitView].
  ///
  /// If it is non-null, the [NavigationSplitView] will persist and restore
  /// whether the content was expanded or not.
  final String? restorationId;

  final _Layout? _layout;

  @override
  State<NavigationSplitView> createState() => NavigationSplitViewState();

  /// The closest instance of [NavigationSplitViewState] that encloses the given
  /// context, or null if none is found.
  ///
  /// When looking for the content expansion state without the intent of mutating
  /// it, prefer [NavigationSplitViewScope.maybeOf] instead.
  static NavigationSplitViewState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<NavigationSplitViewState>();
  }

  /// The closest instance of [NavigationSplitViewState] that encloses the
  /// given context.
  ///
  /// If no instance is found, this method will assert in debug mode and throw
  /// an exception in release mode.
  static NavigationSplitViewState of(BuildContext context) {
    return maybeOf(context)!;
  }
}

class NavigationSplitViewState extends State<NavigationSplitView>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  @protected
  @override
  void restoreState(RestorationBucket? state, bool initialRestore) {
    registerForRestoration(_isContentExpanded, 'is_content_expanded');
  }

  int? _selectedIndex;
  final RestorableBool _isContentExpanded = RestorableBool(false);

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex;
    if (_selectedIndex == null && widget.itemCount > 0) {
      _selectedIndex = 0;
    }

    if (widget.initialIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectIndex(widget.initialIndex);
      });
    }
  }

  _Layout get _effectiveLayout =>
      widget._layout ??
      (Layout.isExpanded(context) ? _Layout.sideBySide : _Layout.full);

  /// Change the selected index.
  void selectIndex(int? index) {
    if (index != null) {
      assert(
        index >= 0 && index < widget.itemCount,
        'index must be between 0 and ${widget.itemCount - 1} but got $index',
      );
    }

    if (_effectiveLayout == _Layout.sideBySide) {
      setState(() {
        _selectedIndex = index;
      });
    }

    if (_effectiveLayout == _Layout.full && index != null && mounted) {
      Navigator.of(context).push(
        adaptivePageRouteBuilder(
          context,
          (context) => _buildContentPane(index, widget.enableShortcuts),
        ),
      );
    }
  }

  /// Whether the content pane is in expanded state.
  bool get isContentExpanded => _isContentExpanded.value;

  /// Toggle the content pane expansion state.
  void toggleContentExpansion() => setState(() {
    _isContentExpanded.value = !_isContentExpanded.value;
  });

  /// Expand the content pane.
  void expandContent() {
    if (!isContentExpanded) {
      setState(() {
        _isContentExpanded.value = true;
      });
    }
  }

  /// Collapse the content pane.
  void collapseContent() {
    if (isContentExpanded) {
      setState(() {
        _isContentExpanded.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_effectiveLayout == _Layout.full) {
      return _buildNavigationPane();
    }

    final content =
        _selectedIndex == null
            ? widget.contentPlaceholder ?? _buildDefaultContentPlaceholder()
            : _buildContentPane(_selectedIndex!, false);

    Widget view;

    view = Row(
      children: [
        AnimatedNavigationPaneSlider(
          isContentExpanded: isContentExpanded,
          navigationPane: _buildNavigationPane(),
        ),
        if (!isContentExpanded) const VerticalDivider(width: 1),
        Expanded(child: content),
      ],
    );

    if (widget.enableShortcuts) {
      view = CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): collapseContent,
          const SingleActivator(LogicalKeyboardKey.keyF): expandContent,
        },
        child: Focus(autofocus: true, child: view),
      );
    }

    return NavigationSplitViewScope(
      isContentExpanded: isContentExpanded,
      child: view,
    );
  }

  Widget _buildNavigationPane() {
    if (widget.itemCount == 0) {
      return widget.navigationPlaceholder ??
          _buildDefaultNavigationPlaceholder();
    }

    final navigation = ListView.builder(
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        final isSelected = _selectedIndex == index;
        final highlightColor =
            isSelected && _effectiveLayout == _Layout.sideBySide
                ? widget.highlightColor ?? Theme.of(context).highlightColor
                : null;
        return InkWell(
          splashFactory: adaptiveSplashFactory(context),
          onTap: () => selectIndex(index),
          child: Semantics(
            button: true,
            selected: isSelected,
            child: Ink(
              color: highlightColor,
              child: widget.navigationItemBuilder(context, index),
            ),
          ),
        );
      },
    );

    if (widget.navigationContainerBuilder != null) {
      return widget.navigationContainerBuilder!(
        context,
        _selectedIndex!,
        navigation,
      );
    } else {
      return navigation;
    }
  }

  Widget _buildDefaultNavigationPlaceholder() {
    // TODO set up a better placeholder
    return const Center(child: Text('No items'));
  }

  Widget _buildContentPane(int index, bool withShortcuts) {
    final content = widget.contentBuilder(context, index);

    if (withShortcuts) {
      return CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () {
            final navigator = Navigator.of(context);
            if (mounted && navigator.canPop()) {
              navigator.pop();
            }
          },
        },
        child: Focus(autofocus: true, child: content),
      );
    } else {
      return content;
    }
  }

  Widget _buildDefaultContentPlaceholder() {
    // TODO set up a better placeholder
    return const Center(child: Text('Select an item'));
  }
}

enum _Layout { sideBySide, full }

/// A builder for the navigation pane container.
typedef NavigationContainerBuilder =
    Widget Function(BuildContext context, int selectedIndex, Widget child);

/// A scope that is inserted by [NavigationSplitView] and contains information
/// about its state.
///
/// Mainly used by [ExpandContentButton] to adapt to adapt its icon and tooltip
/// to the ambient content expansion state.
class NavigationSplitViewScope extends InheritedWidget {
  /// Creates a new navigation split view scope.
  const NavigationSplitViewScope({
    super.key,
    required super.child,
    required this.isContentExpanded,
  });

  /// Whether the content pane is expanded.
  final bool isContentExpanded;

  @override
  bool updateShouldNotify(NavigationSplitViewScope oldWidget) {
    return oldWidget.isContentExpanded != isContentExpanded;
  }

  /// The closest instance of [NavigationSplitViewScope] that encloses the given
  /// context, or null if none is found.
  static NavigationSplitViewScope? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NavigationSplitViewScope>();
  }
}
