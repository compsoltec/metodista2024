import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../modulo_common_services/modulo_common_services.dart';
import 'documentos_visualizacao.dart';

class DocumentosLista extends StatelessWidget {
  List<dynamic> documentos;
  String titulo;
  DocumentosLista({super.key, required this.documentos, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'Documentos',
                style: GoogleFonts.quicksand(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                titulo,
                style: GoogleFonts.quicksand(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          )),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(45, 45, 42, 1.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 700,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: documentos.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DocumentosVisualizacao(
                                                documentos: documentos[index]
                                                    ['documentourl'],
                                                titulo: titulo)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ColorsConstants().primaryColor),
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                          child: Image.asset(
                                              'assets/icon_documentos.png')),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white),
                                        width: 200,
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          documentos[index]['titulo'],
                                          style: GoogleFonts.quicksand(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ]),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
