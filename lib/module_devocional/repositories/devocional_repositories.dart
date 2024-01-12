import 'package:notification2/module_devocional/module_devocional.dart';

import '../providers/devocional_provider.dart';

class DevocionalRepository {
  final DevocionalProvider api;

  DevocionalRepository({required this.api});

  getDevocional() {
    return api.getDevocional();
  }

  postDevocional(DevocionalModels devocionalModels) {
    return api.postDevocional(devocionalModels);
  }
}
