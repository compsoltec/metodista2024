import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:metodista/module_ministerios/ministerios/controllers/escalas_controllers.dart';

import '../../../../modulo_common_services/constants/constants.dart';

class VisualizarEscala extends StatelessWidget {
  String ministerio;
  VisualizarEscala({
    Key? key,
    required this.ministerio,
  }) : super(key: key);
  final escalaController = Get.put(EscalasController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants().primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsConstants().primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Visualizar Escalas',
          style: GoogleFonts.quicksand(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: Get.size.height * 0.86,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Obx(() => escalaController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : SizedBox(
                            width: Get.size.width * 1.0,
                            height: Get.size.height * 0.8,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: escalaController.myEscalass.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.0,
                                              color: Colors.grey.shade400)),
                                      height: Get.size.height * 0.15,
                                      width: Get.size.width * 0.9,
                                      child: Row(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: ColorsConstants()
                                                  .primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          height: Get.size.height * 0.2,
                                          width: Get.size.width * 0.2,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  escalaController
                                                      .myEscalass[index].data
                                                      .substring(0, 5),
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ]),
                                        ),
                                        Expanded(
                                            child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: escalaController
                                              .myEscalass[index]
                                              .integrantes
                                              .length,
                                          itemBuilder: (context, indice) {
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 5),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.person),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      escalaController
                                                          .myEscalass[index]
                                                          .integrantes[indice],
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ));
                                          },
                                        ))
                                      ]),
                                    ),
                                  );
                                })))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
