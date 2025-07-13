import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shalat_reminder/core/router/app_routes.dart';
// import 'package:shalat_reminder/screens/home.dart';

class ShalatReminderApp extends StatelessWidget {
  const ShalatReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Shalat Reminder',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF0E1924),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
