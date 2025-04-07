import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:metodista/module_ministerios/ministerios/models/atividades_models.dart';
import 'package:metodista/module_ministerios/ministerios/models/inscritos_models.dart';
import 'package:metodista/module_ministerios/ministerios/services/atividades_services.dart';

import '../../../module_designer_system/components/custom_alert_dialog.dart';
import 'acessos_controllers.dart';

class AtividadesController extends GetxController {
  final RxBool isLoading = false.obs;
  RxList<AtividadesModel> myAtividades = <AtividadesModel>[].obs;
  RxList<InscritosModel> inscritos = <InscritosModel>[].obs;

  final formKey = GlobalKey<FormState>();
  String? ministerio;
  final List<String> integrantes = [];
  final acessosController = Get.put(AcessosController());
  final AtividadesService atividadesService = AtividadesService();

  @override
  void onInit() {
    super.onInit();
    fetchAtividades();
  }

  showAlert(String message, String alert, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            onPressedLeft: () {
              integrantes.clear();
              Get.back();
            },
            onPressed: () {},
            title: alert,
            textLeft: '',
            descriptions: message,
            text: 'Voltar',
          );
        });
  }

  Future<void> fetchAtividades() async {
    isLoading(true);
    await atividadesService.getAtividades().then((data) {
      myAtividades.assignAll(data);
      isLoading(false);
    }, onError: (e) {
      isLoading(false);
    });
  }

  Future<void> fetchInscritosByAtividades(String idAtividades) async {
    isLoading(true);
    await atividadesService.getAtividadesInscritos(idAtividades).then((data) {
      data.sort(
          (a, b) => a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase()));

      inscritos.assignAll(data);

      isLoading(false);
    }, onError: (e) {
      isLoading(false);
    });
  }
}
