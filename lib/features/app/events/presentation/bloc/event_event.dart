// event_event.dart
import '../../domain/entities/entities.dart';

abstract class EventEvent {}

class FetchEvents extends EventEvent {}

class CreateEvent extends EventEvent {
  final Event event;

  CreateEvent(this.event);
}

class UpdateEvent extends EventEvent {
  final Event event;

  UpdateEvent(this.event);
}

class DeleteEvent extends EventEvent {
  final String eventId;

  DeleteEvent(this.eventId);
}

class GetEventDetails extends EventEvent {
  final String eventId;
  GetEventDetails(this.eventId);
}

class GetRegistrationsByFcmTokenEvent extends EventEvent {
  final String eventId;
  final String fcmToken;

  GetRegistrationsByFcmTokenEvent({
    required this.eventId,
    required this.fcmToken,
  });
}
