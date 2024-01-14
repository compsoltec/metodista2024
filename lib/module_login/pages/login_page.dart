import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/admin/admin.dart';
import 'package:notification2/module_config/constants/colors_constants.dart';
import 'package:notification2/module_designer_system/components/custom_alert_dialog.dart';
import 'package:notification2/module_login/controllers/login_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../module_youtube/components/custom_drawer.dart';
import '../components/background.dart';

class LoginPage extends CustomDrawerContent {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    loginController.getLogin();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: widget.onMenuPressed,
          )),
      body: BackGround(
        child: Form(
          key: loginController.formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  controller: loginController.controllerEmail,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma senha';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  controller: loginController.controllerSenha,
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    _verificarLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: LinearGradient(
                        colors: [
                          ColorsConstants().primaryColor,
                          ColorsConstants().primaryColor
                        ],
                      ),
                    ),
                    child: const Text('LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _verificarLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (loginController.formKey.currentState!.validate()) {
      if (loginController.loginList
              .map((element) => element.email)
              .contains(loginController.controllerEmail.text) &&
          loginController.loginList
              .map((element) => element.senha)
              .contains(loginController.controllerSenha.text)) {
        sharedPreferences.setString(
            'email', loginController.controllerEmail.text);
        sharedPreferences.setString(
            'senha', loginController.controllerSenha.text);
        Get.to(() => HomePageAdmin());
      } else {
        Get.dialog(CustomDialogBox(
          onPressed: () {},
          title: 'Atenção',
          descriptions: 'Usuário sem permissão para acesso',
          text: '',
          textLeft: '',
        ));
      }
    } else {
      SnackBar(
        content: Text('Os campos email e senha não podem estar em branco'),
      );
    }
  }
}
