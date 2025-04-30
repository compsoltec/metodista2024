import '../../../../../core/core.dart';
import '../domain.dart';

class CreateNoticesUseCase {
  final NoticesRepository repository;

  CreateNoticesUseCase(this.repository);

  Future<Either<String, void>> call(Notices notices) async {
    return await repository.createNotices(notices);
  }
}
