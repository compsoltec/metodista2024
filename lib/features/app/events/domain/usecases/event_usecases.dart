// Caso de uso para buscar eventos
import '../../../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/event_repository.dart';

class GetEventsUseCase {
  final EventRepository repository;

  GetEventsUseCase(this.repository);

  Future<Either<Failure, List<Event>>> call() {
    return repository.getEvents();
  }
}

class GetEventByIdUseCase {
  final EventRepository repository;

  GetEventByIdUseCase(this.repository);

  Future<Either<Failure, Event>> call(String eventId) {
    return repository.getEventById(eventId);
  }
}

class CreateEventUseCase {
  final EventRepository repository;

  CreateEventUseCase(this.repository);

  Future<Either<Failure, void>> call(Event event) {
    return repository.createEvent(event);
  }
}

class UpdateEventUseCase {
  final EventRepository repository;

  UpdateEventUseCase(this.repository);

  Future<Either<Failure, void>> call(Event event) {
    return repository.updateEvent(event);
  }
}

class DeleteEventUseCase {
  final EventRepository repository;

  DeleteEventUseCase(this.repository);

  Future<Either<Failure, void>> call(String eventId) {
    return repository.deleteEvent(eventId);
  }
}

class RegisterForEventUseCase {
  final EventRepository repository;

  RegisterForEventUseCase(this.repository);

  Future<Either<Failure, void>> call(
      String eventId, Registration registration) {
    return repository.registerForEvent(eventId, registration);
  }
}

class CancelRegistrationUseCase {
  final EventRepository repository;

  CancelRegistrationUseCase(this.repository);

  Future<Either<Failure, void>> call(String eventId, String registrationId) {
    return repository.cancelRegistration(eventId, registrationId);
  }
}
