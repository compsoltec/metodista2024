import '../../../domain/entities/entities.dart';

abstract class EventDetailsState {}

class EventDetailsLoading extends EventDetailsState {}

class EventDetailsLoaded extends EventDetailsState {
  final Event event;
  final bool isUserRegistered;
  final List<Registration> registrations;
  final String fcmToken;

  EventDetailsLoaded(
      {required this.event,
      required this.isUserRegistered,
      required this.registrations,
      required this.fcmToken});

  int get availableSpots => event.capacity - registrations.length;
  bool get hasAvailableSpots => availableSpots > 0;
}

class EventDetailsError extends EventDetailsState {
  final String message;
  EventDetailsError(this.message);
}

class RegistrationSuccess extends EventDetailsState {
  final String message;
  RegistrationSuccess(this.message);
}
