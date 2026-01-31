import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../app_info.dart';
import 'clients/api.dart' show newClient;
import 'wallabag/types.dart' show WallabagInfo;

final _probesLog = Logger('server.probes');

enum ServerType {
  freon,
  wallabag,
  local;

  @override
  String toString() => name;
}

class ServerProbeResult {
  const ServerProbeResult({required this.type, required this.version});

  final ServerType type;
  final String version;

  @override
  String toString() => '$type ($version)';
}

typedef ServerProber =
    Future<ServerProbeResult?> Function(http.Client client, Uri uri);

const probes = <ServerProber>[_wallabagProbe];

Future<ServerProbeResult?> probeServer(Uri uri, bool selfSigned) async {
  _probesLog.info('probing server at $uri');
  final client = newClient(selfSignedHost: selfSigned ? uri.host : null);
  for (final probe in probes) {
    final result = await probe(client, uri);
    if (result != null) {
      _probesLog.info('server type: $result');
      return result;
    }
  }
  _probesLog.warning('no server type found for $uri');
  return null;
}

Future<ServerProbeResult?> _wallabagProbe(http.Client client, Uri uri) async {
  final response = await client.get(
    uri.replace(path: '${uri.path}/api/info'),
    headers: {
      'Content-Type': 'application/json',
      if (!UniversalPlatform.isWeb) 'User-Agent': AppInfo.userAgent,
    },
  );

  if (response.statusCode != 200) {
    _probesLog.warning('wallabag probe failed: HTTP ${response.statusCode}');
    return null;
  }

  try {
    final info = WallabagInfo.fromJson(jsonDecode(response.body));
    return ServerProbeResult(
      type: ServerType.values.byName(info.appname),
      version: info.version,
    );
  } on FormatException {
    _probesLog.warning('wallabag probe failed: invalid json');
    return null;
  }
}
