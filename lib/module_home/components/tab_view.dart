import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/admin/admin.dart';
import 'package:notification2/module_devocional/module_devocional.dart';
import 'package:notification2/module_devocional/pages/devocional_executar.dart';
import '../models/category.dart';
import 'category_card.dart';

class TabView extends GetView<DevocionalController> {
  final TabController tabController;
  final devocionalController = Get.put(DevocionalController());

  TabView({
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => devocionalController.loading.value == true
        ? SizedBox()
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
                                      ),
                                    ))),
                      ),

                      // Flexible(child: RecommendedList()),
                    ],
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
                                itemBuilder: (_, index) =>
                                    CategoryCard(titulo: '', data: ''))),
                      ),
                      // Flexible(child: RecommendedList()),
                    ],
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
                                itemBuilder: (_, index) =>
                                    CategoryCard(titulo: '', data: ''))),
                      ),
                      // Flexible(child: RecommendedList()),
                    ],
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
                                itemBuilder: (_, index) =>
                                    CategoryCard(titulo: '', data: ''))),
                      ),
                      // Flexible(child: RecommendedList()),
                    ],
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
                                itemBuilder: (_, index) =>
                                    CategoryCard(titulo: '', data: ''))),
                      ),
                      // Flexible(child: RecommendedList()),
                    ],
                  ),
                ),
              ]));
  }
}
