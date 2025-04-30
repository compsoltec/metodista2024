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
    required super.location,
    required super.registration,
  });

  // From JSON - Converts the Map data from API to EventModel instance
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        capacity: json['capacity'] ?? 0,
        eventDate: json['eventDate'] ?? '',
        createdAt: json['createdAt'] ?? '',
        registration: json['registration'] ?? '',
        location: json['location'] ?? '');
  }
}
