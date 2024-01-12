import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_devocional/controllers/devocional_controllers.dart';
import 'package:notification2/module_devocional/pages/devocional_executar.dart';

import '../module_home.dart';

class BodyHome extends GetView<HomeController> {
  final devocionalController = Get.put(DevocionalController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => devocionalController.loading.value
        ? Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Container(
            child: Column(children: [
              Obx(() => homeController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 250,
                      child: CustomScrollView(slivers: [
                        SliverToBoxAdapter(
                          child: ProductList(
                            pastoral: homeController.homeModel!.pastoral!,
                            products: homeController.homeModel!.programacao!,
                            cardHeight:
                                MediaQuery.of(context).size.height / 3.7,
                            cardWidth: MediaQuery.of(context).size.width / 1.8,
                            viewportFraction: 0.6,
                            autoPlay: false,
                            loop: false,
                          ),
                        ),
                      ]),
                    ))
            ]),
          ));
  }
}
