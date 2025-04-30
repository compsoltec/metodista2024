import '../../../../../core/core.dart';
import '../domain.dart';

class DeleteCellsUseCase {
  final CellsRepository repository;

  DeleteCellsUseCase(this.repository);

  Future<Either<String, void>> call(String id) async {
    return await repository.deleteCells(id);
  }
}
