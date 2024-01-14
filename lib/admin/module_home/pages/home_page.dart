import 'dart:io';
import 'package:notification2/admin/module_home/pages/devocional/adicionar_devocional.dart';
import 'package:notification2/module_notification/pages/notification_page.dart';
import 'package:notification2/module_pastorais/pages/adicionar_pastorais.dart';
import 'package:notification2/modulo_main_widget/presenter/main_widget.dart';

import '../../../module_common_deps/module_common_deps.dart';
import '../../../module_designer_system/module_designer_system.dart';
import '../../../module_youtube/components/custom_drawer.dart';
import '../module_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  HomeControllerAdmin homeController = Get.put(HomeControllerAdmin());
  List<CustomButtomModel> imageList = [
    CustomButtomModel(
        image: 'assets/icons/home.png',
        page: () {
          Get.to(() => HomePageEdit());
        },
        text: 'Configurar Home'),
    CustomButtomModel(
        image: 'assets/icons/home.png',
        page: () {
          Get.to(() => AdicionarDevocional());
        },
        text: 'Adicionar Devocional'),
    CustomButtomModel(
        image: 'assets/icons/home.png',
        page: () {
          Get.to(() => NotificationPage());
        },
        text: 'Enviar Notificação'),
    CustomButtomModel(
        image: 'assets/icons/home.png',
        page: () {
          Get.to(() => AdicionarPastorais());
        },
        text: 'Adicionar Pastoral'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(() => MainWidget());
            },
          ),
        ),
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
                    Expanded(
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: imageList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 3
                                    : 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: (2 / 2),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: imageList[index].page,
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 15.0, // soften the shadow
                                          spreadRadius: 5.0, //extend the shadow
                                          offset: Offset(
                                            8.0, // Move to right 5  horizontally
                                            8.0, // Move to bottom 5 Vertically
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        child: Image.asset(
                                          imageList[index].image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        imageList[index].text!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                            );
                          }),
                    )
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
