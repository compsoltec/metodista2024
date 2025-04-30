import '../../../../../core/core.dart';
import '../domain.dart';

class GetCellssUseCase {
  final CellsRepository repository;

  GetCellssUseCase(this.repository);

  Future<Either<String, List<Cells>>> call() async {
    return await repository.getCells();
  }
}
