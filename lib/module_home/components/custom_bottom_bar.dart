import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white.withOpacity(.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/home.png',
              width: 25,
              height: 25,
            ),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/musica.png',
              width: 25,
              height: 25,
            ),
            color: Colors.grey.shade600,
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/social.png',
              width: 25,
              height: 25,
            ),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
          IconButton(
            icon: Image.asset('assets/icons/profile_icon.png'),
            onPressed: () {
              controller.animateTo(3);
            },
          )
        ],
      ),
    );
  }
}
