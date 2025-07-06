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
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.tealAccent.withOpacity(0.8), size: 24),
            const SizedBox(width: 16),
            Text(name,
                style: const TextStyle(fontSize: 17, color: Colors.white70)),
            const Spacer(),
            Text(time,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
