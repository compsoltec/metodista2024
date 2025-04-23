// Event Entity
class Event {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int capacity;
  final String eventDate;
  final String createdAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.capacity,
    required this.eventDate,
    required this.createdAt,
  });
}
