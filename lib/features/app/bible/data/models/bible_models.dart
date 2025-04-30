class BibleVerse {
  final String reference;
  final String text;
  final String translationName;

  BibleVerse({
    required this.reference,
    required this.text,
    required this.translationName,
  });

  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(
      reference: json['reference'],
      text: json['text'],
      translationName: json['translation_name'],
    );
  }
}
