// coverage:ignore-file
import 'dart:async';

import '../config/dependencies.dart';
import '../data/services/local/storage/config_store_service.dart';
import '../data/services/local/storage/storage_service.dart';
import '../data/services/platform/appbadge_service.dart';
import '../domain/sync/sync_manager.dart';
import '../pigeon/settings.g.dart';
import '../providers/settings.dart';

class SettingsBridge implements SettingsFlutterApi {
  SettingsBridge({required ConfigStoreService configStoreService})
    : _configStoreService = configStoreService {
    SettingsFlutterApi.setUp(this);
    _appBadgeSubscription = configStoreService
        .watch<bool>(Sk.appBadge.key)
        .listen(
          (_) => unawaited(_api.updateAppSettings(_buildCurrentAppSettings())),
        );
    _tagSaveEnabledSubscription = configStoreService
        .watch<bool>(Sk.tagSaveEnabled.key)
        .listen(
          (_) => unawaited(_api.updateAppSettings(_buildCurrentAppSettings())),
        );
    _tagSaveLabelSubscription = configStoreService
        .watch<String>(Sk.tagSaveLabel.key)
        .listen(
          (_) => unawaited(_api.updateAppSettings(_buildCurrentAppSettings())),
        );
  }

  final ConfigStoreService _configStoreService;
  final SettingsApi _api = SettingsApi();

  StreamSubscription<bool?>? _appBadgeSubscription;
  StreamSubscription<bool?>? _tagSaveEnabledSubscription;
  StreamSubscription<String?>? _tagSaveLabelSubscription;

  AppSettings _buildCurrentAppSettings() {
    return AppSettings(
      appBadge: _configStoreService.get<bool>(Sk.appBadge.key) ?? false,
      tagSaveEnabled:
          _configStoreService.get<bool>(Sk.tagSaveEnabled.key) ?? false,
      tagSaveLabel:
          _configStoreService.get<String>(Sk.tagSaveLabel.key) ?? 'inbox',
    );
  }

  @override
  Future<void> setAppSettings(AppSettings settings) async {
    final current = _buildCurrentAppSettings();
    if (settings.appBadge != current.appBadge) {
      await _configStoreService.set(Sk.appBadge.key, settings.appBadge);
    }
    if (settings.tagSaveEnabled != current.tagSaveEnabled) {
      await _configStoreService.set(
        Sk.tagSaveEnabled.key,
        settings.tagSaveEnabled,
      );
    }
    if (settings.tagSaveLabel != current.tagSaveLabel) {
      await _configStoreService.set(Sk.tagSaveLabel.key, settings.tagSaveLabel);
    }
  }

  @override
  Future<void> clearCache() async {
    final storage = dependencies.get<LocalStorageService>();
    final appBadge = dependencies.get<AppBadgeService>();
    await storage.database.clear(keepPositions: true);
    final badgeEnabled =
        _configStoreService.get<bool>(Sk.appBadge.key) ?? false;
    if (badgeEnabled) {
      final unread = await storage.articles.countUnread();
      await appBadge.update(unread);
    }
    unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
  }

  void dispose() {
    _appBadgeSubscription?.cancel();
    _tagSaveEnabledSubscription?.cancel();
    _tagSaveLabelSubscription?.cancel();
  }
}
