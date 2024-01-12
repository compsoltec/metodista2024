import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_inscricoes/controllers/controllers.dart';

import '../pages/seinscrever_page.dart';

class AtividadeBody extends StatelessWidget {
  InscricoesController inscricoesController = Get.put(InscricoesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => inscricoesController.loading.value
        ? Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: inscricoesController.inscricoesList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => SeInscrever(
                              image: inscricoesController
                                  .inscricoesList[index].foto,
                              inscritos: inscricoesController
                                  .inscricoesList[index].inscritos,
                              id: inscricoesController.inscricoesList[index].id,
                              vagas: inscricoesController
                                  .inscricoesList[index].vagas,
                              data: inscricoesController
                                  .inscricoesList[index].data,
                              descricao: inscricoesController
                                  .inscricoesList[index].descricao,
                              titulo: inscricoesController
                                  .inscricoesList[index].titulo,
                            ));
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: NetworkImage(inscricoesController
                                        .inscricoesList[index].foto!),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white),
                              width: 200,
                              height: 300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          inscricoesController
                                              .inscricoesList[index].titulo!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              )),
                            ),
                          )
                        ],
                      ));
                })));
  }
}
