import 'dart:convert';

PrayerTimeModel prayerTimeModelFromJson(String str) =>
    PrayerTimeModel.fromJson(json.decode(str));

String prayerTimeModelToJson(PrayerTimeModel data) =>
    json.encode(data.toJson());

class PrayerTimeModel {
  final String tanggal;
  final String lokasi;
  final String subuh;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;

  PrayerTimeModel({
    required this.tanggal,
    required this.lokasi,
    required this.subuh,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) =>
      PrayerTimeModel(
        tanggal: json["tanggal"],
        lokasi: json["lokasi"],
        subuh: json["subuh"],
        dzuhur: json["dzuhur"],
        ashar: json["ashar"],
        maghrib: json["maghrib"],
        isya: json["isya"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "lokasi": lokasi,
        "subuh": subuh,
        "dzuhur": dzuhur,
        "ashar": ashar,
        "maghrib": maghrib,
        "isya": isya,
      };
}
