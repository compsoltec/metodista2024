import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_home/module_home.dart';
import '../../module_config/constants/colors_constants.dart';

class Aniversariantes extends StatelessWidget {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.isLoading.value
        ? Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: ColorsConstants().primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider.builder(
                  itemCount: homeController.homeModel!.aniversariantes!.length,
                  itemBuilder: (context, indice, child) {
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Expanded(
                              child: const Image(
                                  image: AssetImage('assets/aniversario.png'),
                                  width: 45,
                                  height: 45,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: Text(
                                  homeController
                                      .homeModel!.aniversariantes![indice],
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                  textAlign: TextAlign.center),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ));
                  },
                  options: CarouselOptions(
                    viewportFraction: 0.3,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            )));
  }
}
