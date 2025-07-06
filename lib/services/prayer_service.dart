import 'package:flutter/material.dart';
import 'package:shalat_reminder/models/prayer_time.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

class PrayerService {
  // Mock data for prayer times. In a real app, this would come from an API.
  final List<Prayer> _prayerTimes = [
    Prayer(name: 'Subuh', time: '04:54', icon: Icons.brightness_4_outlined),
    Prayer(name: 'Dzuhur', time: '12:17', icon: Icons.wb_sunny_outlined),
    Prayer(name: 'Ashar', time: '15:39', icon: Icons.brightness_5_outlined),
    Prayer(name: 'Maghrib', time: '18:18', icon: Icons.brightness_6_outlined),
    Prayer(name: 'Isya', time: '19:29', icon: Icons.dark_mode_outlined),
  ];

  List<Prayer> get prayerTimes => _prayerTimes;

  int findNextPrayerIndex() {
    final now = DateTime.now();
    for (int i = 0; i < _prayerTimes.length; i++) {
      final timeParts = _prayerTimes[i].time.split(':');
      final prayerTime = DateTime(now.year, now.month, now.day,
          int.parse(timeParts[0]), int.parse(timeParts[1]));
      if (prayerTime.isAfter(now)) {
        return i;
      }
    }
    // If all prayers for today have passed, the next one is Subuh tomorrow.
    return 0;
  }

  String getCountdown(int nextPrayerIndex) {
    final now = DateTime.now();
    final timeParts = _prayerTimes[nextPrayerIndex].time.split(':');

    var prayerTime = DateTime(now.year, now.month, now.day,
        int.parse(timeParts[0]), int.parse(timeParts[1]));

    // If the next prayer is for tomorrow (e.g., Subuh after Isya).
    if (prayerTime.isBefore(now)) {
      prayerTime = prayerTime.add(const Duration(days: 1));
    }

    final difference = prayerTime.difference(now);

    if (difference.isNegative) {
      return "Waktu telah tiba";
    }

    final hours = difference.inHours.toString().padLeft(2, '0');
    final minutes =
        difference.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        difference.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '-$hours:$minutes:$seconds';
  }

  String getTimeBasedBackground() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 10) return 'assets/images/morning.jpeg';
    if (hour >= 10 && hour < 15) return 'assets/images/afternoon.jpeg';
    if (hour >= 15 && hour < 18) return 'assets/images/evening.jpeg';
    if (hour >= 18 && hour < 20) return 'assets/images/night.jpeg';
    if (hour >= 20 && hour < 24) return 'assets/images/latenight.jpeg';
    return 'assets/images/midnight.jpeg'; // For hours 0-4
  }

  String getFormattedHijriDate() {
    final hijri = HijriCalendarConfig.now();
    return hijri.toFormat("EEEE, d MMMM yyyy H");
  }
}
