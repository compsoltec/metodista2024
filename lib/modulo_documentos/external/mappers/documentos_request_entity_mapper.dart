import '../../domain/entities/entities.dart';

class DocumentosRequestEntityMapper {
  static Map<String, dynamic> toMap({required DocumentosRequestEntity entity}) {
    return {
      'data': entity.data,
      'titulo': entity.titulo,
    };
  }
}
