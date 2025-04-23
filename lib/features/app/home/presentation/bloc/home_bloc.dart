import '../../../../../core/core.dart';
import '../../home.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeBloc({required this.getHomeDataUseCase}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final result = await getHomeDataUseCase();

    result.fold(
      (failure) => emit(HomeError(message: 'Failed to load home data')),
      (data) => emit(HomeLoaded(data: data)),
    );
  }
}
