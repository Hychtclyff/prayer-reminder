import 'package:flutter/material.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/widgets/next_prayer.dart';

class HomeHeader extends StatelessWidget {
  // Data yang dibutuhkan oleh widget ini
  final String gregorianDate;
  final String hijriDate;
  final String location;
  final String backgroundImagePath;
  final String nextPrayerName;
  final String nextPrayerTime;
  final String countdown;
  final VoidCallback onNotificationTap; // Callback untuk tombol notifikasi

  const HomeHeader({
    super.key,
    required this.gregorianDate,
    required this.hijriDate,
    required this.location,
    required this.backgroundImagePath,
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.countdown,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImagePath), // Gunakan data dari parameter
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
                        gregorianDate, // Gunakan data dari parameter
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        hijriDate, // Gunakan data dari parameter
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'NotoNaskhArabic',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            location, // Gunakan data dari parameter
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: onNotificationTap, // Gunakan callback dari parameter
                    customBorder: const CircleBorder(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: const Icon(Icons.notifications_none_outlined,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Next Prayer Card - Diasumsikan sudah menjadi widget sendiri
              NextPrayerCard(
                prayerName: nextPrayerName, // Gunakan data dari parameter
                prayerTime: nextPrayerTime,
                countdown: countdown,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
