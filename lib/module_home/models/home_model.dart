class HomeModel {
  HomeModel({
    required this.pastoral,
    required this.avisos,
    required this.campanhas,
    required this.fotosCultos,
    required this.aniversariantes,
  });

  List<dynamic>? avisos;
  List<dynamic>? campanhas;
  List<dynamic>? fotosCultos;
  List<dynamic>? aniversariantes;
  String? id;
  String? pastoral;

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avisos = json['avisos'];
    campanhas = json['campanhas'];
    fotosCultos = json['fotosCultos'];
    aniversariantes = json['aniversariantes'];
    pastoral = json['pastoral'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['pastoral'] = pastoral;
    _data['avisos'] = avisos;
    _data['campanhas'] = campanhas;
    _data['fotosCultos'] = fotosCultos;
    _data['aniversariantes'] = aniversariantes;
    return _data;
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
        avisos: map['avisos'],
        campanhas: map['campanhas'],
        aniversariantes: map['aniversariantes'],
        fotosCultos: map['fotosCultos'],
        pastoral: map['pastoral']);
  }
}
