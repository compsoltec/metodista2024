// event_bloc.dart

import '../../../../../core/core.dart';
import '../../domain/repositories/event_repository.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;

  EventBloc(this.eventRepository) : super(EventLoading()) {
    on<FetchEvents>(_onFetchEvents);
    on<CreateEvent>(_onCreateEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
  }

  Future<void> _onFetchEvents(
      FetchEvents event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final result = await eventRepository.getEvents();
      result.fold(
        (failure) => emit(EventError(failure.message)),
        (events) => emit(EventsLoaded(events)),
      );
    } catch (e) {
      emit(EventError("Failed to load events: ${e.toString()}"));
    }
  }

  Future<void> _onCreateEvent(
      CreateEvent event, Emitter<EventState> emit) async {
    try {
      final result = await eventRepository.createEvent(event.event);
      result.fold(
        (failure) => emit(EventError(failure.message)),
        (_) {
          emit(EventSuccess("Event created successfully."));
          add(FetchEvents()); // Refetch events after creation
        },
      );
    } catch (e) {
      emit(EventError("Failed to create event: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateEvent(
      UpdateEvent event, Emitter<EventState> emit) async {
    try {
      final result = await eventRepository.updateEvent(event.event);
      result.fold(
        (failure) => emit(EventError(failure.message)),
        (_) {
          emit(EventSuccess("Event updated successfully."));
          add(FetchEvents()); // Refetch events after update
        },
      );
    } catch (e) {
      emit(EventError("Failed to update event: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteEvent(
      DeleteEvent event, Emitter<EventState> emit) async {
    try {
      final result = await eventRepository.deleteEvent(event.eventId);
      result.fold(
        (failure) => emit(EventError(failure.message)),
        (_) {
          emit(EventSuccess("Event deleted successfully."));
          add(FetchEvents()); // Refetch events after deletion
        },
      );
    } catch (e) {
      emit(EventError("Failed to delete event: ${e.toString()}"));
    }
  }
}
