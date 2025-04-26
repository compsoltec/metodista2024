import '../../../../../core/core.dart';
import '../entities/devotional.dart';
import '../repositories/devotional_repository.dart';

class GetDevotionalsUseCase {
  final DevotionalRepository repository;

  GetDevotionalsUseCase(this.repository);

  Future<Either<Failure, List<Devotional>>> call() {
    return repository.getDevotionals();
  }
}

class CreateDevotionalUseCase {
  final DevotionalRepository repository;

  CreateDevotionalUseCase(this.repository);

  Future<Either<Failure, void>> call(Devotional devotional) {
    return repository.createDevotional(devotional);
  }
}

class DeleteDevotionalUseCase {
  final DevotionalRepository repository;

  DeleteDevotionalUseCase(this.repository);

  Future<Either<Failure, void>> call(String devotionalId) {
    return repository.deleteDevotional(devotionalId);
  }
}
