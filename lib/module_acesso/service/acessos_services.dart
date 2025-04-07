import 'package:dio/dio.dart' as dio;

class AcessosServices {
  final dio.Dio dioClient = dio.Dio();
  final String baseUrl =
      'https://us-central1-metodista-novo.cloudfunctions.net/app';

  Future<dio.Response> solicitaracesso(
      Map<String, dynamic> dadosUsuario) async {
    try {
      dio.Response response = await dioClient.post(
        '$baseUrl/solicitarAcesso',
        data: dadosUsuario,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
