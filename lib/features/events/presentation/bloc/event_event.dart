part of 'events_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class AddEventRequested extends EventEvent {
  final String name;
  final String description;
  final DateTime date;

  const AddEventRequested({
    required this.name,
    required this.description,
    required this.date,
  });

  @override
  List<Object> get props => [name, description, date];
}
