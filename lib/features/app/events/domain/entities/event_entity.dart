// Event Entity
class Event {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int capacity;
  final String eventDate;
  final String createdAt;
  final String location;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.capacity,
    required this.eventDate,
    required this.createdAt,
    required this.location,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'capacity': capacity,
      'eventDate': eventDate,
      'createdAt': createdAt,
      'location': location
    };
  }
}
