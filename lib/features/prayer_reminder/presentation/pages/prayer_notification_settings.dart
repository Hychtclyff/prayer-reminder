import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shalat_reminder/features/prayer_reminder/data/models/setting_notification_model.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/widgets/notification_setting_row_widget.dart';
import 'package:shalat_reminder/core/constants/app_constants.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  final Map<String, PrayerNotificationSetting> _notificationSettings = {
    for (var prayer in prayerTimesMock)
      prayer['name'] as String: PrayerNotificationSetting(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Notifikasi'),
        backgroundColor: const Color(0xFF0E1924),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 16.0, top: 10.0),
              child: Text(
                'Atur pengingat untuk setiap waktu sholat. Anda dapat memilih untuk mengaktifkan notifikasi berupa suara adzan atau hanya pengingat senyap.',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: prayerTimesMock.length,
                itemBuilder: (context, index) {
                  final prayer = prayerTimesMock[index];
                  final prayerName = prayer['name'];
                  final currentSetting = _notificationSettings[prayerName]!;

                  return NotificationSettingRow(
                    prayerName: prayerName,
                    setting: currentSetting,
                    onChanged: (newSetting) {
                      setState(() {
                        _notificationSettings[prayerName] = newSetting;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Pengaturan untuk $prayerName diperbarui'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
