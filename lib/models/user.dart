class LocalUser {
  final int id;
  final String name;
  final String email;
  final String? pilotName;
  final DateTime? dateOfBirth;

  LocalUser({
    required this.id,
    required this.name,
    required this.email,
    this.pilotName,
    this.dateOfBirth,
  });

  factory LocalUser.fromMap(Map<String, dynamic> json) => LocalUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        pilotName: json["pilotName"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "pilotName": pilotName,
        "dateOfBirth":
            dateOfBirth == null ? null : dateOfBirth!.toIso8601String(),
      };
}
