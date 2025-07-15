import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Private constructor agar kelas ini tidak bisa diinstansiasi
  AppTheme._();

  // TEMA GELAP (DARK THEME)
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: const Color(0xFF0E1924),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
  );

  // --- TEMA TERANG (LIGHT THEME) ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    // Gunakan warna latar yang cerah, misal sedikit abu-abu agar tidak silau
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    // Gunakan tema teks terang agar warna teks menjadi hitam
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
    useMaterial3: true,
  );
}
