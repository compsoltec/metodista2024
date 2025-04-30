import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';

part 'preaching_event.dart';
part 'preaching_state.dart';

class PreachingBloc extends Bloc<PreachingEvent, PreachingState> {
  final GetPreachingUseCase getPreaching;
  final CreatePreachingUseCase createPreaching;
  final DeletePreachingUseCase deletePreaching;

  PreachingBloc({
    required this.getPreaching,
    required this.createPreaching,
    required this.deletePreaching,
  }) : super(PreachingLoading()) {
    on<FetchPreachings>(_onFetchPreaching);
    on<AddPreaching>(_onAddPreaching);
    on<RemovePreaching>(_onRemovePreaching);
  }

  Future<void> _onFetchPreaching(
      FetchPreachings event, Emitter<PreachingState> emit) async {
    emit(PreachingLoading());

    final result = await getPreaching();

    result.fold(
      (failure) => emit(PreachingError(failure.message)),
      (preaching) => emit(PreachingLoaded(preaching)),
    );
  }

  Future<void> _onAddPreaching(
      AddPreaching event, Emitter<PreachingState> emit) async {
    emit(PreachingLoading());

    final result = await createPreaching(event.preaching);

    result.fold(
      (failure) => emit(PreachingError(failure.message)),
      (_) => add(FetchPreachings()), // Recarrega a lista após adicionar
    );
  }

  Future<void> _onRemovePreaching(
      RemovePreaching event, Emitter<PreachingState> emit) async {
    emit(PreachingLoading());

    final result = await deletePreaching(event.preachingId);

    result.fold(
      (failure) => emit(PreachingError(failure.message)),
      (_) => add(FetchPreachings()), // Recarrega a lista após deletar
    );
  }
}
