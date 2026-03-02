import 'dart:convert';

import '../wallabag/endpoints.dart';
import 'api.dart';
import 'wallabag_api.dart';
import 'with_read_progress.dart';

class FreonClient extends TokenBearerClient
    with WallabagClientEndpoints, WallabagMethods, WithReadProgress {
  FreonClient(
    super.credentials, {
    super.userAgent,
    super.selfSignedHost,
    super.enableHttpLogs,
  });

  @override
  Future<Uri> buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    return super.buildUri('/wallabag$path', queryParameters);
  }

  @override
  Future<List<ReadProgressUpdate>> getReadProgress(DateTime since) async {
    final uri = await super.buildUri('/api/read-progress', {
      'since': since.toUtc().toIso8601String(),
    });
    final response = await get(uri);
    throwOnError(response);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final updates = json['updates'] as List<dynamic>;
    return updates
        .map(
          (e) => ReadProgressUpdate(
            articleId: e['article_id'] as int,
            progress: (e['progress'] as num).toDouble(),
            updatedAt: DateTime.parse(e['updated_at'] as String),
          ),
        )
        .toList();
  }

  @override
  Future<void> putReadProgress(List<ReadProgressUpdate> updates) async {
    final uri = await super.buildUri('/api/read-progress');
    final body = jsonEncode({
      'updates': updates
          .map(
            (u) => {
              'article_id': u.articleId,
              'progress': u.progress,
              'updated_at': u.updatedAt.toUtc().toIso8601String(),
            },
          )
          .toList(),
    });
    final response = await put(uri, body: body);
    throwOnError(response, expected: [204]);
  }
}
