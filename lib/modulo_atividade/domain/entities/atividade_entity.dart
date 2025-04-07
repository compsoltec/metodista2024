class AtividadeEntity {
  String? descricao;
  String? data;
  String? foto;
  String? titulo;
  String? id;
  int? vagas;

  AtividadeEntity(
      {this.descricao, this.data, this.foto, this.titulo, this.id, this.vagas});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AtividadeEntity &&
        other.data == data &&
        other.descricao == descricao &&
        other.foto == foto &&
        other.titulo == titulo &&
        other.id == id;
  }

  @override
  int get hashCode {
    return data.hashCode ^ data.hashCode ^ descricao.hashCode ^ foto.hashCode;
  }
}
