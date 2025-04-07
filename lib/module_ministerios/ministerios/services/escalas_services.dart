import 'package:flutter/material.dart';
import 'package:metodista/module_config/module_config.dart';
import 'package:metodista/module_ministerios/ministerios/models/models.dart';

import '../../../module_common_deps/module_common_deps.dart';
import '../../../module_designer_system/components/custom_alert_dialog.dart';

class EscalasService {
  final Dio dio = Dio();

  Future<List<EscalasModels>> getEscalas() async {
    final response = await dio.get(
      ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_ESCALAS,
    );
    final List<dynamic> data = response.data['data'];

    return data.map((json) => EscalasModels.fromJson(json)).toList();
  }

  Future<Response> criarEscalas(
      EscalasModels escalasModels, BuildContext context) async {
    var body = {
      "ministerio": escalasModels.ministerio,
      "data": escalasModels.data,
      "integrantes": escalasModels.integrantes,
    };
    Dio dio = Dio();

    String baseUrl = ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_ESCALAS;

    try {
      Response response = await dio.post(
        baseUrl,
        data: json.encode(body),
      );
      return response;
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
}
