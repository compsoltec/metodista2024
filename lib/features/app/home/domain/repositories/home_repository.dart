import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class HomeRepository {
  Future<Either<Failure, Home>> getHomeData();
}
