import 'package:cadanse/layout.dart';
import 'package:flutter/material.dart';

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

    setState(() {
      _selectedIndex = index;
    });

    if (_effectiveLayout == _Layout.full && index != null && mounted) {
      Navigator.of(context).push(
        // TODO best page route widget to use here?
        MaterialPageRoute(
          builder: (context) => widget.contentBuilder(context, index),
        ),
      );
    }
  }

  bool get isContentExpanded => _isContentExpanded.value;

  void toggleContentExpansion() => setState(() {
    _isContentExpanded.value = !_isContentExpanded.value;
  });

  @override
  Widget build(BuildContext context) {
    if (_effectiveLayout == _Layout.full) {
      return _buildNavigationPane();
    }

    final content =
        _selectedIndex == null
            ? widget.contentPlaceholder ?? _buildDefaultContentPlaceholder()
            : widget.contentBuilder(context, _selectedIndex!);

    return Row(
      children: [
        if (!_isContentExpanded.value) ...[
          Flexible(flex: 1, child: _buildNavigationPane()),
          const VerticalDivider(width: 1),
        ],
        Flexible(flex: 2, child: content),
      ],
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
        return GestureDetector(
          onTap: () => selectIndex(index),
          child: widget.navigationItemBuilder(context, index),
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

  Widget _buildDefaultContentPlaceholder() {
    // TODO set up a better placeholder
    return const Center(child: Text('Select an item'));
  }
}

enum _Layout { sideBySide, full }

/// A builder for the navigation pane container.
typedef NavigationContainerBuilder =
    Widget Function(BuildContext context, int selectedIndex, Widget child);
