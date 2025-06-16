import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:universal_platform/universal_platform.dart';

import '../app_info.dart';
import 'src/clients/api.dart' show newClient;
import 'src/wallabag/types.dart';

export 'clients.dart' show ServerError;

final _log = Logger('server.check');

bool assertMinVersion(String version, int major, int minor, int patch) {
  final match = RegExp(r'^(\d+)\.(\d+)\.(\d+)').firstMatch(version);
  if (match == null) return false;

  final vMajor = int.parse(match[1]!);
  if (major < vMajor) return true;
  if (major > vMajor) return false;

  final vMinor = int.parse(match[2]!);
  if (minor < vMinor) return true;
  if (minor > vMinor) return false;

  final vPatch = int.parse(match[3]!);
  return patch <= vPatch;
}

Future<WallabagInfo?> _fetchServerInfo(Uri uri, bool selfSigned) async {
  _log.info('fetching server info from $uri');
  final client = newClient(selfSignedHost: selfSigned ? uri.host : null);
  final response = await client.get(
    uri.replace(path: '${uri.path}/api/info'),
    headers: {
      'Content-Type': 'application/json',
      if (!UniversalPlatform.isWeb) 'User-Agent': AppInfo.userAgent,
    },
  );
  if (response.statusCode != 200) {
    throw const ServerCheckError(ServerCheckErrorKind.apiError);
  }
  return WallabagInfo.fromJson(jsonDecode(response.body));
}

Future<Uri?> _detectFavicon(Uri uri) async {
  if (UniversalPlatform.isWeb) return null;
  final faviconUri = uri.replace(path: '/favicon.ico');
  final response = await http.head(faviconUri);
  return response.statusCode == 200 ? faviconUri : null;
}

Future<ServerCheck> checkServerState(String serverUrl, bool selfSigned) async {
  _log.info("starting server check for '$serverUrl'");
  late final ServerCheck check;
  try {
    final protocol = serverUrl.startsWith('http://') ? 'http' : 'https';
    var trimmed = serverUrl.split('://').last;
    trimmed =
        trimmed.endsWith('/')
            ? trimmed.substring(0, trimmed.length - 1)
            : trimmed;
    final uri = Uri.parse('$protocol://$trimmed');

    final info = await _fetchServerInfo(uri, selfSigned);

    ServerCheckError? error;
    if (info != null) {
      _log.info('detected a wallabag-like instance (appname: ${info.appname})');
      if ((info.appname == 'wallabag' &&
              !assertMinVersion(info.version, 2, 2, 0)) ||
          (info.appname == 'freon' &&
              !assertMinVersion(info.version, 0, 1, 0))) {
        error = const ServerCheckError(
          ServerCheckErrorKind.versionNotSupported,
        );
      }

      final faviconUri = await _detectFavicon(uri);
      check = ServerCheck(uri, info, faviconUri, error, selfSigned);
    }
  } on http.ClientException catch (e) {
    final exc = ServerCheckUnknownError(e.message);
    check = ServerCheck(null, null, null, exc, selfSigned);
  } on Exception catch (e) {
    check = ServerCheck(null, null, null, e, selfSigned);
  }
  _log.info("server check for '$serverUrl' completed: $check");
  return check;
}

class ServerCheck {
  const ServerCheck(
    this.uri,
    this.info,
    this.faviconUri,
    this.error,
    this.selfSigned,
  );

  final Uri? uri;
  final WallabagInfo? info;
  final Uri? faviconUri;
  final Exception? error;
  final bool selfSigned;

  bool get isValid => info != null && error == null;
  ServerCheckErrorKind? get errorKind {
    if (error == null) return null;
    if (error is ServerCheckError) {
      return (error as ServerCheckError).kind;
    } else if (error is FormatException) {
      return ServerCheckErrorKind.invalidUrl;
    } else if (error is HandshakeException) {
      return ServerCheckErrorKind.unreachable;
    } else {
      return ServerCheckErrorKind.unknown;
    }
  }

  @override
  String toString() {
    return isValid ? 'OK (${info!.version})' : 'KO (${errorKind!.name})';
  }
}

enum ServerCheckErrorKind {
  invalidUrl,
  unreachable,
  apiError,
  versionNotSupported,
  unknown,
}

class ServerCheckError implements Exception {
  const ServerCheckError(this.kind);

  final ServerCheckErrorKind kind;

  @override
  String toString() {
    return 'ServerCheckError(${kind.name})';
  }
}

class ServerCheckUnknownError implements Exception {
  const ServerCheckUnknownError(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
