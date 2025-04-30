// event_bloc.dart

import '../../../../../core/core.dart';
import '../../notices.dart';
import 'bloc.dart';

class NoticesBloc extends Bloc<NoticesEvent, NoticesState> {
  final NoticesRepository eventRepository;

  NoticesBloc(this.eventRepository) : super(NoticesLoading()) {
    on<FetchNotices>(_onFetchNotices);
    on<CreateNotices>(_onCreateNotices);
    on<UpdateNotices>(_onUpdateNotices);
    on<DeleteNotices>(_onDeleteNotices);
    on<GetNoticesDetails>(_onGetNoticesDetails); // <-- Adicione essa linha
  }

  // Adicione esse método também:
  Future<void> _onGetNoticesDetails(
    GetNoticesDetails notices,
    Emitter<NoticesState> emit,
  ) async {
    emit(NoticesLoading());
  }

  Future<void> _onFetchNotices(
      FetchNotices notices, Emitter<NoticesState> emit) async {
    emit(NoticesLoading());
    try {
      final result = await eventRepository.getNotices();
      result.fold(
        (failure) => emit(NoticesError(failure)),
        (notices) => emit(NoticessLoaded(notices)),
      );
      print('aqui $result');
    } catch (e) {
      emit(NoticesError("Failed to load notices: ${e.toString()}"));
    }
  }

  Future<void> _onCreateNotices(
      CreateNotices notices, Emitter<NoticesState> emit) async {
    try {
      final result = await eventRepository.createNotices(notices.notices);
      result.fold(
        (failure) => emit(NoticesError(failure)),
        (_) {
          emit(NoticesSuccess("notices created successfully."));
          add(FetchNotices()); // Refetch notices after creation
        },
      );
    } catch (e) {
      emit(NoticesError("Failed to create notices: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateNotices(
      UpdateNotices notices, Emitter<NoticesState> emit) async {
    try {
      final result = await eventRepository.updateNotices(notices.notices);
      result.fold(
        (failure) => emit(NoticesError(failure)),
        (_) {
          emit(NoticesSuccess("notices updated successfully."));
          add(FetchNotices()); // Refetch notices after update
        },
      );
    } catch (e) {
      emit(NoticesError("Failed to update notices: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteNotices(
      DeleteNotices notices, Emitter<NoticesState> emit) async {
    try {
      final result = await eventRepository.deleteNotices(notices.eventId);
      result.fold(
        (failure) => emit(NoticesError(failure)),
        (_) {
          emit(NoticesSuccess("notices deleted successfully."));
          add(FetchNotices()); // Refetch notices after deletion
        },
      );
    } catch (e) {
      emit(NoticesError("Failed to delete notices: ${e.toString()}"));
    }
  }
}
