import '../../../../../core/core.dart';
import '../../../app.dart';

class GetBirthdaysTodayUseCase {
  final BirthdayRepository repository;

  GetBirthdaysTodayUseCase(this.repository);

  Future<Either<String, List<Birthday>>> call() async {
    return await repository.getBirthdaysToday();
  }
}
