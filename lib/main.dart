import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shalat_reminder/app.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/providers/prayer_provider.dart';
// import 'package:shalat_reminder/providers/prayer_provider.dart'; // Make sure this import exists

void main() {
  // Set default Hijri Calendar language to Indonesian
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrayerProvider()),
        // Add other providers here if needed
      ],
      child: const ShalatReminderApp(),
    ),
  );
}
