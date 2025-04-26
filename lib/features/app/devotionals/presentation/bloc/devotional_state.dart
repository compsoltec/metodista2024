part of 'devotional_bloc.dart';

abstract class DevotionalState {}

class DevotionalInitial extends DevotionalState {}

class DevotionalLoading extends DevotionalState {}

class DevotionalLoaded extends DevotionalState {
  final List<Devotional> devotionals;

  DevotionalLoaded(this.devotionals);
}

class DevotionalError extends DevotionalState {
  final String message;

  DevotionalError(this.message);
}
