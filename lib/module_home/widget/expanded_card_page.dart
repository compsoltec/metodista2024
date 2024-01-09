import 'package:flutter/material.dart';
import 'package:notification2/module_home/widget/expanded_cart.dart';

class ExpandableCardPage extends StatelessWidget {
  ExpandableCardPage({required this.page, required this.expandableCard});

  final Widget page;
  final ExpandableCard expandableCard;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [page, expandableCard],
    );
  }
}
