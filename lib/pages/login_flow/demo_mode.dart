import 'dart:io';

import '../../config/dependencies.dart';
import '../../data/demo.dart';
import '../../data/services/local/storage/storage_service.dart';
import '../../domain/models/server_session.dart';
import '../../server/clients.dart';

Future<void> setupDemoMode(
  LocalStorageService localStorageService,
  ServerSessionRepository serverSessionRepository,
) async {
  final session = ServerSession(ServerType.local);
  await serverSessionRepository.save(session);

  final content = File('assets/sample-articles.json').readAsStringSync();
  await loadSampleArticles(localStorageService.db, content);
}
