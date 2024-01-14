import '../models/pastorais_model.dart';
import '../providers/pastorais_provider.dart';

class PastoraisRepository {
  final PastoraisProvider api;

  PastoraisRepository({required this.api});

  getPastorais() {
    return api.getPastorais();
  }

  postPastorais(PastoraisModels devocionalModels) {
    return api.postPastorais(devocionalModels);
  }
}
