import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:notification2/app_properties.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
      ),
      body: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1.0, color: Colors.black26)),
            child: const Text(
                'MasterStudy mobile App for LMS is the learning application developed to meet the needs of digital education. It was built with one of the best mobile development  '),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Obx(() => inscricoesController.loading.value == true
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldComponents()),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              
                              setState(() {
                                widget.inscritos.add(Inscrito(
                                  telefone: "000000",
                                  nome:
                                      inscricoesController.controllerNome.text,
                                  id: pref.getUserData().toString(),
                                ));
                                inscricoesController.inscricoesRepository
                                    .postInsctrito(InscricoesModel(
                                        id: widget.id,
                                        vagas: widget.vagas,
                                        foto: widget.image,
                                        data: widget.data,
                                        inscritos: widget.inscritos,
                                        descricao: widget.descricao,
                                        titulo: widget.titulo));
                                inscricoesController.inscricoesRepository
                                    .getInscricoes();
                              });
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
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.width * 0.7,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            Text('Inscritos'),
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: widget.inscritos
                                      .where((e) => e.id == pref.getUserData() )
                                      .toList()
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 1.0,
                                                color: Colors.black26)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                  widget.inscritos[index].nome),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    widget.inscritos
                                                        .removeAt(index);
                                                    inscricoesController
                                                        .inscricoesRepository
                                                        .postInsctrito(
                                                            InscricoesModel(
                                                                id: widget.id,
                                                                vagas: widget
                                                                    .vagas,
                                                                foto: widget
                                                                    .image,
                                                                data:
                                                                    widget.data,
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
                                                },
                                                icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ))
                  ],
                ))
        ],
      ),
    );
  }
}
