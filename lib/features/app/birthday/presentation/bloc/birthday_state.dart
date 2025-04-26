import '../../domain/domain.dart';

abstract class BirthdayState {}

class BirthdayInitial extends BirthdayState {}

class BirthdayLoading extends BirthdayState {}

class BirthdayLoaded extends BirthdayState {
  final List<Birthday> birthdays;

  BirthdayLoaded(this.birthdays);
}

class BirthdayError extends BirthdayState {
  final String message;

  BirthdayError(this.message);
}

class BirthdaySuccess extends BirthdayState {
  final String message;

  BirthdaySuccess(this.message);
}

class BirthdayLoadedToday extends BirthdayState {
  final List<Birthday> birthdays;

  BirthdayLoadedToday(this.birthdays);
}
