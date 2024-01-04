import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:notification2/module_inscricoes/providers/inscricoes_provider.dart';
import 'package:notification2/module_inscricoes/repositories/inscricoes_repositories.dart';
import '../models/inscricoes_model.dart';

class InscricoesController extends GetxController {
  final inscricoesRepository =
      Get.put(InscricoesRepository(api: InscricoesProvider()));

  final inscricoesList = <InscricoesModel>[].obs;
  final TextEditingController controllerNome = TextEditingController();
  RxBool loading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getInscricoes();
  }

  getInscricoes() {
    loading(true);
    inscricoesRepository.getInscricoes().then((data) {
      inscricoesList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }

  putData(dataTime, descricao, foto, inscritos, titulo, vagas, id) async {
    inscricoesRepository.postInsctrito(InscricoesModel(
        id: id,
        vagas: vagas,
        foto: foto,
        data: dataTime,
        inscritos: inscritos,
        descricao: descricao,
        titulo: titulo));
  }
}
