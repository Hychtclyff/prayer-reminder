// lib/features/prayer_time/presentation/providers/prayer_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shalat_reminder/features/prayer_reminder/data/services/prayer_time_service.dart';
import 'package:shalat_reminder/core/constants/app_constants.dart';
// Impor service dan data mock Anda

class PrayerProvider with ChangeNotifier {
  final PrayerTimeService _service = PrayerTimeService();
  
  late Timer _timer;
  String _countdown = '';
  int _nextPrayerIndex = 0;

  String get countdown => _countdown;
  int get nextPrayerIndex => _nextPrayerIndex;

  PrayerProvider() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 1. Panggil service untuk mendapatkan index
      _nextPrayerIndex = _service.findNextPrayerIndex(prayerTimesMock);
      
      final now = DateTime.now();
      final timeParts = prayerTimesMock[_nextPrayerIndex]['time'].split(':');
      var prayerTime = DateTime(now.year, now.month, now.day,
          int.parse(timeParts[0]), int.parse(timeParts[1]));

      if (prayerTime.isBefore(now)) {
        prayerTime = prayerTime.add(const Duration(days: 1));
      }

      // 2. Panggil service untuk menghitung countdown
      _countdown = _service.calculateCountdown(prayerTime);
      
      // 3. Beri tahu UI untuk update, ini pengganti setState()
      notifyListeners(); 
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}