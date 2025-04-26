// Repositório de Eventos
import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getEvents();
  Future<Either<Failure, Event>> getEventById(String eventId);
  Future<Either<Failure, Event>> createEvent(Event event);
  Future<Either<Failure, Event>> updateEvent(Event event);
  Future<Either<Failure, void>> deleteEvent(String eventId);
  Future<Either<Failure, Registration>> registerForEvent(
      String eventId, Registration registration);
  Future<Either<Failure, List<Registration>>> getEventRegistrations(
      String eventId);
  Future<Either<Failure, void>> cancelRegistration(
      String eventId, String registrationId);
  Future<Either<Failure, List<Registration>>> getRegistrationsByFcmToken(
      String eventId, String fcmToken);
}
