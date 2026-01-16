import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show HardwareKeyboard, KeyDownEvent, LogicalKeyboardKey;

import '../../adaptive.dart';
import 'animated_navigation_pane_slider.dart';

/// The default maximum width for the navigation items container including the
/// visual feedback area.
///
/// The value is arbitrarily derived from [kNavigationPaneWidth] to get a smooth
/// width transition between the different layouts.
const double kNavigationItemMaxWidth = kNavigationPaneWidth * 1.33;

bool _isTextFieldFocused() {
  final focus = FocusManager.instance.primaryFocus;
  return focus?.context?.findAncestorStateOfType<EditableTextState>() != null;
}

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
    this.navigationItemExtent,
    this.navigationScrollController,
    required this.contentBuilder,
    this.contentContainerBuilder,
    this.contentPlaceholder,
    this.initialIndex,
    this.onSelectedIndexChanged,
    this.enableShortcuts = true,
    this.highlightColor,
    this.scrollToSelectedItem,
    this.restorationId,
  });

  /// Total count of items in the navigation pane.
  ///
  /// This is a [ValueListenable] so that the [NavigationSplitView] can update
  /// the navigation items without rebuilding the entire widget and more
  /// importantly without rebuilding the content pane.
  final ValueListenable<int> itemCount;

  /// Builder for the navigation pane items.
  final NullableIndexedWidgetBuilder navigationItemBuilder;

  /// Builder for the navigation pane container. Can be used to wrap the
  /// navigation list in a custom container.
  final NavigationContainerBuilder? navigationContainerBuilder;

  /// Placeholder for the navigation pane when no items are provided.
  final Widget? navigationPlaceholder;

  /// Item extent for the navigation items.
  ///
  /// This attribute is necessary when [scrollToSelectedItem] is true.
  ///
  /// It is passed to [ListView.itemExtent] internally, see the documentation
  /// for more details.
  final double? navigationItemExtent;

  /// Scroll controller for the navigation pane.
  final ScrollController? navigationScrollController;

  /// Builder for the content pane.
  final IndexedWidgetBuilder contentBuilder;

  /// Builder for the content pane container.
  final TransitionBuilder? contentContainerBuilder;

  /// Placeholder for the content pane when no item is selected.
  final Widget? contentPlaceholder;

  /// Initial selected index. When not provided, the first item is selected.
  final int? initialIndex;

  /// Callback when the selected index changes.
  final ValueChanged<int?>? onSelectedIndexChanged;

  /// Feature flag to enable keyboard shortcuts.
  final bool enableShortcuts;

  /// Color to use to highlight the selected item in the navigation pane.
  final Color? highlightColor;

  /// Whether to scroll to the item when the selection changes.
  ///
  /// By default, it is true when [navigationItemExtent] is not null. Note that
  /// if explicitly set to true, [navigationItemExtent] must be provided.
  final bool? scrollToSelectedItem;

  /// Restoration ID to save and restore the state of the [NavigationSplitView].
  ///
  /// If it is non-null, the [NavigationSplitView] will persist and restore
  /// whether the content was expanded or not.
  final String? restorationId;

  /// Key for the navigation pane to restore the scroll state between redraws.
  final String navigationPaneKey = 'navigation_pane';

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
  late final ScrollController _navigationScroller;
  late final bool _scrollToSelectedItem;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex;
    if (_selectedIndex == null && widget.itemCount.value > 0) {
      _selectedIndex = 0;
    }

    _navigationScroller =
        widget.navigationScrollController ?? ScrollController();

    _scrollToSelectedItem =
        widget.navigationItemExtent != null &&
        (widget.scrollToSelectedItem ?? true);

    if (widget.initialIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectIndex(widget.initialIndex);
      });
    }

    widget.itemCount.addListener(_onItemCountNotification);

    if (widget.enableShortcuts) {
      HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    }
  }

  @override
  void dispose() {
    widget.itemCount.removeListener(_onItemCountNotification);

    if (widget.enableShortcuts) {
      HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    }

    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return false;
    if (_getLayout() != NavigationSplitViewLayout.sideBySide) return false;

    if (event.logicalKey == LogicalKeyboardKey.keyF) {
      if (!_isTextFieldFocused()) {
        expandContent();
        return true;
      }
    }
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      // Allow Escape even if text field is focused when content is expanded,
      // since the text field is hidden behind the expanded content pane.
      if (isContentExpanded || !_isTextFieldFocused()) {
        collapseContent();
        return true;
      }
    }
    return false;
  }

  // When the navigation list is invalidated we want to invalidate the currently
  // selected index and go back to the top of the list.
  // A nice behavior would be to try to keep the selection and scroll position
  // when the displayed section and previous elements are identical but it would
  // involve a lot of complexity.
  void _onItemCountNotification() {
    final newItemCount = widget.itemCount.value;

    if (newItemCount == 0) {
      _selectedIndex = null;
    } else if (_selectedIndex == null) {
      setState(() {
        _selectedIndex = 0;
      });
    }

    if (_navigationScroller.hasClients) {
      _navigationScroller.jumpTo(0);
    }
  }

  NavigationSplitViewLayout _getLayout() {
    final sizeClass = WindowQuery.of(context).sizeClass;
    return [WindowSizeClass.compact, WindowSizeClass.medium].contains(sizeClass)
        ? NavigationSplitViewLayout.full
        : NavigationSplitViewLayout.sideBySide;
  }

  double _computeOffsetForIndex(int index) {
    final itemPixels = index * widget.navigationItemExtent!;
    final targetPixels = itemPixels;
    return targetPixels.clamp(-1, _navigationScroller.position.maxScrollExtent);
  }

  bool _isNavigationOffsetVisible(double offset) {
    final top = _navigationScroller.position.pixels;
    final bottom = top + _navigationScroller.position.viewportDimension;
    return top <= offset && offset <= bottom;
  }

  /// Change the selected index.
  void selectIndex(int? index) {
    final layout = _getLayout();

    if (index != null) {
      final itemCount = widget.itemCount.value;
      assert(
        index >= 0 && index < itemCount,
        'index must be between 0 and ${itemCount - 1} but got $index',
      );
    }

    widget.onSelectedIndexChanged?.call(index);

    if (layout == NavigationSplitViewLayout.sideBySide) {
      if (_selectedIndex != index) {
        setState(() {
          _selectedIndex = index;
        });
      }

      if (_scrollToSelectedItem && index != null) {
        assert(
          widget.navigationItemExtent != null,
          'navigationItemExtent must be provided when scrollToSelectedItem is true',
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final offset = _computeOffsetForIndex(index);
          if (!_isNavigationOffsetVisible(offset)) {
            _navigationScroller.jumpTo(offset);
          }
        });
      }
    }

    if (layout == NavigationSplitViewLayout.full && index != null && mounted) {
      Navigator.of(context).push(
        adaptivePageRouteBuilder(
          context,
          (context) => _buildContentPane(index, widget.enableShortcuts),
        ),
      );
    }
  }

  @visibleForTesting
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
    final layout = _getLayout();

    if (layout == NavigationSplitViewLayout.full) {
      return _buildNavigationPane(layout);
    }

    Widget view;

    view = Row(
      children: [
        AnimatedNavigationPaneSlider(
          isContentExpanded: isContentExpanded,
          navigationPane: _buildNavigationPane(layout),
        ),
        if (!isContentExpanded) const VerticalDivider(width: 1),
        Expanded(child: _buildContentPane(_selectedIndex, false)),
      ],
    );

    return NavigationSplitViewScope(
      isContentExpanded: isContentExpanded,
      layout: layout,
      child: view,
    );
  }

  Widget _buildNavigationPane(NavigationSplitViewLayout layout) {
    final navigation = ValueListenableBuilder(
      valueListenable: widget.itemCount,
      builder: (context, itemCount, child) {
        if (itemCount == 0) {
          return widget.navigationPlaceholder ??
              _buildDefaultNavigationPlaceholder();
        } else {
          return ListView.builder(
            key: PageStorageKey<String>(widget.navigationPaneKey),
            controller: _navigationScroller,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final isSelected = _selectedIndex == index;
              final highlightColor =
                  isSelected && layout == NavigationSplitViewLayout.sideBySide
                  ? widget.highlightColor ?? Theme.of(context).highlightColor
                  : null;
              return Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: kNavigationItemMaxWidth,
                  ),
                  child: InkWell(
                    splashFactory: adaptiveSplashFactory(context),
                    onTap: () => selectIndex(index),
                    child: Semantics(
                      button: true,
                      selected: isSelected,
                      child: Ink(
                        color: highlightColor,
                        height: widget.navigationItemExtent,
                        child: widget.navigationItemBuilder(context, index),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );

    if (widget.navigationContainerBuilder != null) {
      return widget.navigationContainerBuilder!(
        context,
        _selectedIndex,
        navigation,
      );
    } else {
      return navigation;
    }
  }

  Widget _buildDefaultNavigationPlaceholder() {
    final color = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Icon(
        Icons.list_alt_outlined,
        size: 64,
        color: color.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildContentPane(int? index, bool withShortcuts) {
    final content = index == null
        ? widget.contentPlaceholder ?? _buildDefaultContentPlaceholder()
        : widget.contentBuilder(context, index);

    late final Widget view;

    if (withShortcuts) {
      view = _EscapePopHandler(child: content);
    } else {
      view = content;
    }

    if (widget.contentContainerBuilder != null) {
      return widget.contentContainerBuilder!(context, view);
    } else {
      return view;
    }
  }

  Widget _buildDefaultContentPlaceholder() {
    final color = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Icon(
        Icons.info_outline,
        size: 64,
        color: color.withValues(alpha: 0.3),
      ),
    );
  }
}

/// Layout of the [NavigationSplitView].
enum NavigationSplitViewLayout {
  /// Side-by-side layout.
  sideBySide,

  /// Full (screen) layout.
  full,
}

/// A builder for the navigation pane container.
typedef NavigationContainerBuilder =
    Widget Function(BuildContext context, int? selectedIndex, Widget child);

/// A scope that is inserted by [NavigationSplitView] and contains information
/// about its state.
///
/// Mainly used by [ExpandContentButton] to adapt its icon and tooltip to the
/// ambient content expansion state.
class NavigationSplitViewScope extends InheritedWidget {
  /// Creates a new navigation split view scope.
  const NavigationSplitViewScope({
    super.key,
    required super.child,
    required this.isContentExpanded,
    required this.layout,
  });

  /// Whether the content pane is expanded.
  final bool isContentExpanded;

  /// Current layout of the [NavigationSplitView].
  final NavigationSplitViewLayout layout;

  @override
  bool updateShouldNotify(NavigationSplitViewScope oldWidget) {
    return oldWidget.isContentExpanded != isContentExpanded ||
        oldWidget.layout != layout;
  }

  /// The closest instance of [NavigationSplitViewScope] that encloses the given
  /// context, or null if none is found.
  static NavigationSplitViewScope? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NavigationSplitViewScope>();
  }
}

/// A widget that pops the Navigator when Escape is pressed.
///
/// Used for full layout mode where content is pushed on a route.
class _EscapePopHandler extends StatefulWidget {
  const _EscapePopHandler({required this.child});

  final Widget child;

  @override
  State<_EscapePopHandler> createState() => _EscapePopHandlerState();
}

class _EscapePopHandlerState extends State<_EscapePopHandler> {
  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return false;
    if (_isTextFieldFocused()) return false;

    if (event.logicalKey == LogicalKeyboardKey.escape) {
      final navigator = Navigator.of(context);
      if (mounted && navigator.canPop()) {
        navigator.pop();
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
