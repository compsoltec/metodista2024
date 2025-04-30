// event_state.dart
import '../../domain/entities/entities.dart';

abstract class NoticesState {}

class NoticesLoading extends NoticesState {}

class NoticessLoaded extends NoticesState {
  final List<Notices> notices;

  NoticessLoaded(this.notices);
}

class NoticesError extends NoticesState {
  final String message;

  NoticesError(this.message);
}

class NoticesSuccess extends NoticesState {
  final String message;

  NoticesSuccess(this.message);
}

class NoticesDetailsLoaded extends NoticesState {
  final Notices notices;
  final int availableSpots;

  NoticesDetailsLoaded({
    required this.notices,
    required this.availableSpots,
  });
}
