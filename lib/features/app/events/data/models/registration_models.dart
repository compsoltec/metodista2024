// Registration Model
import '../../domain/entities/entities.dart';

class RegistrationModel extends Registration {
  RegistrationModel({
    required super.id,
    required super.eventId,
    required super.name,
    required super.age,
    required super.church,
    required super.createdAt,
    required super.phone,
    required super.fcmToken,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
        id: json['id'],
        eventId: json['eventId'],
        name: json['name'],
        age: json['age'],
        church: json['church'],
        createdAt: json['createdAt'],
        fcmToken: json['fcmToken'],
        phone: json["phone"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'name': name,
      'age': age,
      'church': church,
      'createdAt': createdAt,
      'phone': phone,
      'fcmToken': fcmToken
    };
  }
}
