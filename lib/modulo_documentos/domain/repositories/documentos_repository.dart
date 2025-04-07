import '../entities/entities.dart';

abstract class DocumentosRepository {
  Future<DocumentosResponse> doDocumentos(
      {required DocumentosRequestEntity documentosRequestEntity});
  Future<DocumentosResponse> deleteDocumentos();
  Future<List<DocumentosEntity>> getDocumentos();
}
