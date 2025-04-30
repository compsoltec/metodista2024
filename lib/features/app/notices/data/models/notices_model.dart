import '../../domain/domain.dart';

//  id?: string;
//   name: string;
//   description?: string; // Indica se é avisos do dia atual
//   image?: string;
class NoticesModel {
  final String id;
  final String name;
  final String description;
  final String image;
  NoticesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory NoticesModel.fromJson(Map<String, dynamic> json) {
    return NoticesModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  /// Aqui está o toEntity()
  Notices toEntity() {
    return Notices(
      id: id,
      name: name,
      description: description,
      image: image,
    );
  }
}
