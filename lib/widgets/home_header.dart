import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shalat_reminder/widgets/next_prayer.dart';

class HomeHeader extends StatelessWidget {
  final String backgroundImage;
  final String hijriDate;
  final String nextPrayerName;
  final String nextPrayerTime;
  final String countdown;

  const HomeHeader({
    super.key,
    required this.backgroundImage,
    required this.hijriDate,
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.countdown,
  });

  @override
  Widget build(BuildContext context) {
    final gregorianDate = DateFormat('EEE, d MMM yyyy').format(DateTime.now());

    return Container(
      height: 390,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
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
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(gregorianDate,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(hijriDate,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.white70, size: 16),
                          SizedBox(width: 4),
                          Text("Bukittinggi, Sumbar",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.notifications_none_outlined,
                            color: Colors.white),
                        SizedBox(width: 8),
                        CircleAvatar(radius: 14, backgroundColor: Colors.teal),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              NextPrayerCard(
                prayerName: nextPrayerName,
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
