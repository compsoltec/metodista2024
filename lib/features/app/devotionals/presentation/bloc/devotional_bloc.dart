import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/devotional.dart';
import '../../domain/usecases/get_devotionals.dart';

part 'devotional_event.dart';
part 'devotional_state.dart';

class DevotionalBloc extends Bloc<DevotionalEvent, DevotionalState> {
  final GetDevotionalsUseCase getDevotionals;
  final CreateDevotionalUseCase createDevotional;
  final DeleteDevotionalUseCase deleteDevotional;

  DevotionalBloc({
    required this.getDevotionals,
    required this.createDevotional,
    required this.deleteDevotional,
  }) : super(DevotionalLoading()) {
    on<FetchDevotionals>(_onFetchDevotionals);
    on<AddDevotional>(_onAddDevotional);
    on<RemoveDevotional>(_onRemoveDevotional);
  }

  Future<void> _onFetchDevotionals(
      FetchDevotionals event, Emitter<DevotionalState> emit) async {
    emit(DevotionalLoading());

    final result = await getDevotionals();

    result.fold(
      (failure) => emit(DevotionalError(failure.message)),
      (devotionals) => emit(DevotionalLoaded(devotionals)),
    );
  }

  Future<void> _onAddDevotional(
      AddDevotional event, Emitter<DevotionalState> emit) async {
    emit(DevotionalLoading());

    final result = await createDevotional(event.devotional);

    result.fold(
      (failure) => emit(DevotionalError(failure.message)),
      (_) => add(FetchDevotionals()), // Recarrega a lista após adicionar
    );
  }

  Future<void> _onRemoveDevotional(
      RemoveDevotional event, Emitter<DevotionalState> emit) async {
    emit(DevotionalLoading());

    final result = await deleteDevotional(event.devotionalId);

    result.fold(
      (failure) => emit(DevotionalError(failure.message)),
      (_) => add(FetchDevotionals()), // Recarrega a lista após deletar
    );
  }
}
