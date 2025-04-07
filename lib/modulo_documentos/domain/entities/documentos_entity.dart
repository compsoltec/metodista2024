class DocumentosEntity {
  dynamic arquivos;
  String? titulo;
  String? id;

  DocumentosEntity({this.titulo, this.arquivos, this.id});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocumentosEntity &&
        other.arquivos == arquivos &&
        other.titulo == titulo;
  }

  @override
  int get hashCode {
    return titulo.hashCode ^ arquivos.hashCode;
  }
}
