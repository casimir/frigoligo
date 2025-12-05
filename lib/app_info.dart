import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_platform/universal_platform.dart';

class AppInfoData {
  const AppInfoData(this.iosInfo, this.package);

  final IosDeviceInfo? iosInfo;
  final PackageInfo package;
}

class AppInfo {
  static AppInfoData? _data;

  static Future<void> init() async {
    IosDeviceInfo? iosInfo;
    if (UniversalPlatform.isIOS) {
      iosInfo = await DeviceInfoPlugin().iosInfo;
    }
    final package = await PackageInfo.fromPlatform();
    _data = AppInfoData(iosInfo, package);
  }

  static AppInfoData get data {
    assert(_data != null, 'AppInfo not initialized call AppInfo.init() first');
    return _data!;
  }

  static bool get deviceIsIPhone => data.iosInfo?.model == 'iPhone';

  static String get userAgent {
    final pkg = data.package;
    return '${pkg.appName}/${pkg.version}+${pkg.buildNumber}';
  }

  static String get versionVerbose {
    final pkg = data.package;
    return '${pkg.version}+${pkg.buildNumber}';
  }
}
