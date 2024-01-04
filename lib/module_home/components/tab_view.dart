import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/admin/admin.dart';
import 'package:notification2/module_devocional/module_devocional.dart';
import 'package:notification2/module_devocional/pages/devocional_executar.dart';
import 'package:notification2/module_inscricoes/controllers/inscricoes_controllers.dart';
import 'package:notification2/module_inscricoes/pages/seinscrever_page.dart';
import 'package:notification2/module_testemunhos/controllers/testemunhos_controllers.dart';
import 'package:notification2/module_testemunhos/pages/testemunhos_detalhes_page.dart';
import '../models/category.dart';
import 'category_card.dart';

class TabView extends GetView<DevocionalController> {
  final TabController tabController;
  final devocionalController = Get.put(DevocionalController());
  final testemunhosController = Get.put(TestemunhosController());
  final inscricoesController = Get.put(InscricoesController());

  TabView({
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => devocionalController.loading.value == true
        ? CircularProgressIndicator.adaptive()
        : TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: <Widget>[
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                            margin: EdgeInsets.all(8.0),
                            height: MediaQuery.of(context).size.height / 11,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    devocionalController.devocionalList.length,
                                itemBuilder: (_, index) => GestureDetector(
                                      onTap: () {
                                        Get.to(ExecutarDevocional(
                                          foto: devocionalController
                                              .devocionalList[index].foto,
                                          titulo: devocionalController
                                              .devocionalList[index].titulo,
                                          devocional: devocionalController
                                              .devocionalList[index].devocional,
                                          data: devocionalController
                                              .devocionalList[index].data,
                                        ));
                                      },
                                      child: CategoryCard(
                                        titulo: devocionalController
                                            .devocionalList[index].titulo,
                                        data: devocionalController
                                            .devocionalList[index].data,
                                        image: 'assets/headphone_8.png',
                                        isNetwork: false,
                                      ),
                                    ))),
                      ),

                      // Flexible(child: RecommendedList()),
                    ],
                  ),
                ),
                Obx(
                  () => testemunhosController.loading.value == true
                      ? CircularProgressIndicator.adaptive()
                      : Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                    margin: EdgeInsets.all(8.0),
                                    height:
                                        MediaQuery.of(context).size.height / 11,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: testemunhosController
                                            .testemunhosList.length,
                                        itemBuilder: (_, index) =>
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(TestemunhoDetalhes(
                                                  data: testemunhosController
                                                      .testemunhosList[index]
                                                      .data,
                                                  imagem: testemunhosController
                                                      .testemunhosList[index]
                                                      .foto,
                                                  texto: testemunhosController
                                                      .testemunhosList[index]
                                                      .texto,
                                                  nome: testemunhosController
                                                      .testemunhosList[index]
                                                      .nome,
                                                ));
                                              },
                                              child: CategoryCard(
                                                titulo: testemunhosController
                                                    .testemunhosList[index]
                                                    .nome,
                                                data: '',
                                                image: testemunhosController
                                                    .testemunhosList[index]
                                                    .foto,
                                                isNetwork: true,
                                              ),
                                            ))),
                              ),
                              // Flexible(child: RecommendedList()),
                            ],
                          ),
                        ),
                ),
                Obx(
                  () => inscricoesController.loading.value == true
                      ? CircularProgressIndicator.adaptive()
                      : Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                    margin: EdgeInsets.all(8.0),
                                    height:
                                        MediaQuery.of(context).size.height / 11,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: inscricoesController
                                            .inscricoesList.length,
                                        itemBuilder: (_, index) =>
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() => SeInscrever(
                                                      image:
                                                          inscricoesController
                                                              .inscricoesList[
                                                                  index]
                                                              .foto,
                                                      inscritos:
                                                          inscricoesController
                                                              .inscricoesList[
                                                                  index]
                                                              .inscritos,
                                                      id: inscricoesController
                                                          .inscricoesList[index]
                                                          .id,
                                                      vagas:
                                                          inscricoesController
                                                              .inscricoesList[
                                                                  index]
                                                              .vagas,
                                                      data: inscricoesController
                                                          .inscricoesList[index]
                                                          .data,
                                                      descricao:
                                                          inscricoesController
                                                              .inscricoesList[
                                                                  index]
                                                              .descricao,
                                                      titulo:
                                                          inscricoesController
                                                              .inscricoesList[
                                                                  index]
                                                              .titulo,
                                                    ));
                                              },
                                              child: CategoryCard(
                                                titulo: inscricoesController
                                                    .inscricoesList[index]
                                                    .titulo,
                                                data: '',
                                                image: inscricoesController
                                                    .inscricoesList[index].foto,
                                                isNetwork: true,
                                              ),
                                            ))),
                              ),
                              // Flexible(child: RecommendedList()),
                            ],
                          ),
                        ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                            margin: EdgeInsets.all(8.0),
                            height: MediaQuery.of(context).size.height / 11,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (_, index) => CategoryCard(
                                      titulo: '',
                                      data: '',
                                      image: '',
                                      isNetwork: false,
                                    ))),
                      ),
                      // Flexible(child: RecommendedList()),
                    ],
                  ),
                ),
                
              ]));
  }
}
