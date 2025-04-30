import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class CourcesRepository {
  Future<Either<String, List<Cources>>> getCources();
  Future<Either<String, List<Cources>>> getCourcesToday();
  Future<Either<String, void>> createCources(Cources cources);
  Future<Either<String, void>> deleteCources(String id);
  Future<Either<String, void>> updateCources(Cources cources);
}
