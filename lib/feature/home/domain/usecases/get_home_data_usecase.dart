import '../../../../core/core.dart';
import '../domain.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<Failure, HomeData>> call() async {
    return await repository.getHomeData();
  }
}
