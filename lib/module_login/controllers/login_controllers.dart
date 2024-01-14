import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_login/models/login_models.dart';

import '../providers/login_provider.dart';
import '../repositories/login_repository.dart';

class LoginController extends GetxController {
  final loginRepository = Get.put(LoginRepository(api: LoginProvider()));
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final loginList = <LoginModels>[].obs;
  final formKey = GlobalKey<FormState>();
  bool isAdmin = false;
  var email;
  var senha;
  RxBool loading = false.obs;

  getLogin() {
    loading(true);
    loginRepository.getToken().then((data) {
      loginList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }
}
