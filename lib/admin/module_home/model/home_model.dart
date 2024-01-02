class HomeModel {
  HomeModel({
    required this.avisos,
    required this.campanhas,
    this.fotosCultos,
    required this.aniversariantes,
  });

  List<dynamic>? avisos;
  List<dynamic>? campanhas;
  List<dynamic>? fotosCultos;
  List<dynamic>? aniversariantes;
  String? id;

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avisos = json['avisos'];
    campanhas = json['campanhas'];
    fotosCultos = json['fotosCultos'];
    aniversariantes = json['aniversariantes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['avisos'] = avisos;
    _data['campanhas'] = campanhas;
    _data['fotosCultos'] = fotosCultos;
    _data['aniversariantes'] = aniversariantes;
    return _data;
  }
}
