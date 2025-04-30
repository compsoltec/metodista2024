import '../../domain/domain.dart';

class CourcesModel {
  final String id;
  final String name;
  final String course;
  final String image;
  final bool inscricoes;
  final String phone;
  final int capacity;

  CourcesModel(
      {required this.id,
      required this.name,
      required this.course,
      required this.image,
      required this.phone,
      required this.inscricoes,
      required this.capacity});

  factory CourcesModel.fromJson(Map<String, dynamic> json) {
    return CourcesModel(
        id: json['id'],
        name: json['name'],
        course: json['course'],
        image: json['image'],
        inscricoes: json['inscricoes'],
        phone: json['phone'],
        capacity: json['capacity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'course': course,
      'image': image,
      'inscricoes': inscricoes,
      'capacity': capacity,
      'phone': phone
    };
  }

  /// Aqui está o toEntity()
  Cources toEntity() {
    return Cources(
        id: id,
        name: name,
        course: course,
        image: image,
        inscricoes: inscricoes,
        phone: phone,
        capacity: capacity);
  }
}
