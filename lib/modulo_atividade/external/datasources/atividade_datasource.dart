import 'package:dio/dio.dart';

import '../../../module_config/constants/api_constants.dart';
import '../../../module_services/module_services.dart';
import '../../../module_services/service_locator.dart';
import '../../domain/domain.dart';
import '../../infra/infra.dart';
import '../external.dart';

class AtividadeDatasourceImpl implements AtividadeDatasource {
  final Dio dio;

  AtividadeDatasourceImpl({
    required this.dio,
  });

  @override
  Future<AtividadeResponse> doAtividade(
      {required AtividadeRequestEntity atividadeRequestEntity}) async {
    try {
      final Response result = await dio.post(
        ApiConstants().baseUrl + ApiConstants().atividades,
        data: AtividadeRequestEntityMapper.toMap(
          entity: atividadeRequestEntity,
        ),
      );

      if (result.statusCode == 200) {
        final AtividadeResponse userInfoEntity =
            AtividadeResponseEntityMapper.fromMap(
                map: result.data as Map<String, dynamic>);
        return userInfoEntity;
      } else {
        throw DataSourceAtividadeFailure(errorMessage: result.data!['error']);
      }
      // ignore: deprecated_member_use
    } on DioError catch (error, stackTrace) {
      // ignore: deprecated_member_use
      final List<DioErrorType> dioErrorTypes = [
        // ignore: deprecated_member_use
        DioErrorType.connectionTimeout,
        // ignore: deprecated_member_use
        DioErrorType.receiveTimeout,
        // ignore: deprecated_member_use
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - doAtividade',
        );
      } else {
        throw UnknownAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - doAtividade',
        );
      }
    }
  }

  @override
  Future<AtividadeResponse> deleteAtividade() async {
    try {
      final Response result = await dio.delete(
        ApiConstants().baseUrl + ApiConstants().atividades,
      );

      if (result.statusCode == 200) {
        final AtividadeResponse userInfoEntity =
            AtividadeResponseEntityMapper.fromMap(
                map: result.data as Map<String, dynamic>);
        return userInfoEntity;
      } else {
        throw DataSourceAtividadeFailure(errorMessage: result.data!['error']);
      }
      // ignore: deprecated_member_use
    } on DioError catch (error, stackTrace) {
      // ignore: deprecated_member_use
      final List<DioErrorType> dioErrorTypes = [
        // ignore: deprecated_member_use
        DioErrorType.connectionTimeout,
        // ignore: deprecated_member_use
        DioErrorType.receiveTimeout,
        // ignore: deprecated_member_use
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - doAtividade',
        );
      } else {
        throw UnknownAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - doAtividade',
        );
      }
    }
  }

  @override
  Future<List<AtividadeEntity>> getAtividade() async {
    try {
      final Response result = await dio.get(
        ApiConstants().baseUrl + ApiConstants().atividades,
      );

      if (result.statusCode == 200) {
        final responseData = (result.data['data'] ?? []) as List;

        final atividade = responseData
            .map((car) => AtividadeEntityMapper.fromMap(map: car))
            .toList();

        return atividade;
      } else {
        throw DataSourceAtividadeFailure(
          errorMessage: result.data!['status_message'],
        );
      }
      // ignore: deprecated_member_use
    } on DioError catch (error, stackTrace) {
      // ignore: deprecated_member_use
      final List<DioErrorType> dioErrorTypes = [
        // ignore: deprecated_member_use
        DioErrorType.connectionTimeout,
        // ignore: deprecated_member_use
        DioErrorType.receiveTimeout,
        // ignore: deprecated_member_use
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - getAtividade',
        );
      } else {
        throw UnknownAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - getAtividade',
        );
      }
    }
  }

  Future<List<InscritosRequestEntity>> getAllInscritos(
      {required atividadeId}) async {
    final SharedPreferenceModule pref = getIt.get();

    try {
      final Response result = await dio.get(
        '${ApiConstants().baseUrl}${ApiConstants().atividades}/$atividadeId/inscricao',
      );

      if (result.statusCode == 200) {
        final responseData = (result.data['data'] ?? []) as List;

        final atividade = responseData
            .map((car) => InscricaoEntityMapper.fromMap(map: car))
            .toList();

        return atividade;
      } else {
        throw DataSourceAtividadeFailure(
          errorMessage: result.data!['message'],
        );
      }
      // ignore: deprecated_member_use
    } on DioError catch (error, stackTrace) {
      // ignore: deprecated_member_use
      final List<DioErrorType> dioErrorTypes = [
        // ignore: deprecated_member_use
        DioErrorType.connectionTimeout,
        // ignore: deprecated_member_use
        DioErrorType.receiveTimeout,
        // ignore: deprecated_member_use
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - getAtividade',
        );
      } else {
        throw UnknownAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - getAtividade',
        );
      }
    }
  }

  Future<List<InscritosRequestEntity>> getInscritos(
      {required atividadeId}) async {
    final SharedPreferenceModule pref = getIt.get();

    try {
      final Response result = await dio.get(
        '${ApiConstants().baseUrl}${ApiConstants().atividades}/$atividadeId/inscricao/${pref.getUserData()}',
      );

      if (result.statusCode == 200) {
        final responseData = (result.data['data'] ?? []) as List;

        final atividade = responseData
            .map((car) => InscricaoEntityMapper.fromMap(map: car))
            .toList();

        return atividade;
      } else {
        throw DataSourceAtividadeFailure(
          errorMessage: result.data!['message'],
        );
      }
      // ignore: deprecated_member_use
    } on DioError catch (error, stackTrace) {
      // ignore: deprecated_member_use
      final List<DioErrorType> dioErrorTypes = [
        // ignore: deprecated_member_use
        DioErrorType.connectionTimeout,
        // ignore: deprecated_member_use
        DioErrorType.receiveTimeout,
        // ignore: deprecated_member_use
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - getAtividade',
        );
      } else {
        throw UnknownAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - getAtividade',
        );
      }
    }
  }

  @override
  Future<AtividadeResponse> doInscrito(
      {required atividadeRequestEntity}) async {
    try {
      final Response result = await dio.post(
        '${ApiConstants().baseUrl}${ApiConstants().atividades}/${atividadeRequestEntity.idAtividade}/inscricao',
        data: InscritostEntityMapper.toMap(
          entity: atividadeRequestEntity,
        ),
      );

      if (result.statusCode == 200) {
        final AtividadeResponse userInfoEntity =
            AtividadeResponseEntityMapper.fromMap(
                map: result.data as Map<String, dynamic>);
        return userInfoEntity;
      } else {
        throw DataSourceAtividadeFailure(errorMessage: result.data!['error']);
      }
      // ignore: deprecated_member_use
    } on DioError catch (error, stackTrace) {
      // ignore: deprecated_member_use
      final List<DioErrorType> dioErrorTypes = [
        // ignore: deprecated_member_use
        DioErrorType.connectionTimeout,
        // ignore: deprecated_member_use
        DioErrorType.receiveTimeout,
        // ignore: deprecated_member_use
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - doAtividade',
        );
      } else {
        throw UnknownAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - doAtividade',
        );
      }
    }
  }

  @override
  Future<void> deleteInscrito(
      {required InscritosRequestEntity atividadeRequestEntity}) async {
    try {
      final Response result = await dio.delete(
        '${ApiConstants().baseUrl}${ApiConstants().atividades}/${atividadeRequestEntity.idAtividade}/inscricao/${atividadeRequestEntity.id}',
      );

      if (result.statusCode == 200) {
      } else {
        throw DataSourceAtividadeFailure(errorMessage: result.data!['error']);
      }
      // ignore: deprecated_member_use
    } on DioError catch (error, stackTrace) {
      // ignore: deprecated_member_use
      final List<DioErrorType> dioErrorTypes = [
        // ignore: deprecated_member_use
        DioErrorType.connectionTimeout,
        // ignore: deprecated_member_use
        DioErrorType.receiveTimeout,
        // ignore: deprecated_member_use
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - doAtividade',
        );
      } else {
        throw UnknownAtividadeFailure(
          stackTrace: stackTrace,
          label: 'AtividadeDatasourceImpl - doAtividade',
        );
      }
    }
  }
}
