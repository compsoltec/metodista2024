import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/module_testemunhos/controllers/testemunhos_controllers.dart';
import 'package:notification2/module_testemunhos/pages/testemunhos_detalhes_page.dart';

import '../../module_youtube/components/custom_drawer.dart';

class Testemunho extends CustomDrawerContent {
  @override
  _TestemunhoState createState() => _TestemunhoState();
}

class _TestemunhoState extends State<Testemunho> {
  TestemunhosController testemunhosController =
      Get.put(TestemunhosController());
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
                          'Testemunhos',
                          style: GoogleFonts.quicksand(
                              color: Color.fromRGBO(45, 45, 42, 1.0),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
            Obx(() => testemunhosController.loading.value
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        padding: const EdgeInsets.all(5),
                        itemCount: testemunhosController.testemunhosList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 2 / 2),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Get.to(() => TestemunhoDetalhes(
                                    imagem: testemunhosController
                                        .testemunhosList[index].foto,
                                    texto: testemunhosController
                                        .testemunhosList[index].texto,
                                    nome: testemunhosController
                                        .testemunhosList[index].nome,
                                    data: testemunhosController
                                        .testemunhosList[index].data));
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                testemunhosController
                                                    .testemunhosList[index]
                                                    .foto!),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Colors.white),
                                      width: 200,
                                      height: 300,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      width: 200,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            stops: const [
                                              0.3,
                                              0.9
                                            ],
                                            colors: [
                                              Colors.white.withOpacity(.5),
                                              Colors.white.withOpacity(.6),
                                            ]),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            testemunhosController
                                                .testemunhosList[index].nome!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            testemunhosController
                                                .testemunhosList[index].data!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      )),
                                    ),
                                  )
                                ],
                              ));
                        })))
          ],
        ),
      ),
    );
  }
}
