import '../providers/biblia_provider.dart';

class BibliaRepository {
  final BibliaProvider api;

  BibliaRepository({required this.api});

  getBiblia() {
    return api.getBiblia();
  }
}
