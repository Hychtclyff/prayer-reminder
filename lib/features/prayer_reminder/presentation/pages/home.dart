// lib/features/prayer_reminder/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shalat_reminder/core/constants/app_constants.dart';
import 'package:shalat_reminder/core/router/app_routes.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/providers/prayer_provider.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/widgets/home_header_widget.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/widgets/prayer_time_row_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String _gregorianDate = '';
  String _hijriDate = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setDate();
  }

  void _setDate() {
    final now = DateTime.now();
    final hijri = HijriCalendarConfig.now();
    _gregorianDate = DateFormat('EEE, d MMM yyyy', 'id_ID').format(now);
    _hijriDate = _formatHijriDate(hijri);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final prayerProvider = context.read<PrayerProvider>();

    switch (state) {
      case AppLifecycleState.resumed:
        prayerProvider.startUiTimer();
        setState(() =>
            _setDate()); // Update tanggal jika aplikasi dibuka di hari berbeda
        break;
      case AppLifecycleState.paused:
        prayerProvider.stopUiTimer();
        break;
      default:
        break;
    }
  }

  String get _getTimeBasedBackground {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 10) return 'assets/images/morning.jpeg';
    if (hour >= 10 && hour < 17) return 'assets/images/afternoon.jpeg';
    if (hour >= 17 && hour < 21) return 'assets/images/evening.jpeg';
    if (hour >= 21 && hour < 24) return 'assets/images/night.jpeg';
    if (hour >= 0 && hour < 5) return 'assets/images/midnight.jpeg';
    return 'assets/images/latenight.jpeg'; // fallback
  }

  String _formatHijriDate(HijriCalendarConfig hijri) {
    final monthNames = {
      1: 'Muharram',
      2: 'Safar',
      3: 'Rabi\' al-Awwal',
      4: 'Rabi\' al-Thani',
      5: 'Jumada al-Awwal',
      6: 'Jumada al-Thani',
      7: 'Rajab',
      8: 'Sha\'ban',
      9: 'Ramadan',
      10: 'Shawwal',
      11: 'Dhu al-Qi\'dah',
      12: 'Dhu al-Hijjah'
    };

    final dayNames = {
      1: 'al-Ithnayn',
      2: 'al-Thulatha',
      3: 'al-Arba\'a',
      4: 'al-Khamis',
      5: 'al-Jumu\'ah',
      6: 'al-Sabt',
      7: 'al-Ahad'
    };

    return '${dayNames[hijri.wkDay]}, ${hijri.hDay} ${monthNames[hijri.hMonth]} ${hijri.hYear} H';
  }

  @override
  Widget build(BuildContext context) {
    final prayerProvider = context.watch<PrayerProvider>();
    final nextPrayerIndex = prayerProvider.nextPrayerIndex;
    final sortedPrayerTimes = prayerTimesMock.sublist(nextPrayerIndex)
      ..addAll(prayerTimesMock.sublist(0, nextPrayerIndex));

    return Scaffold(
      body: Column(
        children: [
          HomeHeader(
            gregorianDate: _gregorianDate,
            hijriDate: _hijriDate,
            location: "Bukittinggi, Sumbar",
            backgroundImagePath: _getTimeBasedBackground,
            nextPrayerName: prayerTimesMock[nextPrayerIndex]['name'],
            nextPrayerTime: prayerTimesMock[nextPrayerIndex]['time'],
            countdown: prayerProvider.countdown,
            onNotificationTap: () =>
                context.goNamed(AppRoutes.notificationSettings),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: sortedPrayerTimes.length,
              itemBuilder: (context, index) {
                final prayer = sortedPrayerTimes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: PrayerTimeRow(
                    name: prayer['name'],
                    time: prayer['time'],
                    icon: prayer['icon'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
