import '../../domain/domain.dart';

class BirthdayModel {
  final String id;
  final String name;
  final DateTime birthDate;
  final bool isBirthdayToday;
  final String createdAt;

  BirthdayModel({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.isBirthdayToday,
    required this.createdAt,
  });

  factory BirthdayModel.fromJson(Map<String, dynamic> json) {
    return BirthdayModel(
      id: json['id'],
      name: json['name'],
      birthDate: DateTime.parse(json['birthDate']),
      isBirthdayToday: json['isBirthdayToday'] ?? false,
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthDate': birthDate.toIso8601String(),
      'isBirthdayToday': isBirthdayToday,
      'createdAt': createdAt,
    };
  }

  /// Aqui está o toEntity()
  Birthday toEntity() {
    return Birthday(
      id: id,
      name: name,
      birthDate: birthDate,
      isBirthdayToday: isBirthdayToday,
      createdAt: createdAt,
    );
  }
}
