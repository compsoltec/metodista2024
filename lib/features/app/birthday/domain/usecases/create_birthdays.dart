import '../../../../../core/core.dart';
import '../domain.dart';

class CreateBirthdayUseCase {
  final BirthdayRepository repository;

  CreateBirthdayUseCase(this.repository);

  Future<Either<String, void>> call(Birthday birthday) async {
    return await repository.createBirthday(birthday);
  }
}
