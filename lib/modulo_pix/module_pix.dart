import 'package:clipboard/clipboard.dart';
import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../module_youtube/constants/string.dart';

class ScreenPixCopy extends StatelessWidget {
  const ScreenPixCopy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _copyText(String text) {
      FlutterClipboard.copy(cnpj).then((value) {
        _showAlertDialog(context);
      });
    }

    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/pix.png",
                                  ))),
                        ),
                        SizedBox(width: 8),
                        Text("PIX: $cnpj",
                            style: GoogleFonts.quicksand(color: Colors.grey)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          child: const Icon(Icons.copy,
                              color: Colors.grey, size: 20),
                          onTap: () {
                            _copyText(cnpj);
                          },
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          child: Text("Copiar",
                              style: GoogleFonts.quicksand(color: Colors.grey)),
                          onTap: () {
                            _copyText(cnpj);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    // show the dialog
    showDialogAlert(
      context: context,
      title: 'Copiado',
      message: 'Chave PIX copiada com sucesso',
      actionButtonTitle: 'OK',
    );
  }
}
