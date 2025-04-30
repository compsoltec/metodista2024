// event_state.dart
import '../../domain/entities/entities.dart';

abstract class CourcesState {}

class CourcesLoading extends CourcesState {}

class CourcessLoaded extends CourcesState {
  final List<Cources> cources;

  CourcessLoaded(this.cources);
}

class CourcesError extends CourcesState {
  final String message;

  CourcesError(this.message);
}

class CourcesSuccess extends CourcesState {
  final String message;

  CourcesSuccess(this.message);
}

class CourcesDetailsLoaded extends CourcesState {
  final Cources cources;
  final int availableSpots;

  CourcesDetailsLoaded({
    required this.cources,
    required this.availableSpots,
  });
}
