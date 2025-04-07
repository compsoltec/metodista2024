class InscritosRequestEntity {
  final String nome;
  final String telefone;
  final String token;
  final String idAtividade;
  final String id;
  InscritosRequestEntity(
      {required this.nome,
      required this.telefone,
      required this.token,
      required this.idAtividade,
      required this.id});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InscritosRequestEntity &&
        other.nome == nome &&
        other.telefone == telefone &&
        other.token == token;
  }

  @override
  int get hashCode => nome.hashCode ^ telefone.hashCode ^ token.hashCode;
}
