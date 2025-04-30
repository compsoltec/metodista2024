// domain/usecases/get_pastorals_usecase.dart
import '../../../../../core/core.dart';
import '../domain.dart';

class GetPastoralsUseCase {
  final PastoralRepository repository;

  GetPastoralsUseCase(this.repository);

  Future<Either<String, List<Pastoral>>> call() async {
    return await repository.getPastorals();
  }
}

// domain/usecases/get_pastoral_by_id_usecase.dart
class GetPastoralByIdUseCase {
  final PastoralRepository repository;

  GetPastoralByIdUseCase(this.repository);

  Future<Either<String, Pastoral>> call(String id) async {
    return await repository.getPastoralById(id);
  }
}

// domain/usecases/create_pastoral_usecase.dart
class CreatePastoralUseCase {
  final PastoralRepository repository;

  CreatePastoralUseCase(this.repository);

  Future<Either<String, void>> call(Pastoral pastoral) async {
    return await repository.createPastoral(pastoral);
  }
}

// domain/usecases/update_pastoral_usecase.dart
class UpdatePastoralUseCase {
  final PastoralRepository repository;

  UpdatePastoralUseCase(this.repository);

  Future<Either<String, void>> call(Pastoral pastoral) async {
    return await repository.updatePastoral(pastoral);
  }
}

// domain/usecases/delete_pastoral_usecase.dart
class DeletePastoralUseCase {
  final PastoralRepository repository;

  DeletePastoralUseCase(this.repository);

  Future<Either<String, void>> call(String id) async {
    return await repository.deletePastoral(id);
  }
}
