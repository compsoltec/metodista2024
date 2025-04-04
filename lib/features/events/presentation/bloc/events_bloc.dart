import '../../../../core/core.dart';
import '../../events.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final AddEventUseCase addEventUseCase;

  EventBloc({required this.addEventUseCase}) : super(EventInitial()) {
    on<AddEventRequested>(_onAddEventRequested);
  }

  Future<void> _onAddEventRequested(
    AddEventRequested event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    final result = await addEventUseCase(AddEventParams(
      name: event.name,
      description: event.description,
      date: event.date,
    ));

    result.fold(
      (failure) => emit(EventError(message: 'Failed to add event')),
      (event) => emit(EventSuccess()),
    );
  }
}
