import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/module_devocional/module_devocional.dart';

import '../../../../module_common_deps/module_common_deps.dart';
import '../../../../module_config/constants/colors_constants.dart';
import '../../../../module_designer_system/components/custom_alert_dialog.dart';
import '../../../../module_designer_system/components/custom_textField.dart';
import '../../../../module_services/firebase/firebase_services.dart';

class AdicionarDevocional extends StatefulWidget {
  @override
  State<AdicionarDevocional> createState() => _AdicionarDevocionalState();
}

class _AdicionarDevocionalState extends State<AdicionarDevocional> {
  final DevocionalController devocional = Get.put(DevocionalController());
  UploadTask? task;
  File? file;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Adicionar Devocional',
          style: GoogleFonts.quicksand(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
          key: devocional.formKey,
          child: Stack(
            children: <Widget>[
              Container(
                color: ColorsConstants().primaryColor,
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
                      CustomTextField(
                          labelText: 'Título',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O campo Pedido de Título não pode estar vázio';
                            }
                            return null;
                          },
                          obscureText: false,
                          controller: devocional.controllerTitulo),
                      const SizedBox(height: 10),
                      CustomTextField(
                          labelText: 'Data',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O campo Pedido de Data não pode estar vázio';
                            }
                            return null;
                          },
                          obscureText: false,
                          controller: devocional.controllerData),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          selectFile();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                            color: devocional.urlDownload != null
                                ? ColorsConstants().cruzColor
                                : ColorsConstants().primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              loading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      devocional.urlDownload != null
                                          ? 'Devocional Adicionado'
                                          : 'Adicionar Devocional',
                                      style: TextStyle(
                                          color: devocional.urlDownload != null
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                              devocional.urlDownload != null
                                  ? Icon(Icons.download_done)
                                  : SizedBox(),
                              if (devocional.urlDownload != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        devocional.urlDownload = null;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                            ],
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          selectFile();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                            color: devocional.urlDownload != null
                                ? ColorsConstants().cruzColor
                                : ColorsConstants().primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Obx(
                                () => devocional.loading.value
                                    ? Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      )
                                    : Text(
                                        'Salvar Devocional',
                                        style: TextStyle(
                                            color:
                                                devocional.urlDownload != null
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                              ),
                              devocional.urlDownload != null
                                  ? Icon(Icons.download_done)
                                  : SizedBox(),
                              if (devocional.urlDownload != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        devocional.urlDownload = null;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  void _showAlert(String message, BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
              onPressed: () {
                Navigator.pop(context);
              },
              onPressedLeft: () {
                Navigator.pop(context);
              },
              textLeft: '',
              title: 'Devocional',
              descriptions: message,
              text: 'Ok');
        });
  }

  void onPressedDevocional(BuildContext context) {
    devocional.postDevocional(DevocionalModels(
        sequencia: 1,
        devocional: devocional.urlDownload!,
        data: devocional.controllerData.text,
        foto:
            'https://firebasestorage.googleapis.com/v0/b/metodista-842fa.appspot.com/o/WhatsApp%20Image%202022-08-12%20at%2012.51.32.jpeg?alt=media&token=ab516b3a-c9dc-425d-8fd1-a5b74edd1fd7',
        titulo: devocional.controllerTitulo.text,
        id: ''));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
    setState(() {
      if (devocional.urlDownload == null) {
        loading = !loading;
      }
    });
    uploadFile();
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = file!.path;
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      loading = !loading;
      devocional.urlDownload = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }
}

Widget listItemStats(IconData imgpath, String name, bool value) {
  return Container(
    width: 110,
    height: 150,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: value == true ? Colors.white : Color.fromRGBO(75, 97, 88, 1.0)),
    child: Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Icon(
          imgpath,
          size: 50,
        ),
        const SizedBox(height: 15),
        Text(name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13,
                color: value == true ? Colors.black : Colors.white)),
        const SizedBox(height: 5),
      ],
    ),
  );
}
