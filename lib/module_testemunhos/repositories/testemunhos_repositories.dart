import '../providers/testemunhos_provider.dart';

class TestemunhosRepository {
  final TestemunhosProvider api;

  TestemunhosRepository({required this.api});

  getTestemunhos() {
    return api.getTestemunhos();
  }
}
