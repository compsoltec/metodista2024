import 'dart:convert';

List<BibliaModels> bibliaModelsFromJson(str) =>
    List<BibliaModels>.from(str.map((x) => BibliaModels.fromJson(x)));

String bibliaModelsToJson(List<BibliaModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BibliaModels {
  Book book;
  int chapter;
  int number;
  String text;

  BibliaModels({
    required this.book,
    required this.chapter,
    required this.number,
    required this.text,
  });

  factory BibliaModels.fromJson(Map<String, dynamic> json) => BibliaModels(
        book: Book.fromJson(json["book"]),
        chapter: json["chapter"],
        number: json["number"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "book": book.toJson(),
        "chapter": chapter,
        "number": number,
        "text": text,
      };
}

class Book {
  Abbrev abbrev;
  String name;
  String author;
  String group;
  String version;

  Book({
    required this.abbrev,
    required this.name,
    required this.author,
    required this.group,
    required this.version,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        abbrev: Abbrev.fromJson(json["abbrev"]),
        name: json["name"],
        author: json["author"],
        group: json["group"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "abbrev": abbrev.toJson(),
        "name": name,
        "author": author,
        "group": group,
        "version": version,
      };
}

class Abbrev {
  String pt;
  String en;

  Abbrev({
    required this.pt,
    required this.en,
  });

  factory Abbrev.fromJson(Map<String, dynamic> json) => Abbrev(
        pt: json["pt"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "pt": pt,
        "en": en,
      };
}
