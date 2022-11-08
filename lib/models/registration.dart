import 'package:pdrnl_events_app/models/event.dart';

class Registration {
  final String id;
  final String status;
  final Event event;
  final DateTime createdAt;

  Registration({
    required this.id,
    required this.status,
    required this.event,
    required this.createdAt,
  });

  factory Registration.fromMap(Map<String, dynamic> json) => Registration(
        id: json["id"],
        status: json["status"],
        event: Event.fromMap(json["event"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "event": event.toMap(),
        "created_at": createdAt.toIso8601String(),
      };
}
