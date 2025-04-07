import 'package:dio/dio.dart' as dio;
import 'package:metodista/module_cadastro/models/cadastro_model.dart';
import 'package:metodista/module_config/module_config.dart';

class CadastroService {
  final dio.Dio dioClient = dio.Dio();
  final String baseUrl =
      'https://us-central1-metodista-novo.cloudfunctions.net/app';

  Future<dio.Response> cadastrarUsuario(
      Map<String, dynamic> dadosUsuario) async {
    try {
      dio.Response response = await dioClient.post(
        '$baseUrl/cadastro',
        data: dadosUsuario,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CadastroModel>> getCadastro() async {
    final response = await dioClient.get(
      '$baseUrl/cadastro',
    );

    final List<dynamic> data = response.data['data'];

    return data.map((json) => CadastroModel.fromJson(json)).toList();
  }
}
