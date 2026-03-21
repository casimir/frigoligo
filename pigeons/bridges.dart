import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/bridges.g.dart',
    swiftOut: 'ios/Runner/Bridges.g.swift',
    dartPackageName: 'frigoligo',
  ),
)
// -------------
// Article sheet
// -------------
/// Article metadata displayed in the native sheet.
class ArticleSheetData {
  late String title;
  late String link;
  String? domain;
  late int readingTime;
  late List<String> tags;
}

/// Dart → Swift. Controls the native article sheet lifecycle.
@HostApi()
abstract class ArticleSheetApi {
  /// Present the sheet.
  void open();

  /// Push updated article data into the sheet.
  void update(ArticleSheetData data);

  /// Programmatically dismiss the sheet (Dart-initiated close).
  /// Does not call back into Dart — the caller is responsible for cleanup.
  void close();
}

/// Swift → Dart. Callbacks from the native sheet to the Dart bridge.
@FlutterApi()
abstract class ArticleSheetFlutterApi {
  /// Called after the sheet is dismissed (user swipe or native close button).
  /// The bridge uses this to cancel subscriptions and reset state.
  @async
  void onClose();

  @async
  List<String> getAllTags();

  @async
  void refetchContent();

  @async
  void setTags(List<String> tags);
}

// ---------
// Auth gate
// ---------

/// Dart → Swift. Controls the native auth gate lifecycle.
@HostApi()
abstract class AuthGateApi {
  /// Called when no session exists; Swift must present the login FlutterVC.
  void requireLogin();

  /// Called after successful login; Swift must dismiss the login FlutterVC.
  void loginDidComplete();
}

// ----------------
// Navigation split
// ----------------

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

/// Mirrors the Query domain model; enum fields use int ordinals.
class NavigationFilterState {
  late String text;
  late int textMode; // SearchTextMode ordinal: 0=all 1=title 2=content
  late int stateFilter; // StateFilter ordinal: 0=all 1=unread 2=archived
  late bool onlyStarred;
  late List<String> tags;
  late List<String> domains;
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
  void setTextMode(int mode);
  void setStateFilter(int state);
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
}
