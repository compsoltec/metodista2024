import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metodista/module_cadastro/pages/cadastro_page.dart';

import '../../module_youtube/components/custom_drawer.dart';
import '../controllers/cadastro_controller.dart';

class VisualizarCadastrados extends CustomDrawerContent {
  @override
  State<VisualizarCadastrados> createState() => _VisualizarCadastradosState();
}

class _VisualizarCadastradosState extends State<VisualizarCadastrados> {
  final CadastroController cadastroController = Get.put(CadastroController());

  @override
  Widget build(BuildContext context) {
    cadastroController.meusCadastros.sort((a, b) => a.nome!.compareTo(b.nome!));
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(() => CadastroPage());
        },
        label: Text(
          'Cadastrar Currículo',
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 3,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 3,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Currículos',
                            style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),
              Obx(() => cadastroController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Total de Cadastrados: ${cadastroController.meusCadastros.length.toString()}',
                                style: GoogleFonts.quicksand(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.size.height * 0.85,
                            child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 20),
                                itemCount:
                                    cadastroController.meusCadastros.length,
                                itemBuilder: (context, item) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: Get.size.width * 0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Nome: ',
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  cadastroController
                                                      .meusCadastros[item]
                                                      .nome!,
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Data de Nascimento: ',
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  cadastroController
                                                      .meusCadastros[item]
                                                      .dataNascimento!
                                                      .toString(),
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Telefone: ',
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  cadastroController
                                                      .meusCadastros[item]
                                                      .telefone!
                                                      .toString(),
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Status Profissional: ',
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  cadastroController
                                                      .meusCadastros[item]
                                                      .statusProfissional!
                                                      .toString(),
                                                  softWrap: true,
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Área: ',
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  cadastroController
                                                      .meusCadastros[item].area!
                                                      .toString(),
                                                  softWrap: true,
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.transparent,
                                              height: 7,
                                            ),
                                            Text(
                                              'Descrição: ',
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              cadastroController
                                                      .meusCadastros[item]
                                                      .descricao
                                                      .toString()
                                                      .isEmpty
                                                  ? 'N/D'
                                                  : cadastroController
                                                      .meusCadastros[item]
                                                      .descricao!
                                                      .toString(),
                                              softWrap: true,
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
