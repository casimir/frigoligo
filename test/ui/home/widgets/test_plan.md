# Home Widgets Test Plan

THIS DOCUMENT IS OUTDATED FOR THE MOST PART.

## Overview

This document outlines the best candidates for writing tests for the home widgets, prioritized by complexity, testability, and coverage value.

## Current Coverage Status

Based on the latest coverage report, all home widgets currently have **0% test coverage**:

- `lib/ui/home/widgets/article_content.dart` - 173 lines, 0% coverage
- `lib/ui/home/widgets/article_entry.dart` - 46 lines, 0% coverage  
- `lib/ui/home/widgets/article_image_preview.dart` - 8 lines, 0% coverage
- `lib/ui/home/widgets/article_screen.dart` - 121 lines, 0% coverage
- `lib/ui/home/widgets/article_sheet.dart` - 84 lines, 0% coverage
- `lib/ui/home/widgets/home_screen.dart` - 28 lines, 0% coverage
- `lib/ui/home/widgets/listing_container.dart` - 42 lines, 0% coverage
- `lib/ui/home/widgets/search_panel.dart` - 155 lines, 0% coverage
- `lib/ui/home/widgets/reading_progress_indicator.dart` - 11 lines, 1% coverage

## Best Candidates for Testing (Priority Order)

### 1. **ArticleImagePreview** (Highest Priority)

**Why this is the best candidate:**

- ✅ **Stateless widget** with single responsibility
- ✅ **Minimal dependencies** (just a URL string)
- ✅ **Clear behavior** - shows SVG or cached image
- ✅ **Easy to mock** network/image dependencies
- ✅ **High coverage-to-effort ratio**

**Test cases to implement:**

- Renders SVG URLs using `SvgPicture.network`
- Renders non-SVG URLs using `CachedNetworkImage`
- Shows error icon when image fails to load
- Maintains fixed size (80x80 pixels)
- Handles different URL formats correctly

**Expected test file:** `test/ui/home/widgets/article_image_preview_test.dart`

### 2. **ReadingProgressIndicator** (High Priority)

**Why this is a good candidate:**

- ✅ **Simple ConsumerWidget** with clear logic
- ✅ **Single responsibility** - show/hide progress based on state
- ✅ **Straightforward state handling** - watches provider
- ✅ **Easy to mock** `currentReadingProgressProvider`
- ✅ **Good for testing Riverpod integration**

**Test cases to implement:**

- Shows progress bar when value > 0
- Hides progress bar when `hideWhenNoProgress` is true and progress is null/0
- Uses correct height and theme colors
- Updates when provider value changes
- Handles edge cases (negative values, > 1.0 values)

**Expected test file:** `test/ui/home/widgets/reading_progress_indicator_test.dart`

### 3. **ArticleEntry** (Medium-High Priority)

**Why this is valuable:**

- ✅ **Core UI component** with clear interactions
- ✅ **Tests controller integration** - good for testing ArticleEntryController
- ✅ **Covers async loading** - tests AsyncValueLoader integration
- ✅ **User interactions** - tap handlers, tag interactions
- ✅ **State management** - tests Riverpod state updates

**Test cases to implement:**

- Renders article data correctly (title, domain, reading time)
- Shows/hides image preview based on data
- Tag interactions call controller methods
- Archive/star button interactions update state
- Handles loading states properly
- Displays correct icons based on article state

**Expected test file:** `test/ui/home/widgets/article_entry_test.dart`

### 4. **SearchPanel** (Medium Priority)

**Why this is important:**

- ✅ **Complex widget** with multiple sub-components
- ✅ **Tests filtering/search functionality** - core app feature
- ✅ **Good coverage of user interactions** - multiple input types
- ✅ **Tests controller integration** - SearchPanelController
- ⚠️ **Higher complexity** but valuable coverage

**Test cases to implement:**

- Search input updates controller
- Filter chips reflect current state
- Filter interactions call controller methods
- Result count displays correctly
- Menu integration works properly
- Handles different filter combinations

**Expected test file:** `test/ui/home/widgets/search_panel_test.dart`

### 5. **ArticleScreen** (Lower Priority)

**Why this is challenging:**

- ⚠️ **Very complex widget** with many dependencies
- ⚠️ **Requires extensive mocking** - multiple providers, services
- ⚠️ **Lower coverage-to-effort ratio**
- ⚠️ **Better suited for integration tests** rather than unit tests

**Considerations:**

- Focus on testing individual action handlers
- Mock all external dependencies
- Test navigation and state management separately
- Consider breaking into smaller testable components

**Expected test file:** `test/ui/home/widgets/article_screen_test.dart`

## Testing Approach

### Following Project Conventions

Based on the project's test patterns and your preferences:

1. **TDD Style**: Write tests that fail initially, then implement functionality [[memory:7598155]]
2. **Test Grouping**: Use widget class grouping or '>' character for sections [[memory:7598501]]
3. **Idempotency**: Include idempotency checks in nominal tests [[memory:7600277]]

### Implementation Order

1. **Start with ArticleImagePreview** - Quick wins, establishes patterns
2. **Add ReadingProgressIndicator** - Tests Riverpod integration
3. **Move to ArticleEntry** - Core functionality, moderate complexity
4. **Tackle SearchPanel** - Complex interactions, high value
5. **Consider ArticleScreen** - Integration-level testing

### Test Structure Pattern

```dart
void main() {
  group('WidgetName', () {
    // Setup and teardown
    
    group('> Rendering', () {
      testWidgets('should render correctly with valid data', (tester) async {
        // Test implementation
      });
    });
    
    group('> Interactions', () {
      testWidgets('should handle user interactions', (tester) async {
        // Test implementation
      });
    });
    
    group('> State Management', () {
      testWidgets('should update when state changes', (tester) async {
        // Test implementation
      });
    });
  });
}
```

## Expected Coverage Impact

Implementing tests for the top 4 candidates should significantly improve coverage:

- **ArticleImagePreview**: +8 lines (100% coverage)
- **ReadingProgressIndicator**: +11 lines (100% coverage)
- **ArticleEntry**: +46 lines (100% coverage)
- **SearchPanel**: +155 lines (100% coverage)

**Total expected improvement**: +220 lines of coverage

## Next Steps

1. Create test files for each widget in priority order
2. Implement basic rendering tests first
3. Add interaction tests
4. Include state management tests
5. Run coverage analysis to measure improvement
6. Consider integration tests for complex widgets

## Dependencies to Mock

- `ArticleEntryController` - for ArticleEntry tests
- `SearchPanelController` - for SearchPanel tests
- `currentReadingProgressProvider` - for ReadingProgressIndicator tests
- `articleStateProvider` - for ArticleEntry tests
- `queryStateProvider` - for SearchPanel tests
- Network image dependencies - for ArticleImagePreview tests
