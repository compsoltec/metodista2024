import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../models/templo_model.dart';
import '../providers/templo_provider.dart';
import '../repositories/templo_repositories.dart';

class AgendaTemploController extends GetxController {
  final agendatemploRepository =
      Get.put(AgendaTemploRepository(api: AgendaTemploProvider()));

  final agendatemploList = <AgendaTemploModel>[].obs;
  final TextEditingController controllerNome = TextEditingController();
  RxBool loading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getAgendaTemplo();
  }

  getAgendaTemplo() {
    loading(true);
    agendatemploRepository.getAgendaTemplo().then((data) {
      agendatemploList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }
}
