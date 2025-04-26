import '../../../../../core/core.dart';
import '../../home.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<Failure, Home>> call() async {
    return await repository.getHomeData();
  }
}
