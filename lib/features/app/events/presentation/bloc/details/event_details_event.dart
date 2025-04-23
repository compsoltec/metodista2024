// Events
abstract class EventDetailsEvent {}

class LoadEventDetails extends EventDetailsEvent {
  final String eventId;
  final String fcmToken;

  LoadEventDetails({
    required this.eventId,
    required this.fcmToken,
  });
}

class RegisterForEvent extends EventDetailsEvent {
  final String eventId;
  final String name;
  final int age;
  final String phone;
  final String church;
  final String fcmToken;

  RegisterForEvent({
    required this.eventId,
    required this.name,
    required this.age,
    required this.phone,
    required this.church,
    required this.fcmToken,
  });
}

class CancelRegistration extends EventDetailsEvent {
  final String eventId;
  final String registrationId;
  final String fcmToken;

  CancelRegistration({
    required this.eventId,
    required this.registrationId,
    required this.fcmToken,
  });
}
