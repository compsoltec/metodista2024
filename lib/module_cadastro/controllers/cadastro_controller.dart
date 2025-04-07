// lib/controllers/cadastro_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:metodista/module_cadastro/models/cadastro_model.dart';
import '../services/cadastro_service.dart';

class CadastroController extends GetxController {
  final CadastroService service = CadastroService();
  final formKey = GlobalKey<FormState>();
  RxList<CadastroModel> meusCadastros = <CadastroModel>[].obs;
  final cadastroServices = CadastroService();

  final nomeController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final celular = TextEditingController();
  final descricao = TextEditingController();

  final profissaoController = TextEditingController();
  final areaAtuacao = ''.obs;
  final statusProfissional = ''.obs;
  final maskDataNascimento = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final maskTelefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  RxBool isLoading = false.obs;
  void onReady() {
    super.onReady();
    fetchCadastro();
  }

  Future<void> cadastrarUsuario() async {
    int telefone = int.parse(celular.text
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(' ', ''));

    if (formKey.currentState?.validate() ?? false) {
      isLoading(true);
      final dadosUsuario = {
        'nome': nomeController.text,
        'dataNascimento': dataNascimentoController.text,
        'telefone': telefone,
        'statusProfissional': statusProfissional.value,
        'area': areaAtuacao.value,
        'descricao': descricao.text
      };

      try {
        var response = await service.cadastrarUsuario(dadosUsuario);
        if (response.statusCode == 200) {
          Get.snackbar('Sucesso', 'Cadastro realizado com sucesso!',
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar('Erro', 'Erro ao realizar cadastro.',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar('Erro', 'Erro ao se conectar ao servidor.',
            backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        nomeController.clear();
        dataNascimentoController.clear();
        celular.clear();
        statusProfissional.value == '';
        areaAtuacao.value == '';
        isLoading(false);
      }
    }
  }

  String? validarCampoVazio(String? value, String campo) {
    if (value == null || value.isEmpty) {
      return '$campo é obrigatório.';
    }
    return null;
  }

  String? validarDataNascimento(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data de Nascimento é obrigatória.';
    }
    try {
      DateFormat('dd/MM/yyyy').parseStrict(value);
    } catch (_) {
      return 'Formato inválido. Use dd/mm/aa.';
    }
    return null;
  }

  Future<void> fetchCadastro() async {
    isLoading(true);
    await cadastroServices.getCadastro().then((data) {
      meusCadastros.assignAll(data);
      isLoading(false);
    }, onError: (e) {
      isLoading(false);
    });
  }

  @override
  void onClose() {
    nomeController.dispose();
    dataNascimentoController.dispose();
    super.onClose();
  }
}
