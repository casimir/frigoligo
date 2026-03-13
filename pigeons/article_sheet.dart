import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/article_sheet.g.dart',
    swiftOut: 'ios/Features/Article/ArticleSheet.g.swift',
    dartPackageName: 'frigoligo',
  ),
)
//
class ArticleSheetLabels {
  String addTags;
  String openInBrowser;
  String readingTime;
  String refetchContent;
  String share;
  String sheetTitle;
  String tags;
  String title;
  String website;
}

class ArticleSheetData {
  String? title;
  String? link;
  String? domain;
  String? readingTime;
  List<String>? tags;
  ArticleSheetLabels labels;
}

@HostApi()
abstract class ArticleSheetApi {
  void open();
  void update(ArticleSheetData data);
}

@FlutterApi()
abstract class ArticleSheetFlutterApi {
  @async
  void close();
  @async
  List<String> getAllTags();
  @async
  void refetchContent();
  @async
  void setTags(List<String> tags);
}
