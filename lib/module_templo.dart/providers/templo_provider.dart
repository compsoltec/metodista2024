import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../module_config/module_config.dart';
import '../models/templo_model.dart';

class AgendaTemploProvider extends GetConnect {
  Future<List<AgendaTemploModel>> getAgendaTemplo() async {
    String baseUrl = ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_TEMPLO;
    List<AgendaTemploModel> agendatemploList = <AgendaTemploModel>[];
    final response = await get(baseUrl, decoder: (body) {
      agendatemploList = agendaTemplosFromJson(body['data']);
      return agendatemploList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o AgendaTemplo');
    }
    return agendatemploList;
  }
}
