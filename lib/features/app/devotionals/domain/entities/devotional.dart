class Devotional {
  final String id;
  final String title;
  final String author;
  final String date;
  final String description;
  final String audioUrl;
  final String imageUrl;
  final int? duration;

  Devotional({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.description,
    required this.audioUrl,
    required this.imageUrl,
    this.duration,
  });

  factory Devotional.fromJson(Map<String, dynamic> json) {
    return Devotional(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      date: json['date'],
      description: json['description'],
      audioUrl: json['audioUrl'],
      imageUrl: json['imageUrl'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'date': date,
      'description': description,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'duration': duration,
    };
  }
}
