import '../../../../../core/core.dart';
import '../domain.dart';

class DeleteNoticesUseCase {
  final NoticesRepository repository;

  DeleteNoticesUseCase(this.repository);

  Future<Either<String, void>> call(String id) async {
    return await repository.deleteNotices(id);
  }
}
