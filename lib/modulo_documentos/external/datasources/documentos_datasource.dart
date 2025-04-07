
import 'package:dio/dio.dart';

import '../../../modulo_common_services/modulo_common_services.dart';
import '../../modulo_documentos.dart';

class DocumentosDatasourceImpl implements DocumentosDatasource {
  final Dio dio;

  DocumentosDatasourceImpl({
    required this.dio,
  });

  @override
  Future<DocumentosResponse> doDocumentos(
      {required DocumentosRequestEntity documentosRequestEntity}) async {
    try {
      final Response result = await dio.post(
        ApiConstants().baseUrl + ApiConstants().documentos,
        data: DocumentosRequestEntityMapper.toMap(
          entity: documentosRequestEntity,
        ),
      );

      if (result.statusCode == 200) {
        final DocumentosResponse userInfoEntity =
            DocumentosResponseEntityMapper.fromMap(
                map: result.data as Map<String, dynamic>);
        return userInfoEntity;
      } else {
        throw DataSourceDocumentosFailure(errorMessage: result.data!['error']);
      }
    } on DioError catch (error, stackTrace) {
      final List<DioErrorType> dioErrorTypes = [
        DioErrorType.connectionTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetDocumentosFailure(
          stackTrace: stackTrace,
          label: 'DocumentosDatasourceImpl - doDocumentos',
        );
      } else {
        throw UnknownDocumentosFailure(
          stackTrace: stackTrace,
          label: 'DocumentosDatasourceImpl - doDocumentos',
        );
      }
    }
  }

  @override
  Future<DocumentosResponse> deleteDocumentos() async {
    try {
      final Response result = await dio.post(
        ApiConstants().baseUrl + ApiConstants().documentos,
      );

      if (result.statusCode == 200) {
        final DocumentosResponse userInfoEntity =
            DocumentosResponseEntityMapper.fromMap(
                map: result.data as Map<String, dynamic>);
        return userInfoEntity;
      } else {
        throw DataSourceDocumentosFailure(errorMessage: result.data!['error']);
      }
    } on DioError catch (error, stackTrace) {
      final List<DioErrorType> dioErrorTypes = [
        DioErrorType.connectionTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetDocumentosFailure(
          stackTrace: stackTrace,
          label: 'DocumentosDatasourceImpl - doDocumentos',
        );
      } else {
        throw UnknownDocumentosFailure(
          stackTrace: stackTrace,
          label: 'DocumentosDatasourceImpl - doDocumentos',
        );
      }
    }
  }

  @override
  Future<List<DocumentosEntity>> getDocumentos() async {
    try {
      final Response result = await dio.get(
        ApiConstants().baseUrl + ApiConstants().documentos,
      );

      if (result.statusCode == 200) {
        final responseData = (result.data['data'] ?? []) as List;

        final documentos = responseData
            .map((car) => DocumentosEntityMapper.fromMap(map: car))
            .toList();

        return documentos;
      } else {
        throw DataSourceDocumentosFailure(
          errorMessage: result.data!['status_message'],
        );
      }
    } on DioError catch (error, stackTrace) {
      final List<DioErrorType> dioErrorTypes = [
        DioErrorType.connectionTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetDocumentosFailure(
          stackTrace: stackTrace,
          label: 'DocumentosDatasourceImpl - getDocumentos',
        );
      } else {
        throw UnknownDocumentosFailure(
          stackTrace: stackTrace,
          label: 'DocumentosDatasourceImpl - getDocumentos',
        );
      }
    }
  }
}
