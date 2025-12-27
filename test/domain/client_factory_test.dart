import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/domain/client_factory.dart';
import 'package:frigoligo/domain/models/server_session.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:frigoligo/server/clients.dart';
import 'package:frigoligo/server/src/clients/wallabag.dart';
import 'package:mocktail/mocktail.dart';

class MockServerSessionRepository extends Mock
    implements ServerSessionRepository {}

void main() {
  const testUserAgent = 'TestApp/1.0.0+1';

  late MockServerSessionRepository mockRepository;

  setUp(() {
    mockRepository = MockServerSessionRepository();
  });

  group('createClient extension method', () {
    test('creates FreonClient when session type is Freon', () {
      final session = ServerSession(
        ServerType.freon,
        freon: TokenBearerCredentials(
          Uri.parse('https://example.com'),
          'token123',
        ),
      );
      when(() => mockRepository.getSession()).thenReturn(session);

      final client = mockRepository.createClient(userAgent: testUserAgent);

      expect(client, isA<FreonClient>());
    });

    test('creates WallabagClient when session type is Wallabag', () {
      final token = OAuthToken('access_token', 9999999999, 'refresh_token');
      final session = ServerSession(
        ServerType.wallabag,
        wallabag: WallabagCredentials(
          Uri.parse('https://example.com'),
          'id',
          'secret',
          token: token,
        ),
      );
      when(() => mockRepository.getSession()).thenReturn(session);

      final client = mockRepository.createClient(userAgent: testUserAgent);

      expect(client, isA<WallabagClient>());
    });

    test('throws StateError when session is null', () {
      when(() => mockRepository.getSession()).thenReturn(null);

      expect(
        () => mockRepository.createClient(userAgent: testUserAgent),
        throwsStateError,
      );
    });

    test('throws ServerError when session is invalid', () {
      final session = ServerSession(
        ServerType.wallabag,
        wallabag: WallabagCredentials(
          Uri.parse('https://example.com'),
          'id',
          'secret',
        ),
      );
      when(() => mockRepository.getSession()).thenReturn(session);

      expect(
        () => mockRepository.createClient(userAgent: testUserAgent),
        throwsA(isA<ServerError>()),
      );
    });
  });
}
