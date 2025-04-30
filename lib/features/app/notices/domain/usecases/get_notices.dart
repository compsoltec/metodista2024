import '../../../../../core/core.dart';
import '../domain.dart';

class GetNoticessUseCase {
  final NoticesRepository repository;

  GetNoticessUseCase(this.repository);

  Future<Either<String, List<Notices>>> call() async {
    return await repository.getNotices();
  }
}
