import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/module_pastorais/controllers/pastorais_controllers.dart';
import 'package:notification2/module_pastorais/models/pastorais_model.dart';

import '../../module_config/constants/colors_constants.dart';
import '../../module_designer_system/components/custom_textField.dart';

class AdicionarPastorais extends StatelessWidget {
  final PastoraisController pastoraisController =
      Get.put(PastoraisController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorsConstants().primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Adicionar Pastoral',
          style: GoogleFonts.quicksand(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.size.width * 1.0,
              height: Get.size.height * 0.1,
              child: CustomTextField(
                  maxLength: 20,
                  labelText: 'Título',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Título não pode estar vázio';
                    }
                    return null;
                  },
                  obscureText: false,
                  controller: pastoraisController.controllerTitulo),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: SizedBox(
                width: Get.size.width * 1.0,
                height: Get.size.height * 0.5,
                child: CustomTextField(
                    maxLength: 20,
                    labelText: 'Descrição',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O campo Título não pode estar vázio';
                      }
                      return null;
                    },
                    obscureText: false,
                    controller: pastoraisController.controllerDescricao),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                pastoraisController.postPastorais(PastoraisModels(
                    titulo: pastoraisController.controllerTitulo.text,
                    foto:
                        'https://firebasestorage.googleapis.com/v0/b/metodista-novo.appspot.com/o/pastorais.png?alt=media&token=fc2daded-f262-4e50-aedd-797696a7016e',
                    descricao: pastoraisController.controllerDescricao.text));

                pastoraisController.controllerDescricao.clear();
                pastoraisController.controllerTitulo.clear();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorsConstants().primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Obx(
                  () => pastoraisController.loading.value
                      ? Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Center(
                          child: Text(
                            'Salvar Pastoral',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
