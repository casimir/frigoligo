import 'package:flutter/widgets.dart';

import '../../server/check.dart';
import '../../server/session.dart';
import 'login_freon.dart';
import 'login_wallabag.dart';

abstract class LoginFlowCredentials extends Widget {
  factory LoginFlowCredentials({
    Key? key,
    required ServerCheck serverCheck,
    Map<String, String> initial = const {},
    void Function()? onReset,
  }) {
    final rawServerType = serverCheck.info!.appname;
    final serverType = ServerType.values.byName(rawServerType);

    switch (serverType) {
      case ServerType.freon:
        return LoginFlowFreon(
          key: key,
          serverCheck: serverCheck,
          initial: initial,
          onReset: onReset,
        );
      case ServerType.wallabag:
        return LoginFlowWallabag(
          key: key,
          serverCheck: serverCheck,
          initial: initial,
          onReset: onReset,
        );
      case ServerType.unknown:
        throw UnknownServerTypeError(rawServerType);
    }
  }
}

class UnknownServerTypeError implements Exception {
  const UnknownServerTypeError(this.type);

  final String type;

  @override
  String toString() {
    return 'unknown server type: $type';
  }
}
