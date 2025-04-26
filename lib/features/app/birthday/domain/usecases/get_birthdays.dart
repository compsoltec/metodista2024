import '../../../../../core/core.dart';
import '../domain.dart';

class GetBirthdaysUseCase {
  final BirthdayRepository repository;

  GetBirthdaysUseCase(this.repository);

  Future<Either<String, List<Birthday>>> call() async {
    return await repository.getBirthdays();
  }
}
