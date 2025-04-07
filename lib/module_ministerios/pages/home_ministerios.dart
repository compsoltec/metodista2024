import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metodista/module_acesso/pages/solicitar_acesso.dart';
import 'package:metodista/module_cadastro/pages/visulizar_cadastro.dart';
import 'package:metodista/module_ministerios/ministerios/controllers/acessos_controllers.dart';
import 'package:metodista/module_ministerios/ministerios/pages/atividades/visualizar_atividades.dart';
import 'package:metodista/module_ministerios/ministerios/pages/escalas/criar_escalas_page.dart';
import 'package:metodista/module_ministerios/ministerios/pages/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../module_designer_system/components/custom_alert_dialog.dart';
import '../../module_designer_system/module_designer_system.dart';
import '../../module_youtube/components/custom_drawer.dart';

class HomeMinisterios extends CustomDrawerContent {
  @override
  State<HomeMinisterios> createState() => _HomeMinisteriosState();
}

class _HomeMinisteriosState extends State<HomeMinisterios> {
  final AcessosController acessosController = Get.put(AcessosController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: widget.onMenuPressed,
            )),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppBar(
                  isIconePerson: false,
                  isBackScreen: false,
                ),
                CustomBody(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                              width: Get.size.width * 0.45,
                              height: Get.size.height * 0.2,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 15.0,
                                      spreadRadius: 5.0,
                                      offset: Offset(
                                        8.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Image.asset(
                                      'assets/pessoas.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    ' Criar Escala',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            _verificarAcessoInscritos('44ik30tU5zqYFvMY7xLe');
                          },
                          child: Container(
                              width: Get.size.width * 0.45,
                              height: Get.size.height * 0.2,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 15.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                      offset: Offset(
                                        8.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Image.asset(
                                      'assets/pessoas.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    ' Inscritos Atividades',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _verificarVisualizarCadastro(
                                '36J0H2Svr62FX0O6MK5U');
                          },
                          child: Container(
                              width: Get.size.width * 0.45,
                              height: Get.size.height * 0.2,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 15.0,
                                      spreadRadius: 5.0,
                                      offset: Offset(
                                        8.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Image.asset(
                                      'assets/pessoas.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Visualizar Cadastro',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => SolicitarAcesso());
                          },
                          child: Container(
                              width: Get.size.width * 0.45,
                              height: Get.size.height * 0.2,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 15.0,
                                      spreadRadius: 5.0,
                                      offset: Offset(
                                        8.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Image.asset(
                                      'assets/pessoas.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    ' Solicitar Acesso',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                      ],
                    )
                  ]),
                )
              ],
            ),
          ),
        ));
  }

  _verificarAcessoInscritos(String acesso) async {
    final acessosController = Get.put(AcessosController());
    SharedPreferences pref = await SharedPreferences.getInstance();

    acessosController.fetchAcessos(acesso);

    if (acessosController.myAcessos
        .map((element) => element.token)
        .toList()
        .contains(pref.getString('token'))) {
      Get.to(() => VisualizarAtividades());
    } else {
      showAlert('Você não possui acesso para criar escalas', 'Sem permissão');
    }
  }

  _verificarVisualizarCadastro(String acesso) async {
    final acessosController = Get.put(AcessosController());
    SharedPreferences pref = await SharedPreferences.getInstance();

    acessosController.fetchAcessos(acesso);

    if (acessosController.myAcessos
        .map((element) => element.token)
        .toList()
        .contains(pref.getString('token'))) {
      Get.to(() => VisualizarCadastrados());
    } else {
      showAlert('Você não possui acesso para criar escalas', 'Sem permissão');
    }
  }
  // _verificarVisualizarEscala() async {
  //   final acessosController = Get.put(AcessosController());
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   acessosController.fetchAcessoss();
  //   if (acessosController.myAcessoss
  //       .map((element) => element.token)
  //       .toList()
  //       .contains(pref.getString('token'))) {
  //     acessosController.myAcessoss
  //         .map((element) => element.token)
  //         .where((element) => element));
  //     // Get.to(() => VisualizarEscala(
  //     //       ministerio: acessosController.myAcessoss
  //     //           .map((element) => element.tipodeacesso)
  //     //           .toString(),
  //     //     ));
  //   } else {
  //     showAlert(
  //         'Você não possui acesso para visualizar escalas', 'Sem permissão');
  //   }
  // }

  showAlert(String message, String alert) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            onPressedLeft: () {
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
}
