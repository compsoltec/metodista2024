import '../../../../../core/core.dart';
import '../domain.dart';

class CreateCourcesUseCase {
  final CourcesRepository repository;

  CreateCourcesUseCase(this.repository);

  Future<Either<String, void>> call(Cources cources) async {
    return await repository.createCources(cources);
  }
}
