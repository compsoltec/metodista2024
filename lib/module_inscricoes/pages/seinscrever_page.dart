import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/app_properties.dart';
import 'package:notification2/module_config/constants/colors_constants.dart';
import 'package:notification2/module_designer_system/components/custom_alert_dialog_error.dart';
import 'package:notification2/module_inscricoes/components/textField_components.dart';
import 'package:notification2/module_inscricoes/controllers/inscricoes_controllers.dart';
import 'package:notification2/module_inscricoes/models/inscricoes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../module_services/module_services.dart';
import '../../module_services/service_locator.dart';

class SeInscrever extends StatefulWidget {
  final String image;
  final String data;
  final String id;
  final int vagas;
  final String titulo;
  final String descricao;
  final List<Inscrito> inscritos;
  SeInscrever(
      {super.key,
      required this.image,
      required this.inscritos,
      required this.data,
      required this.vagas,
      required this.id,
      required this.descricao,
      required this.titulo});

  @override
  State<SeInscrever> createState() => _SeInscreverState();
}

class _SeInscreverState extends State<SeInscrever> {
  final inscricoesController = Get.put(InscricoesController());
  final SharedPreferenceModule pref = getIt.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: ColorsConstants().primaryColor,
            onPressed: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  )),
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: Get.size.width * 1.0,
                      height: Get.size.height * 0.5,
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: SizedBox(
                              child: SingleChildScrollView(
                                  child: Column(
                            children: [
                              Text('Data: ${widget.data}',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Descrição: ${widget.descricao}',
                                style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )))),
                    );
                  });
            },
            label: Row(
              children: [
                Text(
                  'Mais Informações',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_circle_up_rounded,
                  color: Colors.white,
                )
              ],
            )),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(children: [
              SizedBox(
                width: Get.size.width * 1.0,
                height: Get.size.height * 0.4,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 350),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  width: Get.size.width * 1.0,
                  height: Get.size.height * 0.6,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Obx(() => inscricoesController.loading.value ==
                                  true
                              ? Center(child: CircularProgressIndicator())
                              : Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                              child: TextFieldComponents()),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.inscritos.length >=
                                                  widget.vagas) {
                                                Get.dialog(CustomDialogBoxError(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    onPressedLeft: () {
                                                      Get.back();
                                                    },
                                                    title: 'Atenção',
                                                    textLeft: '',
                                                    descriptions:
                                                        'Limite de vagas excedido',
                                                    text: 'Cancelar'));
                                              } else {
                                                setState(() {
                                                  widget.inscritos.add(Inscrito(
                                                    telefone: "000000",
                                                    nome: inscricoesController
                                                        .controllerNome.text,
                                                    id: pref
                                                        .getUserData()
                                                        .toString(),
                                                  ));
                                                  inscricoesController
                                                      .inscricoesRepository
                                                      .postInsctrito(
                                                          InscricoesModel(
                                                              id: widget.id,
                                                              vagas:
                                                                  widget.vagas,
                                                              foto:
                                                                  widget.image,
                                                              data: widget.data,
                                                              inscritos: widget
                                                                  .inscritos,
                                                              descricao: widget
                                                                  .descricao,
                                                              titulo: widget
                                                                  .titulo));
                                                  inscricoesController
                                                      .inscricoesRepository
                                                      .getInscricoes();
                                                });
                                              }
                                            },
                                            child: const CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Colors.black,
                                              child: Center(
                                                  child: Icon(
                                                Icons.send,
                                                color: Colors.white,
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: widget.inscritos
                                                .where((e) =>
                                                    e.id == pref.getUserData())
                                                .toList()
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: Colors
                                                              .grey.shade300)),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(widget
                                                            .inscritos[index]
                                                            .nome),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              widget.inscritos
                                                                  .removeAt(
                                                                      index);
                                                              inscricoesController
                                                                  .inscricoesRepository
                                                                  .postInsctrito(InscricoesModel(
                                                                      id: widget
                                                                          .id,
                                                                      vagas: widget
                                                                          .vagas,
                                                                      foto: widget
                                                                          .image,
                                                                      data: widget
                                                                          .data,
                                                                      inscritos:
                                                                          widget
                                                                              .inscritos,
                                                                      descricao:
                                                                          widget
                                                                              .descricao,
                                                                      titulo: widget
                                                                          .titulo));
                                                              inscricoesController
                                                                  .inscricoesRepository
                                                                  .getInscricoes();
                                                            });
                                                          },
                                                          icon: Icon(
                                                              Icons.delete))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                )),
                        ),
                      ]),
                ),
              )
            ]);
          },
        ));
  }
}
