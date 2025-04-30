part of 'preaching_bloc.dart';

abstract class PreachingState {}

class PreachingInitial extends PreachingState {}

class PreachingLoading extends PreachingState {}

class PreachingLoaded extends PreachingState {
  final List<Preaching> preachings;

  PreachingLoaded(this.preachings);
}

class PreachingError extends PreachingState {
  final String message;

  PreachingError(this.message);
}
