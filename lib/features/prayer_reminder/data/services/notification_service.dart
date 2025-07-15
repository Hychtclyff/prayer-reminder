// lib/services/notification_service.dart

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  // Setup Singleton
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Inisialisasi dan pembuatan channel
  Future<void> init() async {
    AwesomeNotifications().initialize(
      'resource://mipmap/ic_launcher',
      [
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          channelDescription: 'Channel untuk pengingat sholat',
          defaultColor: Colors.teal,
          importance: NotificationImportance.Max,
          // soundSource: 'resource://raw/adzan',
          
        )
      ],
      debug: true,
    );
    // Minta izin
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  /// Method sederhana untuk menjadwalkan notifikasi sholat harian
  Future<void> scheduleDailyPrayerNotification(
      int id, String prayerName, int hour, int minute) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: 'Waktunya Sholat $prayerName',
        body: 'Saatnya menunaikan sholat $prayerName.',
        notificationLayout: NotificationLayout.Default,
        fullScreenIntent: true, // Agar muncul seperti alarm
      ),
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        second: 0,
        repeats: true, // Otomatis berulang setiap hari
      ),
    );
  }

  /// Method untuk membatalkan semua notifikasi
  Future<void> cancelAllSchedules() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
