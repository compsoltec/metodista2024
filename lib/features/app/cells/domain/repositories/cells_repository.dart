import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class CellsRepository {
  Future<Either<String, List<Cells>>> getCells();
  Future<Either<String, List<Cells>>> getCellsToday();
  Future<Either<String, void>> createCells(Cells cources);
  Future<Either<String, void>> deleteCells(String id);
  Future<Either<String, void>> updateCells(Cells cources);
}
