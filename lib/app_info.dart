import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static PackageInfo? _data;

  static init() async {
    _data = await PackageInfo.fromPlatform();
  }

  static PackageInfo get data {
    assert(_data != null, 'AppInfo not initialized call AppInfo.init() first');
    return _data!;
  }

  static String get userAgent =>
      '${data.appName}/${data.version}+${data.buildNumber}';

  static String get versionVerbose => '${data.version}+${data.buildNumber}';
}
