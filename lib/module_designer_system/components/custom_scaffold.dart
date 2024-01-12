import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../module_config/constants/colors_constants.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final String title;
  const CustomScaffold(
      {super.key,
      required this.child,
      required this.title,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            title,
            style: GoogleFonts.quicksand(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: ColorsConstants().primaryColor,
        ),
        body: Container(
          color: ColorsConstants().primaryColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 80),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: child,
          ),
        ));
  }
}
