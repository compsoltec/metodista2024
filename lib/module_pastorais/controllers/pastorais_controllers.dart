import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../models/pastorais_model.dart';
import '../providers/pastorais_provider.dart';
import '../repositories/pastorais_repositories.dart';

class PastoraisController extends GetxController {
  final pastoraisRepository =
      Get.put(PastoraisRepository(api: PastoraisProvider()));

  final pastoraisList = <PastoraisModels>[].obs;
  final TextEditingController controllerTitulo = TextEditingController();
  final TextEditingController controllerDescricao = TextEditingController();

  RxBool loading = false.obs;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getPastorais();
  }

  getPastorais() {
    loading(true);
    pastoraisRepository.getPastorais().then((data) {
      pastoraisList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }

  postPastorais(PastoraisModels pastoraisModels) {
    loading(true);
    pastoraisRepository.postPastorais(pastoraisModels).then((data) {
      loading(false);
    }, onError: (e) {
      loading(false);
    });
    loading(false);
  }
}
