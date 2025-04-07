import '../../domain/domain.dart';
import '../infra.dart';

class DocumentosRepositoryImpl implements DocumentosRepository {
  final DocumentosDatasource _documentosDatasource;

  DocumentosRepositoryImpl({required DocumentosDatasource documentosDatasource})
      : _documentosDatasource = documentosDatasource;

  @override
  Future<DocumentosResponse> deleteDocumentos() async {
    try {
      return await _documentosDatasource.deleteDocumentos();
    } on DocumentosFailure {
      rethrow;
    }
  }

  @override
  Future<List<DocumentosEntity>> getDocumentos() async {
    try {
      return await _documentosDatasource.getDocumentos();
    } on DocumentosFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownDocumentosFailure(
        stackTrace: stackTrace,
        label: 'DocumentosRepositoryImpl - getDocumentos',
      );
    }
  }

  @override
  Future<DocumentosResponse> doDocumentos(
      {required DocumentosRequestEntity documentosRequestEntity}) async {
    try {
      return await _documentosDatasource.doDocumentos(
        documentosRequestEntity: documentosRequestEntity,
      );
    } on DocumentosFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownDocumentosFailure(
        stackTrace: stackTrace,
        label: 'DocumentosRepositoryImpl - doDocumentos',
      );
    }
  }
}
