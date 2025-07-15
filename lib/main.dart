import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:shalat_reminder/app.dart';
import 'package:shalat_reminder/features/prayer_reminder/data/services/notification_service.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/providers/prayer_provider.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/providers/settings_provider.dart';

Future<void> main() async {
  // Pastikan binding siap
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi format tanggal untuk bahasa Indonesia
  await initializeDateFormatting('id_ID', null);
  await NotificationService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProxyProvider<SettingsProvider, PrayerProvider>(
          create: (context) => PrayerProvider(context.read<SettingsProvider>()),
          update: (context, settingsProvider, _) =>
              PrayerProvider(settingsProvider),
        ),
      ],
      child: const ShalatReminderApp(),
    ),
  );
}
// Salama Ahora