import '../../../../../core/core.dart';
import '../entities/preaching.dart';

abstract class PreachingRepository {
  Future<Either<Failure, List<Preaching>>> getPreachings();
  Future<Either<Failure, void>> createPreaching(Preaching preaching);
  Future<Either<Failure, void>> deletePreaching(String id);
}
