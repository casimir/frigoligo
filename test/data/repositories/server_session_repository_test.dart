import 'package:frigoligo/data/repositories/server_session_repository.dart';
import 'package:frigoligo/data/services/local/storage/config_store_backends/in_memory_backend.dart';
import 'package:frigoligo/data/services/local/storage/config_store_service.dart';
import 'package:frigoligo/domain/models/server_session.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:frigoligo/server/clients.dart';
import 'package:test/test.dart';

void main() {
  group('ServerSessionRepositoryImpl', () {
    late ConfigStoreService configStoreService;
    late ServerSessionRepository repository;

    setUp(() async {
      final backend = InMemoryBackend();
      configStoreService = ConfigStoreService(backend);
      await configStoreService.initialize();
      repository = ServerSessionRepositoryImpl(
        configStoreService: configStoreService,
      );
    });

    tearDown(() {
      configStoreService.dispose();
    });

    test('returns null when no session stored', () {
      expect(repository.getSession(), isNull);
    });

    test('saves and retrieves session', () async {
      final session = ServerSession(
        ServerType.wallabag,
        wallabag: WallabagCredentials(
          Uri.parse('https://example.com'),
          'client-id',
          'client-secret',
        ),
      );

      await repository.save(session);

      final retrieved = repository.getSession();
      expect(retrieved!.type, ServerType.wallabag);
      expect(retrieved.wallabag!.server.toString(), 'https://example.com');
    });

    test('overwrites existing session', () async {
      await repository.save(
        ServerSession(
          ServerType.wallabag,
          wallabag: WallabagCredentials(
            Uri.parse('https://old.example.com'),
            'old-id',
            'old-secret',
          ),
        ),
      );
      await repository.save(
        ServerSession(
          ServerType.freon,
          freon: TokenBearerCredentials(
            Uri.parse('https://new.example.com'),
            'new-token',
          ),
        ),
      );

      final retrieved = repository.getSession();
      expect(retrieved!.type, ServerType.freon);
      expect(retrieved.freon!.server.toString(), 'https://new.example.com');
    });

    test('clears session', () async {
      await repository.save(
        ServerSession(
          ServerType.wallabag,
          wallabag: WallabagCredentials(
            Uri.parse('https://example.com'),
            'client-id',
            'client-secret',
          ),
        ),
      );

      await repository.clear();

      expect(repository.getSession(), isNull);
    });
  });
}
