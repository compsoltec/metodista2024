import '../domain.dart';

abstract class DoDocumentosUsecase {
  Future<DocumentosResponse> call(
      {required DocumentosRequestEntity documentosRequestEntity});
  Future<List<DocumentosEntity>> getDocumentos();
}

class DoDocumentosUsecaseImpl implements DoDocumentosUsecase {
  final DocumentosRepository _repository;

  DoDocumentosUsecaseImpl({
    required DocumentosRepository documentosRepository,
  }) : _repository = documentosRepository;

  @override
  Future<DocumentosResponse> call({
    required DocumentosRequestEntity documentosRequestEntity,
  }) async {
    if (documentosRequestEntity.data.isEmpty ||
        documentosRequestEntity.titulo.isEmpty) {
      throw InvalidCredentialsDocumentosFailure();
    }
    return await _repository.doDocumentos(
        documentosRequestEntity: documentosRequestEntity);
  }

  @override
  Future delete() async {
    return await _repository.deleteDocumentos();
  }

  @override
  Future<List<DocumentosEntity>> getDocumentos() async {
    return await _repository.getDocumentos();
  }
}
