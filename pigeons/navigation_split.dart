import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/navigation_split.g.dart',
    swiftOut: 'ios/Features/Navigation/NavigationSplit.g.swift',
    dartPackageName: 'frigoligo',
    swiftOptions: SwiftOptions(includeErrorClass: false),
  ),
)
/// Article data for a single row in the native article list.
class ArticleRowData {
  late int id;
  late String title;
  String? domainName;
  late int readingTime;
  String? previewPictureUrl;
  late List<String> tags;
  late bool isArchived;
  late bool isStarred;
  late String url;
}

/// Sync progress state for the toolbar indicator.
class NavigationSyncState {
  late bool isWorking;
  double? progressValue; // null = indeterminate
  late int pendingCount;
}

enum NavigationSearchTextMode { all, title, content }

enum NavigationStateFilter { all, unread, archived }

/// Mirrors the Query domain model.
class NavigationFilterState {
  late String text;
  late NavigationSearchTextMode textMode;
  late NavigationStateFilter stateFilter;
  late bool onlyStarred;
  late List<String> tags;
  late List<String> domains;
}

/// Reading settings for the native article WebView.
class ArticleReadingSettings {
  late double fontSize; // 12 | 14 | 16 | 18 | 20
  late String fontFamily;
  late bool justifyText;
}

/// Article content pushed into the native detail view.
class ArticleContent {
  ArticleContent({required this.id, this.html, required this.readingProgress});
  int id;
  String? html; // null while loading
  double readingProgress;
}

/// Dart → Swift. Pushes updated list/sync/filter state into the native sidebar.
@HostApi()
abstract class NavigationSplitApi {
  void updateArticleIds(List<int> ids);
  void updateSyncState(NavigationSyncState state);
  void updateFilterState(NavigationFilterState state);
  void updateArticleContent(ArticleContent content);
  void updateArticleData(ArticleRowData data);
  void updateReadingSettings(ArticleReadingSettings settings);
}

/// Swift → Dart. Callbacks from the native sidebar to the Dart bridge.
@FlutterApi()
abstract class NavigationSplitFlutterApi {
  @async
  ArticleRowData getArticleRowData(int id);
  @async
  List<String> getAvailableTags();
  @async
  List<String> getAvailableDomains();
  void setSearchText(String text);
  void setTextMode(NavigationSearchTextMode mode);
  void setStateFilter(NavigationStateFilter state);
  void setOnlyStarred(bool onlyStarred);
  void setTags(List<String> tags);
  void setDomains(List<String> domains);
  void refresh();
  void setArticleArchived(int id, bool archived);
  void setArticleStarred(int id, bool starred);
  void filterByTag(String tag);
  void onArticleSelected(int id);
  void onReadingProgressChanged(int articleId, double progress);
  void deleteArticle(int id);
  void openArticleSheet(int id);
  void setReadingSettings(ArticleReadingSettings settings);
  @async
  void openSettings();
  @async
  void secondaryScreenDidClose();
  @async
  void saveLink(String url);
}
