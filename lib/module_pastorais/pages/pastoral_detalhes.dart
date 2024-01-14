import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:notification2/module_config/constants/colors_constants.dart';

class PastoralDetalhes extends StatelessWidget {
  final String image;
  final String pastoral;
  PastoralDetalhes({
    Key? key,
    required this.image,
    required this.pastoral,
  }) : super(key: key);
  TextEditingController controllerPastorais = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    controllerPastorais.text = pastoral;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          shareText(controllerPastorais.text);
        },
        child: Icon(
          Icons.share,
          color: ColorsConstants().primaryColor,
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 80.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 130, top: 30),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        color: Colors.black.withOpacity(0.5),
                        child: Text(
                          pastoral,
                          style: const TextStyle(
                              color: const Color(0xfefefefe),
                              fontWeight: FontWeight.w800,
                              fontFamily: "NunitoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> shareText(String text) async {
    try {
      await Share.share(text, subject: 'Sharing Text');
    } catch (e) {
      print('Error sharing text: $e');
    }
  }
}
