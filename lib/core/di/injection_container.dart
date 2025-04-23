import 'package:http/http.dart' as http;
import 'package:metodista/features/app/events/data/repositories/event_repository_impl.dart';
import 'package:metodista/features/app/events/domain/repositories/event_repository.dart';
import 'package:metodista/features/app/events/presentation/bloc/event_bloc.dart';

import '../../features/app/events/domain/domain.dart';
import '../../features/features.dart';
import '../core.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  sl.registerLazySingleton(() => http.Client());

  //! Blocs
  sl.registerFactory(() => HomeBloc(getHomeDataUseCase: sl()));
  sl.registerFactory(() => EventBloc(sl()));

  //! Use cases
  // Home
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));

  // Events
  sl.registerLazySingleton(() => GetEventsUseCase(sl()));
  sl.registerLazySingleton(() => GetEventByIdUseCase(sl()));
  sl.registerLazySingleton(() => CreateEventUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEventUseCase(sl())); // Added
  sl.registerLazySingleton(() => DeleteEventUseCase(sl())); // Added
  sl.registerLazySingleton(() => RegisterForEventUseCase(sl()));
  sl.registerLazySingleton(() => CancelRegistrationUseCase(sl())); // Added

  //! Repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(sl()));
}
