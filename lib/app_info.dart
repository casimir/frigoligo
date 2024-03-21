import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static PackageInfo? _data;

  static init() async {
    _data = await PackageInfo.fromPlatform();
  }

  static get data => _data!;
  static get versionVerbose => '${data.version}+${data.buildNumber}';
}
