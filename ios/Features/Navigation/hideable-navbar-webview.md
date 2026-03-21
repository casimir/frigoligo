# Hideable navigation bar with WKWebView — findings

## What we tried

### 1. Manual scroll direction tracking (SwiftUI state)

Track `contentOffset.y` delta in `UIScrollViewDelegate`, call back to SwiftUI,
toggle `.toolbar(.hidden/.visible, for: .navigationBar)`.

**Problem:** re-appear requires wiring `scrollViewDidEndDecelerating` and
`scrollViewDidEndDragging` separately, and the threshold/debounce logic is
fragile and complex for something that should be trivial.

### 2. `UINavigationController.hidesBarsOnSwipe = true`

Standard UIKit property. UIKit hooks into WKWebView's internal scroll view
automatically — no manual delegate bridging needed for the hide gesture.
Known gotcha: bar does not reliably re-appear when scrolling back to the top;
workaround is forcing it in `scrollViewDidScroll` when `contentOffset.y <= 0`.

**Problem:** SwiftUI's `NavigationSplitView` renders its own navigation chrome
on top of UIKit's. Setting `hidesBarsOnSwipe` on the underlying
`UINavigationController` (reached via responder chain) hides the UIKit bar but
not the SwiftUI-managed one, so the bar never actually disappears.

## Conclusion

No clean solution found for iOS 16 SwiftUI `NavigationSplitView` + WKWebView.
`hidesBarsOnSwipe` is the right UIKit primitive but is incompatible with
SwiftUI's navigation rendering. Manual SwiftUI state is too complex and
produces poor UX. Deferred.
