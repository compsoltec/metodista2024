import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class BirthdayRepository {
  Future<Either<String, List<Birthday>>> getBirthdays();
  Future<Either<String, List<Birthday>>> getBirthdaysToday();
  Future<Either<String, void>> createBirthday(Birthday birthday);
  Future<Either<String, void>> deleteBirthday(String id);
  Future<Either<String, void>> updateBirthday(Birthday birthday);
}
