import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/module_config/constants/colors_constants.dart';
import 'package:notification2/module_templo.dart/controllers/templo_controllers.dart';

import '../../module_youtube/components/custom_drawer.dart';

class ListarTemplo extends CustomDrawerContent {
  @override
  State<ListarTemplo> createState() => _ListarTemploState();
}

class _ListarTemploState extends State<ListarTemplo> {
  AgendaTemploController agendaTemploController =
      Get.put(AgendaTemploController());
  @override
  Widget build(BuildContext context) {
    agendaTemploController.getAgendaTemplo();
    return SafeArea(
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
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                    child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Color.fromRGBO(45, 45, 42, 1.0),
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
                      'Agenda Templo',
                      style: GoogleFonts.quicksand(
                          color: const Color.fromRGBO(45, 45, 42, 1.0),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: agendaTemploController.agendatemploList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      width: Get.size.width * 0.3,
                      height: Get.size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 4,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: ColorsConstants().cruzColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                            height: Get.size.width * 0.15,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.size.width * 0.4,
                                  child: Center(
                                    child: Text(agendaTemploController
                                        .agendatemploList[index].data),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: ColorsConstants().primaryColor,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20))),
                                  width: Get.size.width * 0.335,
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          agendaTemploController
                                              .agendatemploList[index].dataTime
                                              .substring(0, 5),
                                          style: GoogleFonts.quicksand(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  )),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.size.width * 0.25,
                                child: Center(child: Text('Horário')),
                              ),
                              Container(
                                width: 1,
                                height: Get.size.width * 0.05,
                                color: ColorsConstants().primaryColor,
                              ),
                              SizedBox(
                                width: Get.size.width * 0.32,
                                child: Center(child: Text('Evento')),
                              ),
                              Container(
                                width: 1,
                                height: Get.size.width * 0.05,
                                color: ColorsConstants().primaryColor,
                              ),
                              SizedBox(
                                width: Get.size.width * 0.26,
                                child: Center(child: Text('Local')),
                              )
                            ],
                          ),
                          Container(
                            width: Get.size.width,
                            height: 1,
                            color: ColorsConstants().primaryColor,
                          ),
                          Flexible(
                            child: Container(
                              child: ListView.builder(
                                  itemCount: agendaTemploController
                                      .agendatemploList[index].horario.length,
                                  itemBuilder: (context, indice) {
                                    var horario = agendaTemploController
                                        .agendatemploList[index].horario;
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.size.width * 0.25,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 2),
                                                child: Center(
                                                    child: Text(
                                                        horario[indice].hora)),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: Get.size.height * 0.15,
                                              color: ColorsConstants()
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              width: Get.size.width * 0.32,
                                              height: Get.size.height * 0.15,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 2),
                                                child: Center(
                                                    child: Text(horario[indice]
                                                        .evento)),
                                              ),
                                            ),
                                            Container(
                                              height: Get.size.height * 0.15,
                                              width: 1,
                                              color: ColorsConstants()
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              width: Get.size.width * 0.26,
                                              height: Get.size.height * 0.15,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 2),
                                                child: Center(
                                                    child: Text(
                                                        horario[indice].local)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: Get.size.width * 1.0,
                                          height: 1,
                                          color: ColorsConstants().primaryColor,
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    ),
                  );
                })),
      ],
    ));
  }
}
