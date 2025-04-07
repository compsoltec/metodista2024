class AtividadesModel {
  String? data;
  String? foto;
  String? titulo;
  String? descricao;
  int? vagas;
  String? id;

  AtividadesModel(
      {this.data, this.foto, this.titulo, this.descricao, this.vagas, this.id});

  AtividadesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    foto = json['foto'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    vagas = json['vagas'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['foto'] = this.foto;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['vagas'] = this.vagas;
    data['id'] = this.id;
    return data;
  }
}
