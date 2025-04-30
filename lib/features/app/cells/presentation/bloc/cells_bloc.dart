// event_bloc.dart

import '../../../../../core/core.dart';
import '../../cells.dart';

class CellsBloc extends Bloc<CellsEvent, CellsState> {
  final CellsRepository eventRepository;

  CellsBloc(this.eventRepository) : super(CellsLoading()) {
    on<FetchCells>(_onFetchCells);
    on<CreateCells>(_onCreateCells);
    on<UpdateCells>(_onUpdateCells);
    on<DeleteCells>(_onDeleteCells);
    on<GetCellsDetails>(_onGetCellsDetails); // <-- Adicione essa linha
  }

  // Adicione esse método também:
  Future<void> _onGetCellsDetails(
    GetCellsDetails cells,
    Emitter<CellsState> emit,
  ) async {
    emit(CellsLoading());

    // final eventResult = await eventRepository.getCellsById(cells.eventId);
    // final registrationsResult =
    //     await eventRepository.getCellsRegistrations(cells.eventId);

    // eventResult.fold(
    //   (failure) => emit(CellsError(failure.message)),
    //   (eventData) {
    //     registrationsResult.fold(
    //       (failure) => emit(CellsError(failure.message)),
    //       (registrations) {
    //         final availableSpots = eventData.capacity - registrations.length;
    //         emit(CellsDetailsLoaded(
    //             cells: eventData, availableSpots: availableSpots));
    //       },
    //     );
    //   },
    // );
  }

  Future<void> _onFetchCells(FetchCells cells, Emitter<CellsState> emit) async {
    emit(CellsLoading());
    try {
      final result = await eventRepository.getCells();
      result.fold(
        (failure) => emit(CellsError(failure)),
        (events) => emit(CellssLoaded(events)),
      );
      print('aqui $result');
    } catch (e) {
      emit(CellsError("Failed to load events: ${e.toString()}"));
    }
  }

  Future<void> _onCreateCells(
      CreateCells cells, Emitter<CellsState> emit) async {
    try {
      final result = await eventRepository.createCells(cells.cells);
      result.fold(
        (failure) => emit(CellsError(failure)),
        (_) {
          emit(CellsSuccess("cells created successfully."));
          add(FetchCells()); // Refetch events after creation
        },
      );
    } catch (e) {
      emit(CellsError("Failed to create cells: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateCells(
      UpdateCells cells, Emitter<CellsState> emit) async {
    try {
      final result = await eventRepository.updateCells(cells.cells);
      result.fold(
        (failure) => emit(CellsError(failure)),
        (_) {
          emit(CellsSuccess("cells updated successfully."));
          add(FetchCells()); // Refetch events after update
        },
      );
    } catch (e) {
      emit(CellsError("Failed to update cells: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteCells(
      DeleteCells cells, Emitter<CellsState> emit) async {
    try {
      final result = await eventRepository.deleteCells(cells.eventId);
      result.fold(
        (failure) => emit(CellsError(failure)),
        (_) {
          emit(CellsSuccess("cells deleted successfully."));
          add(FetchCells()); // Refetch events after deletion
        },
      );
    } catch (e) {
      emit(CellsError("Failed to delete cells: ${e.toString()}"));
    }
  }
}
