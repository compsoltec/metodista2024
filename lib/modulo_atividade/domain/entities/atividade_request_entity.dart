class AtividadeRequestEntity {
  final List<String> inscritos;
  final String data;
  final String foto;
  final String descricao;
  final String titulo;
  final int vagas;

  AtividadeRequestEntity(
      {required this.data,
      required this.inscritos,
      required this.descricao,
      required this.foto,
      required this.titulo,
      required this.vagas});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AtividadeRequestEntity &&
        other.data == data &&
        other.foto == foto &&
        other.descricao == descricao &&
        other.inscritos == inscritos &&
        other.titulo == titulo;
  }

  @override
  int get hashCode =>
      data.hashCode ^
      foto.hashCode ^
      descricao.hashCode ^
      inscritos.hashCode ^
      titulo.hashCode;
}
