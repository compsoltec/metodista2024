import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metodista/module_youtube/components/custom_drawer.dart';
import '../widgets/widgets.dart';

class Documentos extends CustomDrawerContent {
  Documentos({
    Key? key,
  });

  @override
  _DocumentosState createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
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
                              color: Color.fromRGBO(45, 45, 42, 1.0),
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
                          'Documentos',
                          style: GoogleFonts.quicksand(
                              color: const Color.fromRGBO(45, 45, 42, 1.0),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
            const DocumentosBody(),
          ],
        ),
      ),
    );
  }
}
