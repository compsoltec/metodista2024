import '../../../../../core/core.dart';
import '../../domain/domain.dart';
import 'bloc.dart';

class PastoralBloc extends Bloc<PastoralEvent, PastoralState> {
  final GetPastoralsUseCase getPastoralsUseCase;
  final GetPastoralByIdUseCase getPastoralByIdUseCase;
  final CreatePastoralUseCase createPastoralUseCase;
  final UpdatePastoralUseCase updatePastoralUseCase;
  final DeletePastoralUseCase deletePastoralUseCase;

  PastoralBloc({
    required this.getPastoralsUseCase,
    required this.getPastoralByIdUseCase,
    required this.createPastoralUseCase,
    required this.updatePastoralUseCase,
    required this.deletePastoralUseCase,
  }) : super(PastoralInitial()) {
    on<FetchPastoralsEvent>(_onFetchPastorals);
    on<GetPastoralByIdEvent>(_onGetPastoralById);
    on<CreatePastoralEvent>(_onCreatePastoral);
    on<UpdatePastoralEvent>(_onUpdatePastoral);
    on<DeletePastoralEvent>(_onDeletePastoral);
  }

  Future<void> _onFetchPastorals(
      FetchPastoralsEvent event, Emitter<PastoralState> emit) async {
    emit(PastoralLoading());
    final result = await getPastoralsUseCase();
    result.fold(
      (failure) => emit(PastoralError(failure)),
      (pastorals) => emit(PastoralLoaded(pastorals)),
    );
  }

  Future<void> _onGetPastoralById(
      GetPastoralByIdEvent event, Emitter<PastoralState> emit) async {
    emit(PastoralLoading());
    final result = await getPastoralByIdUseCase(event.id);
    result.fold(
      (failure) => emit(PastoralError(failure)),
      (pastoral) => emit(PastoralDetailLoaded(pastoral)),
    );
  }

  Future<void> _onCreatePastoral(
      CreatePastoralEvent event, Emitter<PastoralState> emit) async {
    emit(PastoralLoading());
    final pastoral = Pastoral(
      id: '',
      title: event.title,
      text: event.text,
      author: event.author,
      date: event.date,
      imageUrls: event.imageUrls, // Adicionado aqui
      createdAt: DateTime.now(),
    );

    final result = await createPastoralUseCase(pastoral);
    result.fold(
      (failure) => emit(PastoralError(failure)),
      (_) => emit(PastoralSuccess(
        'Pastoral criada com sucesso!',
      )),
    );
  }

  Future<void> _onUpdatePastoral(
      UpdatePastoralEvent event, Emitter<PastoralState> emit) async {
    emit(PastoralLoading());
    final result = await updatePastoralUseCase(event.pastoral);
    result.fold(
      (failure) => emit(PastoralError(failure)),
      (_) async {
        emit(PastoralSuccess('Pastoral atualizada com sucesso!'));
        await Future.delayed(const Duration(milliseconds: 500));
        add(FetchPastoralsEvent());
      },
    );
  }

  Future<void> _onDeletePastoral(
      DeletePastoralEvent event, Emitter<PastoralState> emit) async {
    emit(PastoralLoading());
    final result = await deletePastoralUseCase(event.id);
    result.fold(
      (failure) => emit(PastoralError(failure)),
      (_) async {
        emit(PastoralSuccess('Pastoral deletada com sucesso!'));
        await Future.delayed(const Duration(milliseconds: 500));
        add(FetchPastoralsEvent());
      },
    );
  }
}
