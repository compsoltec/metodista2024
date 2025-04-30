import '../../../../../core/core.dart';
import '../domain.dart';

class CreateCellsUseCase {
  final CellsRepository repository;

  CreateCellsUseCase(this.repository);

  Future<Either<String, void>> call(Cells cells) async {
    return await repository.createCells(cells);
  }
}
