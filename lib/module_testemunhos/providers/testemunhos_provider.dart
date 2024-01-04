import 'dart:convert';

import 'package:get/get.dart';
import '../../module_config/module_config.dart';
import '../models/testemunhos_model.dart';

class TestemunhosProvider extends GetConnect {
  Future<List<TestemunhosModels>> getTestemunhos() async {
    String baseUrl =
        ConstantsEndPoint.URL_BASEOLDSERVER + ConstantsEndPoint.URL_TESTEMUNHOS;
    List<TestemunhosModels> testemunhosList = <TestemunhosModels>[];
    final response = await get(baseUrl, decoder: (body) {
      testemunhosList = testemunhosFromJson(body['data']);
      return testemunhosList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Testemunhos');
    }
    return testemunhosList;
  }
}
