import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metodista/module_ministerios/ministerios/controllers/atividades_controllers.dart';

class VisualizarInscritos extends StatefulWidget {
  @override
  State<VisualizarInscritos> createState() => _VisualizarInscritosState();
}

class _VisualizarInscritosState extends State<VisualizarInscritos> {
  final AtividadesController atividadesController =
      Get.put(AtividadesController());

  @override
  Widget build(BuildContext context) {
    atividadesController.inscritos.sort((a, b) => a.nome!.compareTo(b.nome!));
    return Scaffold(
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
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Get.back();
                              },
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
                            'Inscritos',
                            style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),
              Obx(() => atividadesController.isLoading.value
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
                                'Total de Inscritos: ${atividadesController.inscritos.length.toString()}',
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
                                    atividadesController.inscritos.length,
                                itemBuilder: (context, item) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: Get.size.width * 0.9,
                                      height: Get.size.height * 0.060,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(Icons.person),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Nome: ',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                      atividadesController
                                                          .inscritos[item]
                                                          .nome!,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Telefone: ',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                      atividadesController
                                                          .inscritos[item]
                                                          .telefone!,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
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
    ;
  }
}
