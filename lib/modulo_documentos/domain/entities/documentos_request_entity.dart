class DocumentosRequestEntity {
  final dynamic data;
  final String titulo;
  final String id;

  DocumentosRequestEntity({
    required this.data,
    required this.titulo,
    required this.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocumentosRequestEntity &&
        other.data == data &&
        other.titulo == titulo;
  }

  @override
  int get hashCode => data.hashCode ^ titulo.hashCode;
}
