import '../../features/features.dart';
import '../core.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => EventBloc(addEventUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => AddEventUseCase(sl()));

  // Repository
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(),
  );
}
