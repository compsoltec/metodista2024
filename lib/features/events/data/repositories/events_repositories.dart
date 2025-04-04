import '../../../../core/core.dart';
import '../../events.dart';

class EventRepositoryImpl implements EventRepository {
  @override
  Future<Either<Failure, Event>> addEvent(Event event) async {
    try {
      final eventModel = EventModel(
        id: event.id,
        name: event.name,
        description: event.description,
        date: event.date,
      );

      // TODO: Implement API call here

      return Right(eventModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
