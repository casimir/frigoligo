import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/article_sheet.g.dart',
    swiftOut: 'ios/Features/Article/ArticleSheet.g.swift',
    dartPackageName: 'frigoligo',
    swiftOptions: SwiftOptions(includeErrorClass: false),
  ),
)
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
  @async
  List<String> getAllTags();

  @async
  void setTags(List<String> tags);

  @async
  void refetchContent();

  /// Called after the sheet is dismissed (user swipe or native close button).
  /// The bridge uses this to cancel subscriptions and reset state.
  @async
  void onClose();
}
