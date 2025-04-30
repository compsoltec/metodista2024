import '../../domain/domain.dart';

abstract class PastoralState {}

class PastoralInitial extends PastoralState {}

class PastoralLoading extends PastoralState {}

class PastoralLoaded extends PastoralState {
  final List<Pastoral> pastorals;
  PastoralLoaded(this.pastorals);
}

class PastoralDetailLoaded extends PastoralState {
  final Pastoral pastoral;
  PastoralDetailLoaded(this.pastoral);
}

class PastoralSuccess extends PastoralState {
  final String message;
  PastoralSuccess(this.message);
}

class PastoralError extends PastoralState {
  final String message;
  PastoralError(this.message);
}
