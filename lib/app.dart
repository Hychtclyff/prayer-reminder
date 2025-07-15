import 'package:flutter/material.dart';
import 'package:shalat_reminder/core/router/app_routes.dart';
// import 'package:shalat_reminder/screens/home.dart';
import 'package:shalat_reminder/core/theme/app_theme.dart';

class ShalatReminderApp extends StatelessWidget {
  const ShalatReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Shalat Reminder',
      // Atur tema di sini
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      routerConfig: AppRouter.router,
    );
  }
}
