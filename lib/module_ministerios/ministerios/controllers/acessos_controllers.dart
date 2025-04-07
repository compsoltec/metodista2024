import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:metodista/module_ministerios/ministerios/models/acessos_models.dart';
import '../../../module_designer_system/components/custom_alert_dialog.dart';
import '../services/acessos_services.dart';

class AcessosController extends GetxController {
  final RxBool isLoading = false.obs;
  RxList<AcessosModels> myAcessos = <AcessosModels>[].obs;

  final formKey = GlobalKey<FormState>();
  String? ministerio;
  final List<String> integrantes = [];
  final AcessosService atividadesService = AcessosService();

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

  Future<void> fetchAcessos(String idAcesso) async {
    isLoading(true);
    await atividadesService.getAcessos(idAcesso).then((data) {
      myAcessos.assignAll(data);
      isLoading(false);
    }, onError: (e) {
      isLoading(false);
    });
  }
}
