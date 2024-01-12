import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:notification2/module_devocional/module_devocional.dart';
import 'package:notification2/module_devocional/providers/devocional_provider.dart';
import 'package:notification2/module_devocional/repositories/devocional_repositories.dart';

class DevocionalController extends GetxController {
  final devocionalRepository =
      Get.put(DevocionalRepository(api: DevocionalProvider()));

  final devocionalList = <DevocionalModels>[].obs;
  RxBool loading = false.obs;
  String? urlDownload;
  int? sequencia;
  final focusTitulo = FocusNode();
  final focusData = FocusNode();
  bool isObscurePassword = true;
  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getDevocional();
  }

  getDevocional() {
    loading(true);
    devocionalRepository.getDevocional().then((data) {
      devocionalList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }

  postDevocional(DevocionalModels devocionalModels) {
    loading(true);
    devocionalRepository.postDevocional(devocionalModels).then((data) {
      loading(false);
    }, onError: (e) {
      loading(false);
    });
    loading(false);
  }
}
