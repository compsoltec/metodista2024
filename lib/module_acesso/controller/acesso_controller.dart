import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metodista/module_acesso/service/acessos_services.dart';

import '../../module_services/service_locator.dart';
import '../../module_services/sharedPreference_services.dart';

class AcessoController extends GetxController {
  final AcessosServices service = AcessosServices();

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();

  final token = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  String? validarCampoVazio(String? value, String campo) {
    if (value == null || value.isEmpty) {
      return '$campo é obrigatório.';
    }
    return null;
  }

  Future<void> solicitarAcesso() async {
    final SharedPreferenceModule pref = getIt.get();

    if (formKey.currentState?.validate() ?? false) {
      print('aqui ');

      isLoading(true);
      final dadosUsuario = {
        'nome': nomeController.text,
        'tokenSolicitacao': pref.getUserData(),
        'descricao': descricaoController.text
      };

      try {
        var response = await service.solicitaracesso(dadosUsuario);
        if (response.statusCode == 200) {
          Get.snackbar('Sucesso', 'Solicitação realizado com sucesso!',
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar('Erro', 'Erro ao realizar a solicitação.',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar('Erro', 'Erro ao se conectar ao servidor.',
            backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        nomeController.clear();
        descricaoController.clear();
        token.clear();
        isLoading(false);
      }
    }
  }
}
