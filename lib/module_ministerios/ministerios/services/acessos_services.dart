import 'package:flutter/material.dart';
import 'package:metodista/module_config/module_config.dart';
import 'package:metodista/modulo_common_services/modulo_common_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../module_common_deps/module_common_deps.dart';
import '../../../module_services/service_locator.dart';
import '../models/acessos_models.dart';

class AcessosService {
  final Dio dio = Dio();

  Future<List<AcessosModels>> getAcessos(String idAcesso) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await dio.get(
      '${ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_ACESSO}/$idAcesso/token/${pref.getString('token')}',
    );

    final List<dynamic> data = response.data['data'];

    return data.map((json) => AcessosModels.fromJson(json)).toList();
  }
}
