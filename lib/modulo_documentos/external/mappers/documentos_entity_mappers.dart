import '../../domain/domain.dart';

class DocumentosEntityMapper {
  static DocumentosEntity fromMap({required Map<String, dynamic> map}) {
    return DocumentosEntity(
        arquivos: map['arquivos'], titulo: map['titulo'], id: map['id']);
  }
}
