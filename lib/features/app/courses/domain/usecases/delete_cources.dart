import '../../../../../core/core.dart';
import '../domain.dart';

class DeleteCourcesUseCase {
  final CourcesRepository repository;

  DeleteCourcesUseCase(this.repository);

  Future<Either<String, void>> call(String id) async {
    return await repository.deleteCources(id);
  }
}
