import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';

// Event Model
class EventModel extends Event {
  EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.capacity,
    required super.eventDate,
    required super.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      capacity: json['capacity'],
      eventDate: json['eventDate'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'capacity': capacity,
      'eventDate': eventDate,
      'createdAt': createdAt,
    };
  }
}
