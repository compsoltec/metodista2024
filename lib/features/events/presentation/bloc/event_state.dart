part of 'events_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventSuccess extends EventState {}

class EventError extends EventState {
  final String message;

  const EventError({required this.message});

  @override
  List<Object> get props => [message];
}
