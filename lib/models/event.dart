import 'package:pdrnl_events_app/models/location.dart';

class Event {
  final int id;
  final String name;
  final String category;
  final DateTime date;
  final Location location;
  final int maxRegistrations;
  final DateTime startRegistration;
  final DateTime endRegistration;
  final String price;
  final bool visible;
  final String image;

  Event({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.location,
    required this.maxRegistrations,
    required this.startRegistration,
    required this.endRegistration,
    required this.price,
    required this.visible,
    required this.image,
  });

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        date: DateTime.parse(json["date"]),
        location: Location.fromMap(json["location"]),
        maxRegistrations: json["maxRegistrations"],
        startRegistration: DateTime.parse(json["startRegistration"]),
        endRegistration: DateTime.parse(json["endRegistration"]),
        price: json["price"],
        visible: json["visible"] == 0 ? false : true,
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "date": date.toIso8601String(),
        "location": location.toMap(),
        "maxRegistrations": maxRegistrations,
        "startRegistration": startRegistration.toIso8601String(),
        "endRegistration": endRegistration.toIso8601String(),
        "price": price,
        "visible": visible,
        "image": image,
      };
}
