import 'dart:ffi';

class Location {
  final int id;
  final String name;
  final String category;
  final String city;
  final String latitude;
  final String longitude;

  Location({
    required this.id,
    required this.name,
    required this.category,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        city: json["city"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
      };
}
