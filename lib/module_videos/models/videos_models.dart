import 'dart:convert';

List<VideosModels> videosFromJson(str) =>
    List<VideosModels>.from(str.map((x) => VideosModels.fromJson(x)));

String videoModelsToJson(VideosModels data) => json.encode(data.toJson());

class VideosModels {
  String titulo;
  String video;
  String foto;

  VideosModels({
    required this.titulo,
    required this.video,
    required this.foto,
  });

  factory VideosModels.fromJson(Map<String, dynamic> json) => VideosModels(
        titulo: json["titulo"],
        video: json["video"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "video": video,
        "foto": foto,
      };
}
