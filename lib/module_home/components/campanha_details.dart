import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_home/models/home_model.dart';
import 'package:notification2/module_home/pages/home_page_details.dart';

import '../../app_properties.dart';
import '../models/product.dart';

class CampanhaDetails extends StatelessWidget {
  double cardHeight;
  double cardWidth;
  String pastoral;
  String image;

  final SwiperController swiperController = SwiperController();

  CampanhaDetails(
      {required this.image,
      required this.pastoral,
      required this.cardHeight,
      required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: cardHeight,
        child: CampanhaCard(
          pastoral: pastoral,
          image: image,
          height: cardHeight,
          width: cardWidth,
        ),
      ),
    );
  }
}

class CampanhaCard extends StatelessWidget {
  final double height;
  final double width;
  final String image;
  final String pastoral;

  const CampanhaCard({
    required this.height,
    required this.width,
    required this.image,
    required this.pastoral,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => HomePageDetails(
              image: image,
              pastoral: pastoral,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30),
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: mediumYellow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
      ),
    );
  }
}
