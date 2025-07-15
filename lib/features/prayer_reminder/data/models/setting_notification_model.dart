import 'dart:convert';

PrayerNotificationSetting prayerNotificationSettingFromJson(String str) =>
    PrayerNotificationSetting.fromJson(json.decode(str));

String prayerNotificationSettingToJson(PrayerNotificationSetting data) =>
    json.encode(data.toJson());

enum NotificationSoundType { adhan, silent }

class PrayerNotificationSetting {
  final bool isEnabled;
  final bool reminderEnabled;
  final int reminderMinutes;
  final NotificationSoundType soundType;

  PrayerNotificationSetting({
    this.isEnabled = true,
    this.reminderEnabled = false,
    this.reminderMinutes = 10,
    this.soundType = NotificationSoundType.adhan,
  });

  PrayerNotificationSetting copyWith({
    bool? isEnabled,
    bool? reminderEnabled,
    int? reminderMinutes,
    NotificationSoundType? soundType,
  }) {
    return PrayerNotificationSetting(
      isEnabled: isEnabled ?? this.isEnabled,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      soundType: soundType ?? this.soundType,
    );
  }

  factory PrayerNotificationSetting.fromJson(Map<String, dynamic> json) {
    return PrayerNotificationSetting(
      isEnabled: json['isEnabled'] ?? true,
      reminderEnabled: json['reminderEnabled'] ?? false,
      reminderMinutes: json['reminderMinutes'] ?? 10,
      soundType: NotificationSoundType.values.firstWhere(
        (e) => e.name == json['soundType'],
        orElse: () => NotificationSoundType.adhan,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'reminderEnabled': reminderEnabled,
      'reminderMinutes': reminderMinutes,
      'soundType': soundType.name,
    };
  }
}
