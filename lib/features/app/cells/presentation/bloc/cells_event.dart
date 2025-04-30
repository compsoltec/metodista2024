// event_event.dart
import '../../domain/entities/entities.dart';

abstract class CellsEvent {}

class FetchCells extends CellsEvent {}

class CreateCells extends CellsEvent {
  final Cells cells;

  CreateCells(this.cells);
}

class UpdateCells extends CellsEvent {
  final Cells cells;

  UpdateCells(this.cells);
}

class DeleteCells extends CellsEvent {
  final String eventId;

  DeleteCells(this.eventId);
}

class GetCellsDetails extends CellsEvent {
  final String eventId;
  GetCellsDetails(this.eventId);
}
