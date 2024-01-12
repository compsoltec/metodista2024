import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/module_home/models/home_model.dart';
import '../../module_config/constants/colors_constants.dart';

class Pastoral extends StatelessWidget {
  final String pastoral;
  const Pastoral({required this.pastoral});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage('assets/boletimfundo.png'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: Stack(
              children: <Widget>[
                Text(
                  pastoral,
                  style: GoogleFonts.quicksand(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                )),
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                      padding: EdgeInsets.all(20),
                                      child: SizedBox(
                                          child: SingleChildScrollView(
                                        child: Text(
                                          pastoral,
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )));
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(300, 50),
                              elevation: 10,
                              backgroundColor: ColorsConstants().primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            'Visualizar Pastoral',
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ))),
                )
              ],
            )));
  }
}
