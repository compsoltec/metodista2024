import 'dart:convert';

import 'package:get/get.dart';
import 'package:notification2/module_devocional/module_devocional.dart';

import '../../module_config/module_config.dart';
import '../models/pastorais_model.dart';

class PastoraisProvider extends GetConnect {
  Future<List<PastoraisModels>> getPastorais() async {
    String baseUrl =
        ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_PASTORAIS;
    List<PastoraisModels> devocionalList = <PastoraisModels>[];
    final response = await get(baseUrl, decoder: (body) {
      devocionalList = pastoraisFromJson(body['data']);
      return devocionalList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Pastorais');
    }
    return devocionalList;
  }

  Future<Response> postPastorais(PastoraisModels pastoraisModels) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "foto": pastoraisModels.foto,
      "titulo": pastoraisModels.titulo,
      "descricao": pastoraisModels.descricao
    });
    String baseUrl =
        ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_PASTORAIS;
    final response = await post(baseUrl, data);
    if (response.isOk) {
      Get.defaultDialog(title: 'Pastoral adicionado com sucesso');
      getPastorais();
    }
    return response;
  }
}
