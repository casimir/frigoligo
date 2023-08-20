import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

final _log = Logger('deeplinks');

class DeeplinksProvider extends ChangeNotifier {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription? _appLinksSubscription;
  final RouteConfiguration routeConfiguration;
  final void Function(Deeplink, Uri) onData;

  DeeplinksProvider(this.routeConfiguration, this.onData);

  bool get isListening => _appLinksSubscription != null;

  Deeplink receive(Uri uri) {
    _log.info('trying to open $uri');
    final matches = routeConfiguration.findMatch(uri.toString());
    if (matches.isEmpty) return Deeplink.invalid;
    final linkType = switch (uri.pathSegments.first) {
      'login' => Deeplink.login,
      'save' => Deeplink.save,
      _ => Deeplink.invalid,
    };
    if (linkType != Deeplink.invalid) {
      _log.info('validated $linkType: $uri');
      onData(linkType, uri);
    }
    return linkType;
  }

  void listen() {
    assert(_appLinksSubscription == null);
    _appLinksSubscription = _appLinks.allUriLinkStream.listen((uri) {
      receive(uri);
    });
  }

  @override
  void dispose() {
    _appLinksSubscription?.cancel();
    super.dispose();
  }
}

enum Deeplink {
  invalid,
  login,
  save,
}
