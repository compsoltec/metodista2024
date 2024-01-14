import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_notification/models/notification_models.dart';
import 'package:notification2/module_notification/models/token_models.dart';
import 'package:notification2/module_notification/providers/notification_provider.dart';

import '../repositories/notification_repository.dart';

class NotificationController extends GetxController {
  final notificationRepository =
      Get.put(NotificationRepository(api: NotificationProvider()));
  final TextEditingController controllerTitulo = TextEditingController();
  final TextEditingController controllerBody = TextEditingController();
  final tokenList = <TokenModels>[].obs;

  RxBool loading = false.obs;

  getNotification(String title, String body) {
    loading(true);
    notificationRepository.getToken(title, body).then((data) {
      tokenList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }

  postNotification(NotificationModels notificationModels) async {
    loading(true);
    notificationRepository.postNotificaiton(notificationModels).then((data) {
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }

  postToken(TokenModels tokenModels) async {
    notificationRepository
        .postToken(tokenModels)
        .then((data) {}, onError: (e) {});
  }
}
