import 'dart:convert';

List<DevocionalModels> devocionaisFromJson(str) =>
    List<DevocionalModels>.from(str.map((x) => DevocionalModels.fromJson(x)));

String devocionaisToJson(List<DevocionalModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DevocionalModels {
  int sequencia;
  String devocional;
  String data;
  String foto;
  String titulo;
  String id;

  DevocionalModels({
    required this.sequencia,
    required this.devocional,
    required this.data,
    required this.foto,
    required this.titulo,
    required this.id,
  });

  factory DevocionalModels.fromJson(Map<String, dynamic> json) =>
      DevocionalModels(
        sequencia: json["sequencia"],
        devocional: json["devocional"],
        data: json["data"],
        foto: json["foto"],
        titulo: json["titulo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "sequencia": sequencia,
        "devocional": devocional,
        "data": data,
        "foto": foto,
        "titulo": titulo,
        "id": id,
      };
}
