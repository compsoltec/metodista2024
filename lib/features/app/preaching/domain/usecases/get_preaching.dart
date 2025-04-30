import '../../../../../core/core.dart';
import '../entities/preaching.dart';
import '../repositories/preaching_repository.dart';

class GetPreachingUseCase {
  final PreachingRepository repository;

  GetPreachingUseCase(this.repository);

  Future<Either<Failure, List<Preaching>>> call() {
    return repository.getPreachings();
  }
}

class CreatePreachingUseCase {
  final PreachingRepository repository;

  CreatePreachingUseCase(this.repository);

  Future<Either<Failure, void>> call(Preaching preaching) {
    return repository.createPreaching(preaching);
  }
}

class DeletePreachingUseCase {
  final PreachingRepository repository;

  DeletePreachingUseCase(this.repository);

  Future<Either<Failure, void>> call(String devotionalId) {
    return repository.deletePreaching(devotionalId);
  }
}
