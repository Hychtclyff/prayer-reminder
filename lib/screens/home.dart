import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shalat_reminder/widgets/list_prayer.dart';
import 'package:shalat_reminder/widgets/next_prayer.dart';
import 'package:intl/intl.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

// Mock data for prayer times. In a real app, this would come from an API.
final List<Map<String, dynamic>> prayerTimes = [
  {'name': 'Subuh', 'time': '04:54', 'icon': Icons.brightness_4_outlined},
  {'name': 'Dzuhur', 'time': '12:17', 'icon': Icons.wb_sunny_outlined},
  {'name': 'Ashar', 'time': '15:39', 'icon': Icons.brightness_5_outlined},
  {'name': 'Maghrib', 'time': '18:18', 'icon': Icons.brightness_6_outlined},
  {'name': 'Isya', 'time': '19:29', 'icon': Icons.dark_mode_outlined},
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  String _countdown = '';
  int _nextPrayerIndex = 0;
  final hijri = HijriCalendarConfig.now();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _findNextPrayer() {
    final now = DateTime.now();
    for (int i = 0; i < prayerTimes.length; i++) {
      final timeParts = prayerTimes[i]['time'].split(':');
      final prayerTime = DateTime(now.year, now.month, now.day,
          int.parse(timeParts[0]), int.parse(timeParts[1]));
      if (prayerTime.isAfter(now)) {
        setState(() {
          _nextPrayerIndex = i;
        });
        return;
      }
    }
    setState(() {
      _nextPrayerIndex = 0;
    });
  }

  void _startTimer() {
    _findNextPrayer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _findNextPrayer();
      final now = DateTime.now();
      final timeParts = prayerTimes[_nextPrayerIndex]['time'].split(':');

      var prayerTime = DateTime(now.year, now.month, now.day,
          int.parse(timeParts[0]), int.parse(timeParts[1]));
      if (prayerTime.isBefore(now)) {
        prayerTime = prayerTime.add(const Duration(days: 1));
      }

      final difference = prayerTime.difference(now);

      setState(() {
        _countdown = difference.isNegative
            ? "Waktu telah tiba"
            : '-${difference.inHours.toString().padLeft(2, '0')}:'
                '${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
                '${difference.inSeconds.remainder(60).toString().padLeft(2, '0')}';
      });
    });
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
    return Scaffold(
      body: Column(
        children: [
          // Static Header
          Container(
            height: 390,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_getTimeBasedBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(1.0),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date and Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEE, d MMM yyyy')
                                  .format(DateTime.now()),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              _formatHijriDate(hijri),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'NotoNaskhArabic', // Font Arab
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white70, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  "Bukittinggi, Sumbar",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Notification and Profile Icons
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.3)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.notifications_none_outlined,
                                  color: Colors.white),
                              SizedBox(width: 8),
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.teal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Next Prayer Card
                    NextPrayerCard(
                      prayerName: prayerTimes[_nextPrayerIndex]['name'],
                      prayerTime: prayerTimes[_nextPrayerIndex]['time'],
                      countdown: _countdown,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Scrollable Prayer List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: prayerTimes.length - 1,
              itemBuilder: (context, index) {
                final actualIndex =
                    (index >= _nextPrayerIndex) ? index + 1 : index;
                if (actualIndex >= prayerTimes.length) return null;

                final prayer = prayerTimes[actualIndex];
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
