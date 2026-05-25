import 'dart:io';

Future<bool> probeInternet(Uri url) async {
  try {
    await InternetAddress.lookup(url.host).timeout(const Duration(seconds: 5));
    return true;
  } catch (_) {
    return false;
  }
}
