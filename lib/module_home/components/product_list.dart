import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../app_properties.dart';
import '../models/product.dart';

class ProductList extends StatelessWidget {
  List<dynamic> products;
  double cardHeight;
  double cardWidth;
  final SwiperController swiperController = SwiperController();

  ProductList({required this.products,
  required this.cardHeight,
  required this.cardWidth});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: cardHeight,
        child: Swiper(
          itemCount: products.length,
          itemBuilder: (_, index) {
            return ProductCard(
                height: cardHeight, width: cardWidth, product: products[index]);
          },
          scale: 0.8,
          controller: swiperController,
          viewportFraction: 0.6,
          loop: false,
          fade: 0.5,
          pagination: SwiperCustomPagination(
            builder: (context, config) {
              if (config.itemCount > 20) {
                print(
                    "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
              }
              Color activeColor = mediumYellow;
              Color color = Colors.grey.withOpacity(.3);
              double size = 10.0;
              double space = 5.0;

              if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                  config.layout == SwiperLayout.DEFAULT) {
                return new PageIndicator(
                  count: config.itemCount,
                  controller: config.pageController!,
                  layout: config.indicatorLayout,
                  size: size,
                  activeColor: activeColor,
                  color: color,
                  space: space,
                );
              }

              List<Widget> dots = [];

              int itemCount = config.itemCount;
              int activeIndex = config.activeIndex;

              for (int i = 0; i < itemCount; ++i) {
                bool active = i == activeIndex;
                dots.add(Container(
                  key: Key("pagination_$i"),
                  margin: EdgeInsets.all(space),
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: active ? activeColor : color,
                      ),
                      width: size,
                      height: size,
                    ),
                  ),
                ));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: dots,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String product;
  final double height;
  final double width;

  const ProductCard({
    required this.product,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(left: 30),
        height: height,
        width: width,
        decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(product), fit: BoxFit.cover),
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
