import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../module_youtube/components/custom_drawer.dart';
import '../widgets/widgets.dart';

class AtividadePage extends CustomDrawerContent {
  @override
  _AtividadePageState createState() => _AtividadePageState();
}

class _AtividadePageState extends State<AtividadePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        child: Material(
                          shadowColor: Colors.transparent,
                          color: Colors.transparent,
                          child: IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                            onPressed: widget.onMenuPressed,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 3,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Atividade',
                          style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
            const AtividadeBody(),
          ],
        ),
      ),
    );
  }
}
