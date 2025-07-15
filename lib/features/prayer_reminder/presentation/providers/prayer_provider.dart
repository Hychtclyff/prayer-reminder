// lib/features/prayer_reminder/presentation/providers/prayer_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shalat_reminder/core/constants/app_constants.dart';
import 'package:shalat_reminder/features/prayer_reminder/data/services/prayer_time_service.dart';
import 'package:shalat_reminder/features/prayer_reminder/data/services/notification_service.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/providers/settings_provider.dart';

class PrayerProvider with ChangeNotifier {
  final PrayerTimeService _service = PrayerTimeService();
  final NotificationService _notificationService = NotificationService();
  final SettingsProvider _settingsProvider;

  Timer? _uiTimer;
  String _countdown = '';
  int _nextPrayerIndex = 0;

  String get countdown => _countdown;
  int get nextPrayerIndex => _nextPrayerIndex;

  PrayerProvider(this._settingsProvider) {
    scheduleAllPrayerNotifications();
    startUiTimer();
  }

  Future<void> scheduleAllPrayerNotifications() async {
    // Ambil data pengaturan dari provider yang sudah di-inject
    final settingsMap = _settingsProvider.settings;
    if (settingsMap.isEmpty) return; // Tunggu sampai settings selesai di-load

    await _notificationService.cancelAllSchedules();

    for (int i = 0; i < prayerTimesMock.length; i++) {
      final prayer = prayerTimesMock[i];
      final prayerName = prayer['name'] as String;

      // Ambil pengaturan untuk sholat saat ini
      final setting = settingsMap[prayerName];

      // Periksa apakah notifikasi untuk sholat ini diaktifkan
      if (setting != null && setting.isEnabled) {
        final timeParts = (prayer['time'] as String).split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);

        if (setting.reminderEnabled) {
          await _notificationService.scheduleReminderPrayerNotification(
            i + 200, // Gunakan ID yang unik!
            prayerName,
            hour,
            minute,
            setting.reminderMinutes, // Ambil durasi dari pengaturan pengguna
          );
          print(
              'Pengingat untuk $prayerName ${setting.reminderMinutes} telah diatur.');
        }

        await _notificationService.scheduleDailyPrayerNotification(
          i,
          prayerName,
          hour,
          minute,
        );
        print('Jadwal untuk $prayerName (${prayer['time']}) telah diatur.');
      }
    }
  }

  /// Memulai timer HANYA untuk memperbarui countdown di UI.
  void startUiTimer() {
    // Hentikan timer lama jika ada, untuk menghindari duplikasi
    _uiTimer?.cancel();

    _uiTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      _nextPrayerIndex = _service.findNextPrayerIndex(prayerTimesMock);

      final timeParts = prayerTimesMock[_nextPrayerIndex]['time'].split(':');
      var prayerTime = DateTime(now.year, now.month, now.day,
          int.parse(timeParts[0]), int.parse(timeParts[1]));

      if (prayerTime.isBefore(now)) {
        prayerTime = prayerTime.add(const Duration(days: 1));
      }

      _countdown = _service.calculateCountdown(prayerTime);

      // Tidak ada lagi logika notifikasi di sini!
      notifyListeners();
    });
  }

  /// Menghentikan timer UI untuk menghemat baterai.
  void stopUiTimer() {
    _uiTimer?.cancel();
  }

  @override
  void dispose() {
    stopUiTimer(); // Pastikan timer berhenti saat provider dihapus
    super.dispose();
  }
}
