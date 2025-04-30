import '../../../../../core/core.dart';
import '../domain.dart';

abstract class PastoralRepository {
  Future<Either<String, List<Pastoral>>> getPastorals();
  Future<Either<String, void>> createPastoral(Pastoral pastoral);
  Future<Either<String, void>> deletePastoral(String id);
  Future<Either<String, Pastoral>> getPastoralById(String id);
  Future<Either<String, void>> updatePastoral(Pastoral pastoral);
}
