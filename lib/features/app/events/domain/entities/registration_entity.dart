class Registration {
  final String id;
  final String eventId;
  final String name;
  final int age;
  final String church;
  final String createdAt;

  Registration({
    required this.id,
    required this.eventId,
    required this.name,
    required this.age,
    required this.church,
    required this.createdAt,
  });

  Registration copyWith({
    String? id,
    String? eventId,
    String? name,
    int? age,
    String? church,
    String? createdAt,
  }) {
    return Registration(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      age: age ?? this.age,
      church: church ?? this.church,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'name': name,
      'age': age,
      'church': church,
      'createdAt': createdAt
    };
  }
}
