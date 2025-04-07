import '../../domain/domain.dart';

abstract class DocumentosDatasource {
  Future<DocumentosResponse> doDocumentos(
      {required DocumentosRequestEntity documentosRequestEntity});
  Future<DocumentosResponse> deleteDocumentos();
  Future<List<DocumentosEntity>> getDocumentos();
}
