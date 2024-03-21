import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static PackageInfo? _data;

  static init() async {
    final info = await PackageInfo.fromPlatform();
    _data = info;
  }

  static get data => _data!;
  static get versionVerbose => '${data.version}+${data.buildNumber}';
}
