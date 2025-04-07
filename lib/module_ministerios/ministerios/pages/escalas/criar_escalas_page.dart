import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metodista/module_designer_system/components/custom_dropdown_button.dart';
import 'package:metodista/module_ministerios/ministerios/controllers/escalas_controllers.dart';
import 'package:metodista/module_ministerios/ministerios/models/models.dart';
import 'package:metodista/module_ministerios/ministerios/widgets/widgets.dart';

import '../../../../module_designer_system/components/custom_alert_dialog.dart';
import '../../../../module_designer_system/components/custom_textFormField.dart';
import '../../../../modulo_common_services/constants/constants.dart';

class CriarEscalas extends StatefulWidget {
  @override
  State<CriarEscalas> createState() => _CriarEscalasState();
}

class _CriarEscalasState extends State<CriarEscalas> {
  final escalaControllers = Get.put(EscalasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorsConstants().primaryColor,
          onPressed: () {
            escalaControllers.criarEscalas(
                EscalasModels(
                    ministerio: escalaControllers.ministerio!,
                    data: escalaControllers.controllerData.text,
                    integrantes: escalaControllers.integrantes),
                context);
          },
          label: Obx(() => escalaControllers.isLoading.value
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : SizedBox(
                  width: Get.size.width * 0.6,
                  child: Center(
                    child: Text(
                      'Salvar Escala',
                      style: GoogleFonts.quicksand(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: ColorsConstants().primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsConstants().primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Criar Escala',
          style: GoogleFonts.quicksand(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Form(
        key: escalaControllers.formKey,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: Get.size.height * 0.86,
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      CircularDropdownButton(),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: Get.size.height * 0.08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  textInputType: TextInputType.text,
                                  validators: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'O Campo Nome Não Pode Estar Vázio';
                                    }
                                    return null;
                                  },
                                  controller: escalaControllers.controllerData,
                                  inputFormatters: [
                                    escalaControllers.dateFormatter
                                  ],
                                  icon: const Icon(Icons.date_range),
                                  borderColor: Colors.white,
                                  hintColor: ColorsConstants().primaryColor,
                                  hintText: 'Data',
                                  label: 'Data',
                                  labelColor: ColorsConstants().primaryColor,
                                  prefixColor: ColorsConstants().primaryColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: Get.size.height * 0.08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  textInputType: TextInputType.text,
                                  validators: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'O Campo Nome Não Pode Estar Vázio';
                                    }
                                    return null;
                                  },
                                  controller: escalaControllers.controllerNome,
                                  icon: const Icon(Icons.person),
                                  borderColor: Colors.white,
                                  hintColor: ColorsConstants().primaryColor,
                                  hintText: 'Nome',
                                  label: 'Integrante',
                                  labelColor: ColorsConstants().primaryColor,
                                  prefixColor: ColorsConstants().primaryColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    escalaControllers.integrantes.add(
                                        escalaControllers.controllerNome.text);
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      ColorsConstants().primaryColor,
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: 1,
                          width: Get.size.width * 0.9,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.2,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: escalaControllers.integrantes.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6),
                                child: Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      escalaControllers.integrantes[index],
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
