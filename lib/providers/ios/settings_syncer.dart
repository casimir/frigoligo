import 'package:logging/logging.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';

import '../settings.dart';

final _log = Logger('settings.ios.syncer');

class SettingsSyncer {
  SettingsSyncer(this.settings);

  final Settings settings;

  Future<bool> _isSet() async =>
      await SharedPreferenceAppGroup.get(Sk.tagSaveLabel.key) != null;

  Future<void> onChange(Sk skey, dynamic value) async {
    if (skey == Sk.tagSaveEnabled || skey == Sk.tagSaveLabel) {
      if (settings.get(Sk.tagSaveEnabled)) {
        _log.info('saving tag label: ${settings.get(Sk.tagSaveLabel)}');
        SharedPreferenceAppGroup.setString(
            Sk.tagSaveLabel.key, settings.get(Sk.tagSaveLabel));
      } else if (await _isSet()) {
        _log.info('clearing tag label');
        SharedPreferenceAppGroup.remove(Sk.tagSaveLabel.key);
      }
    }
  }

  Future<void> onClear() async {
    if (await _isSet()) {
      _log.info('clearing tag label');
      SharedPreferenceAppGroup.remove(Sk.tagSaveLabel.key);
    }
  }
}
