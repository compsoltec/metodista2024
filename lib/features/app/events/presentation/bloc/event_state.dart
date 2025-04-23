// event_state.dart
import '../../domain/entities/entities.dart';

abstract class EventState {}

class EventLoading extends EventState {}

class EventsLoaded extends EventState {
  final List<Event> events;

  EventsLoaded(this.events);
}

class EventError extends EventState {
  final String message;

  EventError(this.message);
}

class EventSuccess extends EventState {
  final String message;

  EventSuccess(this.message);
}

class EventDetailsLoaded extends EventState {
  final Event event;
  final int availableSpots;

  EventDetailsLoaded({
    required this.event,
    required this.availableSpots,
  });
}
