import 'dart:convert';

List<TestemunhosModels> testemunhosFromJson(str) =>
    List<TestemunhosModels>.from(str.map((x) => TestemunhosModels.fromJson(x)));

String devocionaisToJson(List<TestemunhosModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String testemunhosModelsToJson(List<TestemunhosModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestemunhosModels {
  String texto;
  String nome;
  String data;
  String foto;

  TestemunhosModels({
    required this.texto,
    required this.nome,
    required this.data,
    required this.foto,
  });

  factory TestemunhosModels.fromJson(Map<String, dynamic> json) =>
      TestemunhosModels(
        texto: json["texto"],
        nome: json["nome"],
        data: json["data"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "texto": texto,
        "nome": nome,
        "data": data,
        "foto": foto,
      };
}
