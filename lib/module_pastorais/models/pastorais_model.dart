import 'dart:convert';

List<PastoraisModels> pastoraisFromJson(str) =>
    List<PastoraisModels>.from(str.map((x) => PastoraisModels.fromJson(x)));

String pastoraisModelsToJson(PastoraisModels data) =>
    json.encode(data.toJson());

class PastoraisModels {
  String titulo;
  String foto;
  String descricao;

  PastoraisModels({
    required this.titulo,
    required this.foto,
    required this.descricao,
  });

  factory PastoraisModels.fromJson(Map<String, dynamic> json) =>
      PastoraisModels(
        titulo: json["titulo"],
        descricao: json['descricao'],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() =>
      {"titulo": titulo, "foto": foto, 'descricao': descricao};
}
