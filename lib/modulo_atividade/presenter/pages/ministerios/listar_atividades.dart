import 'package:google_fonts/google_fonts.dart';

import '../../../../module_config/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class ListarAtividades extends StatelessWidget {
  const ListarAtividades({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants().primaryColor,
      appBar: AppBar(
        backgroundColor: ColorsConstants().primaryColor,
        elevation: 0,
        title: Text(
          'Atividades',
          style: GoogleFonts.quicksand(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const ListarAtividadeBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
