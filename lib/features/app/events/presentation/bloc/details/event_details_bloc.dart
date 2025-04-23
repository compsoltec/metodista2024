// event_details_bloc.dart
import '../../../../../../core/core.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/event_repository.dart';
import 'event_details_event.dart';
import 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  final EventRepository eventRepository;

  EventDetailsBloc({required this.eventRepository})
      : super(EventDetailsLoading()) {
    on<LoadEventDetails>(_onLoadEventDetails);
    on<RegisterForEvent>(_onRegisterForEvent);
    on<CancelRegistration>(_onCancelRegistration);
  }

  Future<void> _onLoadEventDetails(
    LoadEventDetails event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(EventDetailsLoading());
    try {
      final eventResult = await eventRepository.getEventById(event.eventId);

      await eventResult.fold(
        (failure) async => emit(EventDetailsError(failure.message)),
        (eventDetails) async {
          final registrationsResult =
              await eventRepository.getEventRegistrations(event.eventId);

          registrationsResult.fold(
            (failure) => emit(EventDetailsError(failure.message)),
            (registrations) {
              final isUserRegistered = registrations.any(
                (registration) => registration.fcmToken == event.fcmToken,
              );

              emit(EventDetailsLoaded(
                event: eventDetails,
                isUserRegistered: isUserRegistered,
                registrations: registrations,
                fcmToken: event.fcmToken,
              ));
            },
          );
        },
      );
    } catch (e) {
      emit(EventDetailsError(
          "Erro ao carregar detalhes do evento: ${e.toString()}"));
    }
  }

  Future<void> _onRegisterForEvent(
    RegisterForEvent event,
    Emitter<EventDetailsState> emit,
  ) async {
    try {
      final registration = Registration(
        id: '',
        eventId: event.eventId,
        name: event.name,
        age: event.age,
        phone: event.phone,
        church: event.church,
        createdAt: DateTime.now().toIso8601String(),
        fcmToken: event.fcmToken,
      );

      final result =
          await eventRepository.registerForEvent(event.eventId, registration);

      result.fold(
        (failure) => emit(EventDetailsError(failure.message)),
        (_) {
          emit(RegistrationSuccess("Inscrição realizada com sucesso!"));
          add(LoadEventDetails(
              eventId: event.eventId, fcmToken: event.fcmToken));
        },
      );
    } catch (e) {
      emit(EventDetailsError("Erro ao realizar inscrição: ${e.toString()}"));
    }
  }

  Future<void> _onCancelRegistration(
    CancelRegistration event,
    Emitter<EventDetailsState> emit,
  ) async {
    try {
      final result = await eventRepository.cancelRegistration(
          event.eventId, event.registrationId);

      result.fold(
        (failure) => emit(EventDetailsError(failure.message)),
        (_) {
          emit(RegistrationSuccess("Inscrição cancelada com sucesso!"));
          add(LoadEventDetails(
              eventId: event.eventId, fcmToken: event.fcmToken));
        },
      );
    } catch (e) {
      emit(EventDetailsError("Falha ao cancelar inscrição: ${e.toString()}"));
    }
  }
}
