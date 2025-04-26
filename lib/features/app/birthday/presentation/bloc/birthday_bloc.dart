import '../../../../../core/core.dart';
import '../../domain/domain.dart';
import 'bloc.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  final GetBirthdaysUseCase getBirthdaysUseCase;
  final GetBirthdaysTodayUseCase getBirthdaysTodayUseCase; // <-- Novo UseCase
  final CreateBirthdayUseCase createBirthdayUseCase;
  final DeleteBirthdayUseCase deleteBirthdayUseCase;

  BirthdayBloc({
    required this.getBirthdaysUseCase,
    required this.getBirthdaysTodayUseCase, // <-- Adicione aqui também
    required this.createBirthdayUseCase,
    required this.deleteBirthdayUseCase,
  }) : super(BirthdayInitial()) {
    on<FetchBirthdays>(_onFetchBirthdays);
    on<FetchBirthdaysTodayEvent>(_onFetchBirthdaysToday);
    on<CreateBirthdayEvent>(_onCreateBirthday);
    on<DeleteBirthdayEvent>(_onDeleteBirthday);
  }
  Future<void> _onFetchBirthdays(
      FetchBirthdays event, Emitter<BirthdayState> emit) async {
    emit(BirthdayLoading());
    final result = await getBirthdaysUseCase();

    result.fold(
      (failure) => emit(BirthdayError(failure)),
      (birthdays) => emit(BirthdayLoaded(birthdays)),
    );
  }

  Future<void> _onCreateBirthday(
    CreateBirthdayEvent event,
    Emitter<BirthdayState> emit,
  ) async {
    emit(BirthdayLoading());

    final birthday = Birthday(
      id: '',
      name: event.name,
      birthDate: event.birthDate,
      isBirthdayToday: false,
      createdAt: DateTime.now().toIso8601String(),
    );

    final result = await createBirthdayUseCase(birthday);

    result.fold(
      (failure) => emit(BirthdayError(failure)), // Sem .message
      (_) {
        emit(BirthdaySuccess('Aniversariante criado com sucesso!'));
        add(FetchBirthdays());
      },
    );
  }

  Future<void> _onFetchBirthdaysToday(
      FetchBirthdaysTodayEvent event, Emitter<BirthdayState> emit) async {
    emit(BirthdayLoading());
    final result = await getBirthdaysTodayUseCase();

    result.fold(
      (failure) => emit(BirthdayError(failure)),
      (birthdays) => emit(BirthdayLoadedToday(birthdays)),
    );
  }

  Future<void> _onDeleteBirthday(
      DeleteBirthdayEvent event, Emitter<BirthdayState> emit) async {
    emit(BirthdayLoading());
    final result = await deleteBirthdayUseCase(event.birthdayId);

    result.fold(
      (failure) => emit(BirthdayError(failure)),
      (_) {
        emit(BirthdaySuccess('Aniversariante deletado com sucesso!'));
        add(FetchBirthdays());
      },
    );
  }
}
