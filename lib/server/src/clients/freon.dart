import '../wallabag/endpoints.dart';
import 'api.dart';
import 'wallabag_api.dart';

class FreonClient extends TokenBearerClient
    with WallabagClientEndpoints, WallabagMethods {
  FreonClient(
    super.credentials, {
    super.userAgent,
    super.selfSignedHost,
    super.enableHttpLogs,
  });

  @override
  Future<Uri> buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    return super.buildUri('wallabag/$path', queryParameters);
  }
}
