import '../entities/entities.dart';

abstract class AtividadeRepository {
  Future<AtividadeResponse> doAtividade(
      {required AtividadeRequestEntity atividadeRequestEntity});
  Future<AtividadeResponse> deleteAtividade();
  Future<List<AtividadeEntity>> getAtividade();
  Future<AtividadeResponse> doInscrito(
      {required InscritosRequestEntity inscritosRequestEntity});
}
