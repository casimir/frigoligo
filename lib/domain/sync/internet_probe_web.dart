import 'package:http/http.dart';

Future<bool> probeInternet(Uri url) async {
  final client = Client();
  try {
    await client.head(url).timeout(const Duration(seconds: 5));
    return true;
  } catch (_) {
    return false;
  } finally {
    client.close();
  }
}
