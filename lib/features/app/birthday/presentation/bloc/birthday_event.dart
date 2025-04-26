abstract class BirthdayEvent {}

class FetchBirthdays extends BirthdayEvent {}

class CreateBirthdayEvent extends BirthdayEvent {
  final String name;
  final DateTime birthDate;

  CreateBirthdayEvent({
    required this.name,
    required this.birthDate,
  });
}

class DeleteBirthdayEvent extends BirthdayEvent {
  final String birthdayId;

  DeleteBirthdayEvent(this.birthdayId);
}

class FetchBirthdaysTodayEvent extends BirthdayEvent {}
