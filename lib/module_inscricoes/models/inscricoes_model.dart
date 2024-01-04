import 'dart:convert';

List<InscricoesModel> inscricoesFromJson(str) =>
    List<InscricoesModel>.from(str.map((x) => InscricoesModel.fromJson(x)));

String inscricoesModelToJson(List<InscricoesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InscricoesModel {
  String id;
  int vagas;
  String foto;
  String data;
  List<Inscrito> inscritos;
  String descricao;
  String titulo;

  InscricoesModel({
    required this.id,
    required this.vagas,
    required this.foto,
    required this.data,
    required this.inscritos,
    required this.descricao,
    required this.titulo,
  });

  factory InscricoesModel.fromJson(Map<String, dynamic> json) =>
      InscricoesModel(
        titulo: json['titulo'],
        vagas: json["vagas"],
        foto: json["foto"],
        data: json["data"],
        inscritos: List<Inscrito>.from(
            json["inscritos"].map((x) => Inscrito.fromJson(x))),
        descricao: json["descricao"],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        "vagas": vagas,
        "id": id,
        "foto": foto,
        "titulo": titulo,
        "data": data,
        "inscritos": List<dynamic>.from(inscritos.map((x) => x.toJson())),
        "descricao": descricao,
      };
}

class Inscrito {
  String telefone;
  String nome;
  String id;

  Inscrito({
    required this.telefone,
    required this.nome,
    required this.id,
  });

  factory Inscrito.fromJson(Map<String, dynamic> json) => Inscrito(
        telefone: json["telefone"],
        nome: json["nome"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "telefone": telefone,
        "nome": nome,
        "id": id,
      };
}
