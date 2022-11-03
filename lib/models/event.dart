import 'dart:convert';

class LocalEvent {
  final String id;
  final String name;
  final String category;
  final DateTime date;
  final String maxRegistrations;

  LocalEvent({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.maxRegistrations,
  });

  factory LocalEvent.fromJson(Map<String, dynamic> json) {
    return LocalEvent(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      maxRegistrations: json['max_registrations'],
    );
  }

  static Map<String, dynamic>? toMap(LocalEvent event) => {
        'id': event.id,
        'name': event.name,
        'category': event.category,
        'date': event.date.toIso8601String(),
        'maxRegistrations': event.maxRegistrations,
      };

  static String encode(List<LocalEvent> events) => json.encode(
        events
            .map<Map<String, dynamic>>((event) => LocalEvent.toMap(event)!)
            .toList(),
      );
}
