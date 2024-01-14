import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_designer_system/components/custom_alert_dialog.dart';
import '../../module_config/module_config.dart';
import '../models/inscricoes_model.dart';

class InscricoesProvider extends GetConnect {
  Future<List<InscricoesModel>> getInscricoes() async {
    String baseUrl =
        ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_INSCRICOES;
    List<InscricoesModel> inscricoesList = <InscricoesModel>[];
    final response = await get(baseUrl, decoder: (body) {
      inscricoesList = inscricoesFromJson(body['data']);
      return inscricoesList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Inscricoes');
    }
    return inscricoesList;
  }

  Future<Response> putInscrito(InscricoesModel inscricoesModel) async {
    print('CHEGOU');
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "data": inscricoesModel.data,
      "descricao": inscricoesModel.descricao,
      "foto": inscricoesModel.foto,
      "inscritos": inscricoesModel.inscritos,
      "titulo": inscricoesModel.titulo,
      "vagas": inscricoesModel.vagas,
      "id": inscricoesModel.id
    });
    String baseUrl = ConstantsEndPoint.URL_BASE +
        ConstantsEndPoint.URL_INSCRICOES +
        '/${inscricoesModel.id}';
    final response = await put(baseUrl, data);
    if (response.isOk) {
      Get.dialog(
        CustomDialogBox(
            onPressed: () {
              Get.back();
            },
            onPressedLeft: () {
              Get.back();
            },
            textLeft: '',
            title: 'Inscrição',
            descriptions: 'Atualizada com Sucesso',
            text: 'Cancelar'),
      );
    }
    return response;
  }
}
