import '../../domain/domain.dart';

abstract class AtividadeDatasource {
  Future<AtividadeResponse> doAtividade(
      {required AtividadeRequestEntity atividadeRequestEntity});
  Future<void> deleteInscrito(
      {required InscritosRequestEntity atividadeRequestEntity});

  Future<AtividadeResponse> doInscrito(
      {required InscritosRequestEntity atividadeRequestEntity});
  Future<AtividadeResponse> deleteAtividade();

  Future<List<AtividadeEntity>> getAtividade();
}
