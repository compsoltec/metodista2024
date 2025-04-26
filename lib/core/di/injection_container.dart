import 'package:http/http.dart' as http;
import 'package:metodista/features/app/events/data/repositories/event_repository_impl.dart';
import 'package:metodista/features/app/events/presentation/bloc/event_bloc.dart';
import 'package:metodista/features/app/youtube/youtube.dart';

import '../../features/app/events/domain/domain.dart';
import '../../features/features.dart';
import '../core.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => YoutubeRemoteDataSource(sl()));

  //! Blocs
  sl.registerFactory(() => HomeBloc(getHomeDataUseCase: sl()));
  sl.registerFactory(() => EventBloc(sl()));
  sl.registerFactory(() => DevotionalBloc(
      getDevotionals: sl(), createDevotional: sl(), deleteDevotional: sl()));
  sl.registerFactory(() => YoutubeBloc(sl()));
  sl.registerFactory(() => BirthdayBloc(
        getBirthdaysUseCase: sl(),
        createBirthdayUseCase: sl(),
        deleteBirthdayUseCase: sl(),
        getBirthdaysTodayUseCase: sl(),
      ));

  //! Use cases
  // Home
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));

  //Devotional
  sl.registerLazySingleton(() => GetDevotionalsUseCase(sl()));
  sl.registerLazySingleton(() => CreateDevotionalUseCase(sl()));
  sl.registerLazySingleton(() => DeleteDevotionalUseCase(sl()));
  sl.registerLazySingleton(() => GetBirthdaysTodayUseCase(sl()));

  // Events
  sl.registerLazySingleton(() => GetEventsUseCase(sl()));
  sl.registerLazySingleton(() => GetEventByIdUseCase(sl()));
  sl.registerLazySingleton(() => CreateEventUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEventUseCase(sl())); // Added
  sl.registerLazySingleton(() => DeleteEventUseCase(sl())); // Added
  sl.registerLazySingleton(() => RegisterForEventUseCase(sl()));
  sl.registerLazySingleton(() => CancelRegistrationUseCase(sl())); // Added
  sl.registerLazySingleton(
      () => GetRegistrationsByFcmTokenUseCase(sl())); // Added

  //Youtube
  sl.registerLazySingleton(() => GetYoutubeVideosUseCase(sl()));

  //BirthDay
  sl.registerLazySingleton(() => GetBirthdaysUseCase(sl()));
  sl.registerLazySingleton(() => CreateBirthdayUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBirthdayUseCase(sl()));
  //! Repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(sl()));
  sl.registerLazySingleton<YoutubeRepository>(
      () => YoutubeRepositoryImpl(sl()));

  sl.registerLazySingleton<DevotionalRepository>(
      () => DevotionalRepositoryImpl(sl()));
  sl.registerLazySingleton<BirthdayRepository>(
      () => BirthdayRemoteDataSourceImpl(sl()));
}
