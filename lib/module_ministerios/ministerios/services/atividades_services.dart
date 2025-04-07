import 'package:flutter/material.dart';
import 'package:metodista/module_config/module_config.dart';
import 'package:metodista/module_ministerios/ministerios/models/atividades_models.dart';
import 'package:metodista/module_ministerios/ministerios/models/inscritos_models.dart';
import 'package:metodista/module_ministerios/ministerios/models/models.dart';

import '../../../module_common_deps/module_common_deps.dart';
import '../../../module_designer_system/components/custom_alert_dialog.dart';

class AtividadesService {
  final Dio dio = Dio();

  Future<List<AtividadesModel>> getAtividades() async {
    final response = await dio.get(
      ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_ATIVIDADES,
    );
    final List<dynamic> data = response.data['data'];

    return data.map((json) => AtividadesModel.fromJson(json)).toList();
  }

  Future<List<InscritosModel>> getAtividadesInscritos(
      String idAtividade) async {
    final response = await dio.get(
        '${ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_ATIVIDADES}/$idAtividade/inscricao');
    final List<dynamic> data = response.data['data'];

    return data.map((json) => InscritosModel.fromJson(json)).toList();
  }
}
