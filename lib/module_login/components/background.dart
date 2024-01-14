import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  BackGround({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: Get.size.height * 1.0,
      width: Get.size.width * 1.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/top1.png',
              // color: Colors.blue,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/top2.png',
              // color: Colors.blueAccent,
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: Image.asset(
              'assets/metodista.png',
              width: 140,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/bottom1.png',
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/bottom2.png',
            ),
          ),
          child
        ],
      ),
    );
  }
}
