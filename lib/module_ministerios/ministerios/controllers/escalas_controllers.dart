import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:metodista/module_ministerios/ministerios/models/atividades_models.dart';
import 'package:metodista/module_ministerios/ministerios/models/inscritos_models.dart';
import 'package:metodista/module_ministerios/ministerios/services/atividades_services.dart';

import '../../../module_designer_system/components/custom_alert_dialog.dart';
import '../models/escalas_models.dart';
import '../services/services.dart';
import 'acessos_controllers.dart';

class EscalasController extends GetxController {
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerData = TextEditingController();
  final dateFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  final EscalasService escalasService = EscalasService();
  final AtividadesService atividadesService = AtividadesService();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingAtividade = false.obs;

  RxList<EscalasModels> myEscalass = <EscalasModels>[].obs;
  RxList<AtividadesModel> myAtividades = <AtividadesModel>[].obs;
  RxList<InscritosModel> inscritos = <InscritosModel>[].obs;

  final formKey = GlobalKey<FormState>();
  String? ministerio;
  final List<String> integrantes = [];
  final acessosController = Get.put(AcessosController());

  @override
  void onInit() {
    super.onInit();
    fetchEscalass();
    fetchAtividades();
  }

  Future<void> criarEscalas(
      EscalasModels escalasModels, BuildContext context) async {
    isLoading(true);
    await escalasService.criarEscalas(escalasModels, context).then((data) {
      isLoading(false);
      if (data.statusCode == 200) {
        showAlert(data.data['message'], 'Sucesso', context);
        controllerData.clear();
        controllerNome.clear();
      } else {
        showAlert(data.statusCode.toString(), 'Sucesso', context);
      }
    }, onError: (e) {
      print(e);
      isLoading(false);
    });
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

  Future<void> fetchEscalass() async {
    isLoading(true);
    await escalasService.getEscalas().then((data) {
      myEscalass.assignAll(data);
      isLoading(false);
    }, onError: (e) {
      isLoading(false);
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
      inscritos.assignAll(data);
      isLoading(false);
    }, onError: (e) {
      isLoading(false);
    });
  }
}
