import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:notification2/module_pastorais/pages/pastoral_detalhes.dart';

import '../../module_config/constants/colors_constants.dart';
import '../../module_youtube/components/custom_drawer.dart';
import '../controllers/pastorais_controllers.dart';

class PastoraisLista extends CustomDrawerContent {
  State<PastoraisLista> createState() => _PastoraisListaState();
}

class _PastoraisListaState extends State<PastoraisLista> {
  PastoraisController pastoraisController = Get.put(PastoraisController());
  @override
  Widget build(BuildContext context) {
    pastoraisController.getPastorais();
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
                        'Pastorais',
                        style: GoogleFonts.quicksand(
                            color: const Color.fromRGBO(45, 45, 42, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
              height: Get.size.height * 0.87,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 2),
                  padding: EdgeInsets.all(10),
                  itemCount: pastoraisController.pastoraisList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Get.to(() => PastoralDetalhes(
                              image:
                                  pastoraisController.pastoraisList[index].foto,
                              pastoral: pastoraisController
                                  .pastoraisList[index].descricao));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(pastoraisController
                                        .pastoraisList[index].foto),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20.0),
                                color: ColorsConstants().primaryColor,
                              ),
                              padding: const EdgeInsets.all(5),
                              width: 150,
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const ClipOval(
                                      child: Icon(
                                    Icons.menu_book_sharp,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        '${pastoraisController.pastoraisList[index].titulo}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ));
                  })),
        ],
      ),
    ));
  }
}
