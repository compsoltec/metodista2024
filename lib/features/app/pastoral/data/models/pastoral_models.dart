import '../../domain/entities/pastoral_entity.dart';

class PastoralModel {
  final String id;
  final String title;
  final String text;
  final String author;
  final List<String> imageUrls;
  final DateTime date;
  final DateTime createdAt;

  PastoralModel(
      {required this.id,
      required this.title,
      required this.text,
      required this.author,
      required this.date,
      required this.createdAt,
      required this.imageUrls});

  factory PastoralModel.fromJson(Map<String, dynamic> json) {
    return PastoralModel(
        id: json['id'] ?? '',
        title: json['title'],
        text: json['text'],
        author: json['author'],
        date: DateTime.parse(json['date']),
        createdAt: DateTime.parse(json['createdAt']),
        imageUrls: List<String>.from(json['imageUrls'] ?? []));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'author': author,
      'imageUrl': imageUrls,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Converte o Model para Entity
  Pastoral toEntity() {
    return Pastoral(
        id: id,
        title: title,
        text: text,
        author: author,
        date: date,
        createdAt: createdAt,
        imageUrls: imageUrls);
  }

  /// Converte Entity para Model
  factory PastoralModel.fromEntity(Pastoral pastoral) {
    return PastoralModel(
        id: pastoral.id,
        title: pastoral.title,
        text: pastoral.text,
        author: pastoral.author,
        date: pastoral.date,
        createdAt: pastoral.createdAt,
        imageUrls: pastoral.imageUrls);
  }
}
