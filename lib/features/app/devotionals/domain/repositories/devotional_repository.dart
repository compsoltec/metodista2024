import '../../../../../core/core.dart';
import '../entities/devotional.dart';

abstract class DevotionalRepository {
  Future<Either<Failure, List<Devotional>>> getDevotionals();
  Future<Either<Failure, void>> createDevotional(Devotional devotional);
  Future<Either<Failure, void>> deleteDevotional(String id);
}
