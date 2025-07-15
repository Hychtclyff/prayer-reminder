import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shalat_reminder/app.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/providers/prayer_provider.dart';
import 'package:shalat_reminder/features/prayer_reminder/data/services/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      // Gunakan 'resource://drawable/nama_file_ikon'
      'resource://mipmap/ic_launcher',
      [
        // Channel untuk notifikasi biasa
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Colors.teal,
            ledColor: Colors.white,
            importance: NotificationImportance.High),
        // Channel untuk notifikasi terjadwal (Adzan)
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          channelDescription: 'Notification channel for prayer reminders',
          defaultColor: Colors.teal,
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          // soundSource: 'resource://raw/adzan' // Suara adzan Anda
        )
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Minta izin ke pengguna
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  await initializeDateFormatting('id_ID', null);
  // Panggil instance singleton yang sama untuk semua operasi
  final notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestPermissions();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrayerProvider()),
        // Tambahkan provider lain di sini jika dibutuhkan
      ],
      child: const ShalatReminderApp(),
    ),
  );
}
