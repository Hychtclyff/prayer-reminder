import 'dart:convert';
import 'package:shalat_reminder/features/prayer_reminder/data/models/setting_notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shalat_reminder/core/constants/app_constants.dart';

class SettingsService {
  static const _settingsKey = 'notification_settings';

  /// Menyimpan semua data pengaturan ke SharedPreferences
  Future<void> saveSettings(
      Map<String, PrayerNotificationSetting> settings) async {
    final prefs = await SharedPreferences.getInstance();
    // Ubah Map<String, Object> menjadi Map<String, Map<String, dynamic>>
    final mapToSave =
        settings.map((key, value) => MapEntry(key, value.toJson()));
    // Ubah Map menjadi string JSON untuk disimpan
    await prefs.setString(_settingsKey, json.encode(mapToSave));
  }

  /// Membaca semua data pengaturan dari SharedPreferences
  Future<Map<String, PrayerNotificationSetting>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_settingsKey);

    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      // Ubah kembali dari JSON ke objek PrayerNotificationSetting
      return jsonMap.map((key, value) =>
          MapEntry(key, PrayerNotificationSetting.fromJson(value)));
    } else {
      // Jika belum ada data tersimpan, kembalikan pengaturan default
      return {
        for (var prayer in prayerTimesMock)
          prayer['name'] as String: PrayerNotificationSetting(),
      };
    }
  }
}
