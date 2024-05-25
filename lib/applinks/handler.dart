import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

final _log = Logger('deeplinks');

typedef OnLinkData = void Function(Deeplink, Uri);

class LinksHandler {
  static late AppLinks appLinks;
  // it should be called as soon as possible in the app lifecycle
  static void init() {
    appLinks = AppLinks();
    _log.info('listening for app links');

    // TODO register custom protocol (on Windows)
    // https://github.com/llfbandit/app_links/blob/0ba03114bde67dc2ee5db484a83bfced82cef5a5/example/lib/main.dart#L34
  }

  static Deeplink _handle(
      RouteConfiguration router, Uri uri, OnLinkData onData) {
    _log.info('trying to open $uri');
    final matches = router.findMatch(uri.toString());
    if (matches.isEmpty) return Deeplink.invalid;
    final linkType = switch (uri.pathSegments.first) {
      'articles' => Deeplink.article,
      'login' => Deeplink.login,
      'logs' => Deeplink.logs,
      'save' => Deeplink.save,
      _ => Deeplink.invalid,
    };
    if (linkType != Deeplink.invalid) {
      _log.info('validated $linkType: $uri');
      onData(linkType, uri);
    }
    return linkType;
  }

  static StreamSubscription<Uri> listen(
      RouteConfiguration router, OnLinkData onLinkData) {
    return appLinks.uriLinkStream.listen((uri) {
      if (uri.scheme != 'frigoligo') {
        _log.info('converting bare URI to /save link');
        uri = Uri(path: '/save', queryParameters: {'url': uri.toString()});
      }
      _handle(router, uri, onLinkData);
    });
  }
}

enum Deeplink {
  article,
  invalid,
  login,
  logs,
  save,
}
