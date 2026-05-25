import 'dart:io';

Future<bool> probeInternet() async {
  try {
    await InternetAddress.lookup('one.one.one.one');
    return true;
  } catch (_) {
    return false;
  }
}
