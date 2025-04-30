import 'package:http/http.dart' as http;
import 'package:metodista/features/app/notices/presentation/bloc/notices_bloc.dart';

import '../../features/app/notices/notices.dart';
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
  sl.registerFactory(() => CourcesBloc(sl()));
  sl.registerFactory(() => NoticesBloc(sl()));

  sl.registerFactory(() => DevotionalBloc(
      getDevotionals: sl(), createDevotional: sl(), deleteDevotional: sl()));
  sl.registerFactory(() => YoutubeBloc(sl()));
  sl.registerFactory(() => BirthdayBloc(
        getBirthdaysUseCase: sl(),
        createBirthdayUseCase: sl(),
        deleteBirthdayUseCase: sl(),
        getBirthdaysTodayUseCase: sl(),
      ));
  sl.registerFactory(() => PastoralBloc(
      getPastoralsUseCase: sl(),
      getPastoralByIdUseCase: sl(),
      createPastoralUseCase: sl(),
      updatePastoralUseCase: sl(),
      deletePastoralUseCase: sl()));
  sl.registerFactory(() => PreachingBloc(
      getPreaching: sl(), createPreaching: sl(), deletePreaching: sl()));
  sl.registerFactory(() => CellsBloc(sl()));
  //! Use cases
  // Home
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));

  //Devotional
  sl.registerLazySingleton(() => GetDevotionalsUseCase(sl()));
  sl.registerLazySingleton(() => CreateDevotionalUseCase(sl()));
  sl.registerLazySingleton(() => DeleteDevotionalUseCase(sl()));
  sl.registerLazySingleton(() => GetBirthdaysTodayUseCase(sl()));

  //Cources
  sl.registerLazySingleton(() => CreateCourcesUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCourcesUseCase(sl()));
  sl.registerLazySingleton(() => GetCourcessUseCase(sl()));

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

  //Pastoral

  sl.registerLazySingleton(() => CreatePastoralUseCase(sl())); // Added
  sl.registerLazySingleton(() => GetPastoralsUseCase(sl())); // Added
  sl.registerLazySingleton(() => GetPastoralByIdUseCase(sl())); // Added
  sl.registerLazySingleton(() => UpdatePastoralUseCase(sl())); // Added
  sl.registerLazySingleton(() => DeletePastoralUseCase(sl())); // Added

  //Preaching
  sl.registerLazySingleton(() => GetPreachingUseCase(sl()));
  sl.registerLazySingleton(() => CreatePreachingUseCase(sl()));
  sl.registerLazySingleton(() => DeletePreachingUseCase(sl()));

  //Cells
  sl.registerLazySingleton(() => CreateCellsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCellsUseCase(sl()));
  sl.registerLazySingleton(() => GetCellssUseCase(sl()));

  //Notices
  sl.registerLazySingleton(() => CreateNoticesUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNoticesUseCase(sl()));
  sl.registerLazySingleton(() => GetNoticessUseCase(sl()));

  //! Repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(sl()));
  sl.registerLazySingleton<CourcesRepository>(
      () => CourcesRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<YoutubeRepository>(
      () => YoutubeRepositoryImpl(sl()));
  sl.registerLazySingleton<PreachingRepository>(
      () => PreachingRepositoryImpl(sl()));

  sl.registerLazySingleton<DevotionalRepository>(
      () => DevotionalRepositoryImpl(sl()));
  sl.registerLazySingleton<BirthdayRepository>(
      () => BirthdayRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<PastoralRepository>(
      () => PastoralRepositoryImpl(sl()));
  sl.registerLazySingleton<CellsRepository>(
      () => CellsRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<NoticesRepository>(
      () => NoticesRemoteDataSourceImpl(sl()));
}
