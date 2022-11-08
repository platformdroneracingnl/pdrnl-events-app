class Event {
  final int id;
  final String name;
  final String category;
  final DateTime date;
  final int maxRegistrations;
  final DateTime startRegistration;
  final DateTime endRegistration;
  final String price;
  final bool visible;

  Event({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.maxRegistrations,
    required this.startRegistration,
    required this.endRegistration,
    required this.price,
    required this.visible,
  });

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        date: DateTime.parse(json["date"]),
        maxRegistrations: json["maxRegistrations"],
        startRegistration: DateTime.parse(json["startRegistration"]),
        endRegistration: DateTime.parse(json["endRegistration"]),
        price: json["price"],
        visible: json["visible"] == 0 ? false : true,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "date": date.toIso8601String(),
        "maxRegistrations": maxRegistrations,
        "startRegistration": startRegistration.toIso8601String(),
        "endRegistration": endRegistration.toIso8601String(),
        "price": price,
        "visible": visible,
      };
}
