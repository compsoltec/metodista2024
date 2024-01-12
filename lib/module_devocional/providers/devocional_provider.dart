import 'dart:convert';

import 'package:get/get.dart';
import 'package:notification2/module_devocional/module_devocional.dart';

import '../../module_config/module_config.dart';

class DevocionalProvider extends GetConnect {
  Future<List<DevocionalModels>> getDevocional() async {
    String baseUrl =
        ConstantsEndPoint.URL_BASEOLDSERVER + ConstantsEndPoint.URL_DEVOCIONAL;
    List<DevocionalModels> devocionalList = <DevocionalModels>[];
    final response = await get(baseUrl, decoder: (body) {
      devocionalList = devocionaisFromJson(body['data']);
      return devocionalList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Devocional');
    }
    return devocionalList;
  }

  Future<Response> postDevocional(DevocionalModels devocionalModels) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "data": devocionalModels.data,
      "deovcional": devocionalModels.devocional,
      "foto": devocionalModels.foto,
      "": devocionalModels.sequencia,
      "titulo": devocionalModels.titulo,
    });
    String baseUrl =
        ConstantsEndPoint.URL_BASEOLDSERVER + ConstantsEndPoint.URL_DEVOCIONAL;
    final response = await put(baseUrl, data);
    if (response.isOk) {
      Get.defaultDialog(title: 'Devocional adicionado com sucesso');
    }
    return response;
  }
}
