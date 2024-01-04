import 'dart:convert';
import 'package:get/get.dart';
import 'package:notification2/module_devocional/module_devocional.dart';

import '../../module_config/module_config.dart';
import '../models/models.dart';

class BibliaProvider extends GetConnect {
  Future<List<BibliaModels>> getBiblia() async {
    String baseUrl =
        ConstantsEndPoint.URL_BASEOLDSERVER + ConstantsEndPoint.URL_DEVOCIONAL;
    List<BibliaModels> devocionalList = <BibliaModels>[];
    final response = await get(baseUrl, decoder: (body) {
      devocionalList = bibliaModelsFromJson(body['data']);
      return devocionalList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Biblia');
    }
    return devocionalList;
  }
}
