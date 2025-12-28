import 'package:frigoligo/domain/models/server_session.dart';
import 'package:frigoligo/server/clients.dart';
import 'package:frigoligo/server/src/clients/wallabag.dart';
import 'package:test/test.dart';

void main() {
  group('ServerSession', () {
    final testUri = Uri.parse('https://example.com');
    final testToken = OAuthToken('access123', 9999999999, 'refresh123');
    final testWallabagCredentials = WallabagCredentials(
      testUri,
      'clientId',
      'clientSecret',
      token: testToken,
    );

    test(
      'should set selfSignedHost from credentials when useSelfSigned true',
      () {
        final session = ServerSession(
          ServerType.wallabag,
          useSelfSigned: true,
          wallabag: testWallabagCredentials,
        );

        expect(session.selfSignedHost, testUri.host);
      },
    );

    test('should invalidate wallabag session', () {
      final session = ServerSession(
        ServerType.wallabag,
        useSelfSigned: true,
        wallabag: testWallabagCredentials,
      );

      final invalidated = session.invalidated();

      expect(invalidated.isValid, isFalse);
      expect(invalidated.selfSignedHost, testUri.host);
    });

    test('should not invalidate freon session', () {
      final session = ServerSession(
        ServerType.freon,
        freon: TokenBearerCredentials(testUri, 'apiToken'),
      );

      expect(session.invalidated(), session);
    });

    test('should preserve raw JSON string', () {
      const rawJson = '{"type":"wallabag","freon":null,"wallabag":null}';
      final session = ServerSession.fromRawJson(rawJson);

      expect(session.raw, rawJson);
    });
  });
}
