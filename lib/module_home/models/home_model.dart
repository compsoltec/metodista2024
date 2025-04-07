class HomeModel {
  HomeModel({
    required this.pastoral,
    required this.aniversariantes,
    required this.programacao,
  });

  List<dynamic>? aniversariantes;
  String? id;
  String? pastoral;
  List<dynamic>? programacao;

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    aniversariantes = json['aniversariantes'];
    pastoral = json['pastoral'];
    programacao = json['programacao'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['pastoral'] = pastoral;
    _data['aniversariantes'] = aniversariantes;
    _data['programacao'] = programacao;
    return _data;
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
        aniversariantes: map['aniversariantes'],
        pastoral: map['pastoral'],
        programacao: map['programacao']);
  }
}

class Programacao {
  String foto;
  String descricao;

  Programacao({
    required this.foto,
    required this.descricao,
  });

  factory Programacao.fromJson(Map<String, dynamic> json) => Programacao(
        foto: json["foto"],
        descricao: json["descricao"],
      );

  Map<String, dynamic> toJson() => {
        "foto": foto,
        "descricao": descricao,
      };
}
