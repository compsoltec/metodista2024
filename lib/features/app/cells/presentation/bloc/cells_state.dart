// event_state.dart
import '../../domain/entities/entities.dart';

abstract class CellsState {}

class CellsLoading extends CellsState {}

class CellssLoaded extends CellsState {
  final List<Cells> cells;

  CellssLoaded(this.cells);
}

class CellsError extends CellsState {
  final String message;

  CellsError(this.message);
}

class CellsSuccess extends CellsState {
  final String message;

  CellsSuccess(this.message);
}

class CellsDetailsLoaded extends CellsState {
  final Cells cells;
  final int availableSpots;

  CellsDetailsLoaded({
    required this.cells,
    required this.availableSpots,
  });
}
