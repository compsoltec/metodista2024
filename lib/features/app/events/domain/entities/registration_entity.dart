// Modificação no modelo Registration
class Registration {
  final String id;
  final String eventId;
  final String name;
  final int age;
  final String church;
  final String createdAt;
  final String phone;
  final String fcmToken; // Novo campo

  Registration({
    required this.id,
    required this.eventId,
    required this.name,
    required this.age,
    required this.church,
    required this.createdAt,
    required this.phone,
    required this.fcmToken, // Novo campo obrigatório
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'name': name,
      'age': age,
      'church': church,
      'createdAt': createdAt,
      'phone': phone,
      'fcmToken': fcmToken,
    };
  }
}
