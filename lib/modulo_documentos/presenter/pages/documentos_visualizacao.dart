import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../modulo_common_services/modulo_common_services.dart';

class DocumentosVisualizacao extends StatefulWidget {
  String documentos;
  String titulo;
  DocumentosVisualizacao({required this.documentos, required this.titulo});
  @override
  State<DocumentosVisualizacao> createState() => _DocumentosVisualizacaoState();
}

class _DocumentosVisualizacaoState extends State<DocumentosVisualizacao> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  String? documentos;
  String? titulo;
  @override
  void initState() {
    super.initState();
    documentos = widget.documentos;
    titulo = widget.titulo;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsConstants().primaryColor,
        appBar: AppBar(
          backgroundColor: ColorsConstants().primaryColor,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            titulo!,
            style: GoogleFonts.quicksand(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
                semanticLabel: 'Bookmark',
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
          ],
        ),
        body: SfPdfViewer.network(
          documentos!,
          key: _pdfViewerKey,
        ));
  }
}
