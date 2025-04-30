import '../../../../../core/core.dart';
import '../domain.dart';

class GetCourcessUseCase {
  final CourcesRepository repository;

  GetCourcessUseCase(this.repository);

  Future<Either<String, List<Cources>>> call() async {
    return await repository.getCources();
  }
}
