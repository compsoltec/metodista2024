class CadastroModel {
  String? nome;
  String? dataNascimento;
  int? telefone;
  String? statusProfissional;
  String? area;
  String? descricao;

  CadastroModel(
      {this.nome,
      this.dataNascimento,
      this.telefone,
      this.descricao,
      this.statusProfissional,
      this.area});

  CadastroModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    dataNascimento = json['dataNascimento'];
    telefone = json['telefone'];
    descricao = json['descricao'];
    statusProfissional = json['statusProfissional'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['dataNascimento'] = this.dataNascimento;
    data['telefone'] = this.telefone;
    data['descricao'] = this.descricao;
    data['statusProfissional'] = this.statusProfissional;
    data['area'] = this.area;
    return data;
  }
}
