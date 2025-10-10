import '../../domain/repositories.dart';
import '../services/local/storage/storage_service.dart';

class TagRepositoryImpl implements TagRepository {
  const TagRepositoryImpl({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;

  @override
  Future<List<String>> getAll() async {
    final tags = await _localStorageService.tags.getAll();
    tags.sort();
    return tags;
  }
}
