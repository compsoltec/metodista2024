import '../../../../core/core.dart';
import '../domain.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeData>> getHomeData();
}
