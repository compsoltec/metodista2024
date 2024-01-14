import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/module_notification/controllers/notification_controllers.dart';
import '../../module_config/constants/colors_constants.dart';
import '../../module_designer_system/components/custom_textField.dart';

class NotificationPage extends StatelessWidget {
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants().primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Enviar Notificação',
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
            CustomTextField(
                labelText: 'Título',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo Pedido de Título não pode estar vázio';
                  }
                  return null;
                },
                obscureText: false,
                controller: notificationController.controllerTitulo),
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
                controller: notificationController.controllerBody),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                notificationController.getNotification(
                    notificationController.controllerTitulo.text,
                    notificationController.controllerBody.text);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorsConstants().primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Obx(
                  () => notificationController.loading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : const Center(
                          child: Text(
                            'Enviar Notificação',
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
