import 'package:flutter/material.dart';
import 'package:shalat_reminder/features/prayer_reminder/data/models/setting_notification_model.dart';
import 'package:shalat_reminder/features/prayer_reminder/data/services/settings_service.dart';

class SettingsProvider with ChangeNotifier {
  final SettingsService _settingsService = SettingsService();
  Map<String, PrayerNotificationSetting> _settings = {};

  Map<String, PrayerNotificationSetting> get settings => _settings;

  SettingsProvider() {
    // Muat pengaturan saat provider pertama kali dibuat
    loadSettings();
  }

  /// Memuat pengaturan dari penyimpanan lokal
  void loadSettings() async {
    _settings = await _settingsService.loadSettings();
    notifyListeners();
  }

  /// Memperbarui satu pengaturan dan langsung menyimpannya
  void updateSetting(String prayerName, PrayerNotificationSetting newSetting) {
    if (_settings.containsKey(prayerName)) {
      _settings[prayerName] = newSetting;
      _settingsService.saveSettings(_settings); // Simpan ke SharedPreferences
      notifyListeners();
    }
  }
}
