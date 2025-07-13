import 'package:flutter/material.dart';
import 'package:shalat_reminder/features/setting_notifications/data/model/setting_notification_model.dart';
import 'package:shalat_reminder/features/setting_notifications/data/services/notification_service.dart';

/// Widget untuk satu baris pengaturan notifikasi yang telah diperbarui.
class NotificationSettingRow extends StatelessWidget {
  final String prayerName;
  final PrayerNotificationSetting setting;
  final ValueChanged<PrayerNotificationSetting> onChanged;

  const NotificationSettingRow({
    super.key,
    required this.prayerName,
    required this.setting,
    required this.onChanged,
  });

  // FUNGSI BARU UNTUK MENAMPILKAN DIALOG/PICKER
  void _showMinutesPicker(BuildContext context) async {
    // Opsi waktu yang bisa dipilih pengguna
    final List<int> minuteOptions = [5, 10, 15, 20, 30, 45, 60];
    int? selectedValue = setting.reminderMinutes;

    // Menampilkan dialog dan menunggu hasilnya
    final int? newMinutes = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0E1924),
          title: const Text('Pilih Waktu Pengingat',
              style: TextStyle(color: Colors.white)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<int>(
                value: selectedValue,
                dropdownColor: const Color(0xFF1A2A3A),
                style: const TextStyle(color: Colors.white),
                onChanged: (int? value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                items: minuteOptions.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value Menit'),
                  );
                }).toList(),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Batal', style: TextStyle(color: Colors.white70)),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Tutup dialog tanpa mengembalikan nilai
              },
            ),
            TextButton(
              child: const Text('Simpan', style: TextStyle(color: Colors.teal)),
              onPressed: () {
                Navigator.of(context)
                    .pop(selectedValue); // Tutup dialog & kembalikan nilai
              },
            ),
          ],
        );
      },
    );

    // Jika pengguna memilih nilai baru (tidak membatalkan), update state
    if (newMinutes != null) {
      onChanged(setting.copyWith(reminderMinutes: newMinutes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A3A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Baris utama untuk mengaktifkan/menonaktifkan notifikasi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prayerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Switch(
                value: setting.isEnabled,
                onChanged: (newValue) {
                  onChanged(setting.copyWith(isEnabled: newValue));
                },
                activeColor: Colors.teal,
                activeTrackColor: Colors.teal.withOpacity(0.5),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withOpacity(0.4),
              ),
            ],
          ),
          // Tampilkan opsi tambahan hanya jika notifikasi utama aktif
          if (setting.isEnabled)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                children: [
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 8),

                  // Opsi untuk pengingat sebelum adzan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ingatkan sebelum adzan',
                          style: TextStyle(color: Colors.white70)),
                      Switch(
                        value: setting.reminderEnabled,
                        onChanged: (newValue) {
                          onChanged(
                              setting.copyWith(reminderEnabled: newValue));
                        },
                        activeColor: Colors.orange,
                        activeTrackColor: Colors.orange.withOpacity(0.5),
                      ),
                    ],
                  ),

                  // Opsi untuk jenis suara (Adzan/Senyap)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Jenis Suara',
                          style: TextStyle(color: Colors.white70)),
                      DropdownButton<NotificationSoundType>(
                        value: setting.soundType,
                        onChanged: (newValue) {
                          if (newValue != null) {
                            onChanged(setting.copyWith(soundType: newValue));
                          }
                        },
                        dropdownColor: const Color(0xFF1A2A3A),
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white70),
                        items: NotificationSoundType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type == NotificationSoundType.adhan
                                  ? 'Adzan'
                                  : 'Senyap',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Tampilkan pengaturan waktu hanya jika pengingat sebelum adzan aktif
                  if (setting.reminderEnabled)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Waktu pengingat',
                            style: TextStyle(color: Colors.white70)),
                        TextButton(
                          // Panggil fungsi _showMinutesPicker saat ditekan
                          onPressed: () => _showMinutesPicker(context),
                          child: Text(
                            '${setting.reminderMinutes} menit sebelumnya',
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  
                  ElevatedButton(
                    
                    onPressed: () {
                      // Menampilkan notifikasi langsung
                      NotificationService().showNotification(
                        0,
                        "Notifikasi Sederhana",
                        "Ini adalah isi dari notifikasi.",
                      );
                    },
                    child: Text("Tampilkan Notifikasi"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Menjadwalkan notifikasi untuk 10 detik dari sekarang
                      final scheduledTime =
                          DateTime.now().add(Duration(seconds: 10));
                      NotificationService().scheduleNotification(
                        1,
                        "Notifikasi Terjadwal",
                        "Notifikasi ini akan muncul dalam 10 detik.",
                        scheduledTime,
                      );
                    },
                    child: Text("Jadwalkan Notifikasi"),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
