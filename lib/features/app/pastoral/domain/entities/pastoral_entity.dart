class Pastoral {
  final String id;
  final String title;
  final String text;
  final String author;
  final List<String> imageUrls;
  final DateTime date;
  final DateTime createdAt;

  Pastoral(
      {required this.id,
      required this.title,
      required this.text,
      required this.author,
      required this.date,
      required this.createdAt,
      required this.imageUrls});
}
