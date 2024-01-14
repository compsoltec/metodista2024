import 'dart:convert';

import 'package:get/get.dart';

import '../../module_config/module_config.dart';
import '../models/login_models.dart';

class LoginProvider extends GetConnect {
  Future<List<LoginModels>> getLogin() async {
    String baseUrl = ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_LOGIN;
    List<LoginModels> loginList = <LoginModels>[];
    final response = await get(baseUrl, decoder: (body) {
      loginList = loginFromJson(body['data']);
      return loginList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Devocional');
    }
    return loginList;
  }
}
