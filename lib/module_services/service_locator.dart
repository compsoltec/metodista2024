import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import '../modulo_atividade/modulo_atividade.dart';
import '../modulo_documentos/modulo_documentos.dart';
import 'sharedPreference_services.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerFactory<Dio>(
    () => Dio(),
  );
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  getIt.registerSingletonWithDependencies<SharedPreferenceModule>(
      () => SharedPreferenceModule(pref: getIt<SharedPreferences>()),
      dependsOn: [SharedPreferences]);
  //atividade feature
  getIt.registerFactory<AtividadeDatasource>(
    () => AtividadeDatasourceImpl(
      dio: getIt(),
    ),
  );
  getIt.registerFactory<AtividadeCubit>(
    () => AtividadeCubit(usecase: getIt()),
  );
  getIt.registerFactory<AtividadeRepository>(
    () => AtividadeRepositoryImpl(
      atividadeDatasource: getIt(),
    ),
  );
  getIt.registerFactory<DoAtividadeUsecase>(
    () => DoAtividadeUsecaseImpl(
      atividadeRepository: getIt(),
    ),
  );

  //documentos feature
  getIt.registerFactory<DocumentosDatasource>(
    () => DocumentosDatasourceImpl(
      dio: getIt(),
    ),
  );
  getIt.registerFactory<DocumentosRepository>(
    () => DocumentosRepositoryImpl(
      documentosDatasource: getIt(),
    ),
  );
  getIt.registerFactory<DoDocumentosUsecase>(
    () => DoDocumentosUsecaseImpl(
      documentosRepository: getIt(),
    ),
  );
  getIt.registerFactory<DocumentosCubit>(
    () => DocumentosCubit(usecase: getIt()),
  );
}
