import 'package:notification2/module_inscricoes/models/inscricoes_model.dart';

import '../providers/inscricoes_provider.dart';

class InscricoesRepository {
  final InscricoesProvider api;

  InscricoesRepository({required this.api});

  getInscricoes() {
    return api.getInscricoes();
  }

  postInsctrito(InscricoesModel inscricoesModel) {
    return api.putInscrito(inscricoesModel);
  }
}
