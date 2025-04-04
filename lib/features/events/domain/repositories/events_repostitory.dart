import '../../../../core/core.dart';
import '../../events.dart';

abstract class EventRepository {
  Future<Either<Failure, Event>> addEvent(Event event);
}
