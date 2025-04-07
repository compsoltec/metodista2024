class InscritosEntity {
  String? token;
  String? telefone;
  String? nome;
  String? id;

  InscritosEntity({this.token, this.telefone, this.nome, this.id});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InscritosEntity &&
        other.token == token &&
        other.telefone == telefone &&
        other.nome == nome &&
        other.id == id;
  }

  @override
  int get hashCode {
    return token.hashCode ^ telefone.hashCode ^ nome.hashCode ^ id.hashCode;
  }
}
