import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class NoticesRepository {
  Future<Either<String, List<Notices>>> getNotices();
  Future<Either<String, List<Notices>>> getNoticesToday();
  Future<Either<String, void>> createNotices(Notices notices);
  Future<Either<String, void>> deleteNotices(String id);
  Future<Either<String, void>> updateNotices(Notices notices);
}
