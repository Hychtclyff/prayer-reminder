import 'package:flutter/material.dart';

class PrayerTimeRow extends StatelessWidget {
  final String name;
  final String time;
  final IconData icon;

  const PrayerTimeRow({
    super.key,
    required this.name,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 16),
          Text(name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(time,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
