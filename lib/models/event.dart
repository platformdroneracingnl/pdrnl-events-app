class LocalEvent {
  final int id;
  final String name;
  final String category;
  final DateTime date;
  final int maxRegistrations;
  final DateTime startRegistration;
  final DateTime endRegistration;
  final int price;

  LocalEvent({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.maxRegistrations,
    required this.startRegistration,
    required this.endRegistration,
    required this.price,
  });

  factory LocalEvent.fromMap(Map<String, dynamic> json) => LocalEvent(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        date: DateTime.parse(json["date"]),
        maxRegistrations: json["maxRegistrations"],
        startRegistration: DateTime.parse(json["startRegistration"]),
        endRegistration: DateTime.parse(json["endRegistration"]),
        price: json["price"],
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
      };
}
