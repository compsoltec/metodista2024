class InscritosModel {
  String? telefone;
  String? nome;
  String? idAtividade;
  String? id;
  String? token;

  InscritosModel(
      {this.telefone, this.nome, this.idAtividade, this.id, this.token});

  InscritosModel.fromJson(Map<String, dynamic> json) {
    telefone = json['telefone'];
    nome = json['nome'];
    idAtividade = json['idAtividade'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['telefone'] = this.telefone;
    data['nome'] = this.nome;
    data['idAtividade'] = this.idAtividade;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
