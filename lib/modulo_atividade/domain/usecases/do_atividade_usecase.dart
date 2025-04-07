import '../domain.dart';

abstract class DoAtividadeUsecase {
  Future<AtividadeResponse> call(
      {required AtividadeRequestEntity atividadeRequestEntity});
  Future<List<AtividadeEntity>> getAtividade();
  Future<AtividadeResponse> doInscrito(
      {required InscritosRequestEntity inscritosRequestEntity});
}

class DoAtividadeUsecaseImpl implements DoAtividadeUsecase {
  final AtividadeRepository _repository;

  DoAtividadeUsecaseImpl({
    required AtividadeRepository atividadeRepository,
  }) : _repository = atividadeRepository;

  @override
  Future<AtividadeResponse> call({
    required AtividadeRequestEntity atividadeRequestEntity,
  }) async {
    if (atividadeRequestEntity.data.isEmpty ||
        atividadeRequestEntity.descricao.isEmpty ||
        atividadeRequestEntity.foto.isEmpty) {
      throw InvalidCredentialsAtividadeFailure();
    }
    return await _repository.doAtividade(
        atividadeRequestEntity: atividadeRequestEntity);
  }

  @override
  Future<List<AtividadeEntity>> getAtividade() async {
    return await _repository.getAtividade();
  }

  @override
  Future<AtividadeResponse> doInscrito(
      {required InscritosRequestEntity inscritosRequestEntity}) async {
    if (inscritosRequestEntity.nome.isEmpty ||
        inscritosRequestEntity.telefone.isEmpty ||
        inscritosRequestEntity.token.isEmpty) {
      throw InvalidCredentialsAtividadeFailure();
    }
    return await _repository.doInscrito(
        inscritosRequestEntity: inscritosRequestEntity);
  }
}
