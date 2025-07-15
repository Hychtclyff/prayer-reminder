// lib/features/prayer_time/services/prayer_time_service.dart

class PrayerTimeService {
  // Fungsi ini hanya mencari index dan mengembalikannya.
  int findNextPrayerIndex(List<Map<String, dynamic>> prayerTimes) {
    final now = DateTime.now();
    for (int i = 0; i < prayerTimes.length; i++) {
      final timeParts = prayerTimes[i]['time'].split(':');
      final prayerTime = DateTime(now.year, now.month, now.day,
          int.parse(timeParts[0]), int.parse(timeParts[1]));

      if (prayerTime.isAfter(now)) {
        return i;
      }
    }
    return 0; // Jika tidak ada, kembali ke Subuh hari berikutnya.
  }

  // Fungsi ini hanya menghitung mundur dan mengembalikan string.
  String calculateCountdown(DateTime prayerTime) {
    final now = DateTime.now();
    final difference = prayerTime.difference(now);

    if (difference.isNegative) return "Waktu telah tiba";

    

    return '-${difference.inHours.toString().padLeft(2, '0')}:'
        '${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
        '${difference.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}
