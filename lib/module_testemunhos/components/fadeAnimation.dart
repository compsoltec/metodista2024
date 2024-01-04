import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget childn;

  FadeAnimation(this.delay, this.childn);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
      builder: (context, child, value) {
        // <-- use builder function
        return childn;
      },
      tween: Tween(begin: 50.0, end: 200.0),
      duration: const Duration(seconds: 5),
    );
  }
}
