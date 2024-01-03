import '../providers/devocional_provider.dart';

class DevocionalRepository {
  final DevocionalProvider api;

  DevocionalRepository({required this.api});

  getDevocional() {
    return api.getDevocional();
  }
}
