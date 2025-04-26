import '../../../../../core/core.dart';
import '../domain.dart';

class DeleteBirthdayUseCase {
  final BirthdayRepository repository;

  DeleteBirthdayUseCase(this.repository);

  Future<Either<String, void>> call(String id) async {
    return await repository.deleteBirthday(id);
  }
}
