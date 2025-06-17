import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:universal_platform/universal_platform.dart';

import 'src/server_types.dart';

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

    final probeResult = await probeServer(uri, selfSigned);
    if (probeResult == null) {
      return ServerCheck.error(
        const ServerCheckError(ServerCheckErrorKind.unknownServerType),
        selfSigned,
      );
    }

    ServerCheckError? error;
    if ([ServerType.wallabag, ServerType.freon].contains(probeResult.type)) {
      if ((probeResult.type == ServerType.wallabag &&
              !assertMinVersion(probeResult.version, 2, 2, 0)) ||
          (probeResult.type == ServerType.freon &&
              !assertMinVersion(probeResult.version, 0, 1, 0))) {
        error = const ServerCheckError(
          ServerCheckErrorKind.versionNotSupported,
        );
      }

      final faviconUri = await _detectFavicon(uri);
      check = ServerCheck(probeResult, uri, faviconUri, error, selfSigned);
    }
  } on http.ClientException catch (e) {
    final exc = ServerCheckUnknownError(e.message);
    check = ServerCheck.error(exc, selfSigned);
  } on Exception catch (e) {
    check = ServerCheck.error(e, selfSigned);
  }
  _log.info("server check for '$serverUrl' completed: $check");
  return check;
}

class ServerCheck {
  const ServerCheck(
    this.probeResult,
    this.uri,
    this.faviconUri,
    this.error,
    this.selfSigned,
  );

  final ServerProbeResult? probeResult;
  final Uri? uri;
  final Uri? faviconUri;
  final Exception? error;
  final bool selfSigned;

  bool get isValid => probeResult != null && error == null;
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
    return isValid ? 'OK (${probeResult!.version})' : 'KO (${errorKind!.name})';
  }

  factory ServerCheck.error(Exception error, bool selfSigned) =>
      ServerCheck(null, null, null, error, selfSigned);
}

enum ServerCheckErrorKind {
  invalidUrl,
  unknownServerType,
  unreachable,
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
