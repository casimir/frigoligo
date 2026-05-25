import 'package:http/http.dart';

Future<bool> probeInternet() async {
  final client = Client();
  try {
    await client
        .head(Uri.parse('https://one.one.one.one'))
        .timeout(const Duration(seconds: 5));
    return true;
  } catch (_) {
    return false;
  } finally {
    client.close();
  }
}
