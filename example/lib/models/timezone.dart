// ignore: file_names
class Timezone {
  String iso_3166_1;
  List<String> zones;

  Timezone({
    required this.iso_3166_1,
    required this.zones,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      iso_3166_1: json['iso_3166_1'],
      zones: List<String>.from(json['zones']),
    );
  }

  Map<String, dynamic> toJson() => {
        'iso_3166_1': iso_3166_1,
        'zones': zones,
      };
}
