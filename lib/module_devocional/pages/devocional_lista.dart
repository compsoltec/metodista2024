import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/module_devocional/module_devocional.dart';
import 'package:notification2/module_devocional/pages/devocional_executar.dart';

import '../../module_config/constants/colors_constants.dart';
import '../../module_youtube/components/custom_drawer.dart';

class DevocionalLista extends CustomDrawerContent {
  @override
  State<DevocionalLista> createState() => _DevocionalListaState();
}

class _DevocionalListaState extends State<DevocionalLista> {
  DevocionalController devocionalController = Get.put(DevocionalController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        'Devocionais',
                        style: GoogleFonts.quicksand(
                            color: const Color.fromRGBO(45, 45, 42, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 2),
                  padding: EdgeInsets.all(10),
                  itemCount: devocionalController.devocionalList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Get.to(() => ExecutarDevocional(
                              foto: devocionalController
                                  .devocionalList[index].foto,
                              titulo: devocionalController
                                  .devocionalList[index].titulo,
                              devocional: devocionalController
                                  .devocionalList[index].devocional,
                              data: devocionalController
                                  .devocionalList[index].data));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/devocionalImg.png")),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: ColorsConstants().primaryColor),
                              padding: const EdgeInsets.all(5),
                              width: 150,
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ClipOval(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                  offset: const Offset(0, 10))
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: const Icon(
                                            Icons.play_circle_fill,
                                            size: 40,
                                            color: Colors.white,
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        '${devocionalController.devocionalList[index].titulo}\n ${devocionalController.devocionalList[index].data}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ));
                  })),
        ],
      ),
    ));
  }
}
