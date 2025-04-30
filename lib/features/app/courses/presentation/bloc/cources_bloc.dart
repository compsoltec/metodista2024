// event_bloc.dart

import '../../../../../core/core.dart';
import '../../cources.dart';

class CourcesBloc extends Bloc<CourcesCources, CourcesState> {
  final CourcesRepository eventRepository;

  CourcesBloc(this.eventRepository) : super(CourcesLoading()) {
    on<FetchCources>(_onFetchCources);
    on<CreateCources>(_onCreateCources);
    on<UpdateCources>(_onUpdateCources);
    on<DeleteCources>(_onDeleteCources);
    on<GetCourcesDetails>(_onGetCourcesDetails); // <-- Adicione essa linha
  }

  // Adicione esse método também:
  Future<void> _onGetCourcesDetails(
    GetCourcesDetails cources,
    Emitter<CourcesState> emit,
  ) async {
    emit(CourcesLoading());

    // final eventResult = await eventRepository.getCourcesById(cources.eventId);
    // final registrationsResult =
    //     await eventRepository.getCourcesRegistrations(cources.eventId);

    // eventResult.fold(
    //   (failure) => emit(CourcesError(failure.message)),
    //   (eventData) {
    //     registrationsResult.fold(
    //       (failure) => emit(CourcesError(failure.message)),
    //       (registrations) {
    //         final availableSpots = eventData.capacity - registrations.length;
    //         emit(CourcesDetailsLoaded(
    //             cources: eventData, availableSpots: availableSpots));
    //       },
    //     );
    //   },
    // );
  }

  Future<void> _onFetchCources(
      FetchCources cources, Emitter<CourcesState> emit) async {
    emit(CourcesLoading());
    try {
      final result = await eventRepository.getCources();
      result.fold(
        (failure) => emit(CourcesError(failure)),
        (events) => emit(CourcessLoaded(events)),
      );
      print('aqui $result');
    } catch (e) {
      emit(CourcesError("Failed to load events: ${e.toString()}"));
    }
  }

  Future<void> _onCreateCources(
      CreateCources cources, Emitter<CourcesState> emit) async {
    try {
      final result = await eventRepository.createCources(cources.cources);
      result.fold(
        (failure) => emit(CourcesError(failure)),
        (_) {
          emit(CourcesSuccess("cources created successfully."));
          add(FetchCources()); // Refetch events after creation
        },
      );
    } catch (e) {
      emit(CourcesError("Failed to create cources: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateCources(
      UpdateCources cources, Emitter<CourcesState> emit) async {
    try {
      final result = await eventRepository.updateCources(cources.cources);
      result.fold(
        (failure) => emit(CourcesError(failure)),
        (_) {
          emit(CourcesSuccess("cources updated successfully."));
          add(FetchCources()); // Refetch events after update
        },
      );
    } catch (e) {
      emit(CourcesError("Failed to update cources: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteCources(
      DeleteCources cources, Emitter<CourcesState> emit) async {
    try {
      final result = await eventRepository.deleteCources(cources.eventId);
      result.fold(
        (failure) => emit(CourcesError(failure)),
        (_) {
          emit(CourcesSuccess("cources deleted successfully."));
          add(FetchCources()); // Refetch events after deletion
        },
      );
    } catch (e) {
      emit(CourcesError("Failed to delete cources: ${e.toString()}"));
    }
  }
}
