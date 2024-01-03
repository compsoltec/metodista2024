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
}
