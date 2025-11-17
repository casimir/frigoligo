// coverage:ignore-file
// This just a wrapper around a binding to native sharing functionality.

import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  const UrlLauncherService();

  Future<bool> launch(Uri url) => launchUrl(url);

  Future<bool> launchString(String url) => launch(Uri.parse(url));
}
