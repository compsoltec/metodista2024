import '../../domain/domain.dart';
import '../infra.dart';

class AtividadeRepositoryImpl implements AtividadeRepository {
  final AtividadeDatasource _atividadeDatasource;

  AtividadeRepositoryImpl({required AtividadeDatasource atividadeDatasource})
      : _atividadeDatasource = atividadeDatasource;

  @override
  Future<AtividadeResponse> deleteAtividade() async {
    try {
      return await _atividadeDatasource.deleteAtividade();
    } on AtividadeFailure {
      rethrow;
    }
  }

  @override
  Future<List<AtividadeEntity>> getAtividade() async {
    try {
      return await _atividadeDatasource.getAtividade();
    } on AtividadeFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownAtividadeFailure(
        stackTrace: stackTrace,
        label: 'AtividadeRepositoryImpl - getAtividade',
      );
    }
  }

  @override
  Future<AtividadeResponse> doAtividade(
      {required AtividadeRequestEntity atividadeRequestEntity}) async {
    try {
      return await _atividadeDatasource.doAtividade(
        atividadeRequestEntity: atividadeRequestEntity,
      );
    } on AtividadeFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownAtividadeFailure(
        stackTrace: stackTrace,
        label: 'AtividadeRepositoryImpl - doAtividade',
      );
    }
  }

  @override
  Future<AtividadeResponse> doInscrito(
      {required InscritosRequestEntity inscritosRequestEntity}) async {
    try {
      return await _atividadeDatasource.doInscrito(
        atividadeRequestEntity: inscritosRequestEntity,
      );
    } on AtividadeFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownAtividadeFailure(
        stackTrace: stackTrace,
        label: 'AtividadeRepositoryImpl - doAtividade',
      );
    }
  }
}
