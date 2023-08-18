import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'models/info.dart';

final _log = Logger('wallabag.utils');

Future<String> buildUserAgent() async {
  final info = await PackageInfo.fromPlatform();
  return '${info.appName}/${info.version}+${info.buildNumber}';
}

Future<WallabagInfo?> _fetchWallabagInfo(Uri uri) async {
  final response = await http.get(
    Uri.https(uri.authority, '${uri.path}/api/info.json'),
    headers: {'user-agent': await buildUserAgent()},
  );
  if (response.statusCode != 200) {
    throw const WallabagCheckError(WallabagCheckErrorKind.apiError);
  }
  return WallabagInfo.fromJson(jsonDecode(response.body));
}

Future<Uri?> _detectFavicon(Uri uri) async {
  final faviconUri = Uri.https(uri.authority, '/favicon.ico');
  try {
    final response = await http.head(faviconUri);
    return response.statusCode == 200 ? faviconUri : null;
  } catch (e) {
    _log.warning("failed to detect favicon for '$uri': $e");
    return null;
  }
}

Future<WallabagServerCheck> checkWallabagServer(String serverUrl) async {
  _log.info("starting server check for '$serverUrl'");
  late final WallabagServerCheck check;
  try {
    var trimmed = serverUrl.split('://').last;
    trimmed = trimmed.endsWith('/')
        ? trimmed.substring(0, trimmed.length - 1)
        : trimmed;
    final uri = Uri.parse('https://$trimmed');
    final info = await _fetchWallabagInfo(uri);
    final faviconUri = await _detectFavicon(uri);
    check = WallabagServerCheck(uri, info, faviconUri, null);
  } on Exception catch (e) {
    check = WallabagServerCheck(null, null, null, e);
  }
  _log.info("server check for '$serverUrl' completed: $check");
  return check;
}

class WallabagServerCheck {
  const WallabagServerCheck(this.uri, this.info, this.faviconUri, this.error);

  final Uri? uri;
  final WallabagInfo? info;
  final Uri? faviconUri;
  final Exception? error;

  bool get isValid => info != null && error == null;
  WallabagCheckErrorKind? get errorKind {
    if (error == null) return null;
    if (error is WallabagCheckError) {
      return (error as WallabagCheckError).kind;
    } else if (error is FormatException) {
      return WallabagCheckErrorKind.invalidUrl;
    } else if (error is HandshakeException) {
      return WallabagCheckErrorKind.unreachable;
    } else {
      return WallabagCheckErrorKind.unknown;
    }
  }

  @override
  String toString() {
    return isValid ? 'OK (${info!.version})' : 'KO (${errorKind!.name})';
  }
}

enum WallabagCheckErrorKind {
  invalidUrl,
  unreachable,
  apiError,
  unknown,
}

class WallabagCheckError implements Exception {
  const WallabagCheckError(this.kind);

  final WallabagCheckErrorKind kind;

  @override
  String toString() {
    return 'WallabagCheckError(${kind.name})';
  }
}
