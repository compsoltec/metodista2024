import 'dart:convert';

import 'package:get/get.dart';

import '../../module_config/module_config.dart';
import '../models/notification_models.dart';
import '../models/token_models.dart';

class NotificationProvider extends GetConnect {
  Future<List<TokenModels>> getToken(
      String title, String bodyNotification) async {
    String baseUrl = ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_TOKEN;
    List<TokenModels> notificationList = <TokenModels>[];
    final response = await get(baseUrl, decoder: (body) {
      notificationList = tokenFromJson(body['data']);
      postNotification(NotificationModels(
          registrationIds: notificationList.map((e) => e.id).toList(),
          notification: Notification(body: bodyNotification, title: title)));
      return notificationList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Devocional');
    }
    return notificationList;
  }

  Future<Response> postNotification(
      NotificationModels notificationModels) async {
    var headers = {
      'Authorization':
          'Key=AAAAP_L4yBQ:APA91bFdtOCmGPwRNGZeDg2RGMx22hXcdqT2RQNmTti2gSgIj5dxuT20KacT1Vpg09wcyb6kkFu4Gz_LuBcz9QONunSg7bvbl889D-yXyJhg-arSKsqBSFd3dFOWk5XJzCuFpEd4PWqz',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "registration_ids": notificationModels.registrationIds,
      "notification": {
        "body": notificationModels.notification!.body,
        "title": notificationModels.notification!.title
      }
    });

    final response =
        await post(ConstantsEndPoint.URL_NOTIFICATION, data, headers: headers);
    if (response.isOk) {
      Get.defaultDialog(title: 'Notificação enviada com sucesso');
    }
    return response;
  }

  Future<Response> postToken(TokenModels tokenModels) async {
    var data = json.encode({
      "token": tokenModels.id,
    });

    final response = await post(
      ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_TOKEN,
      data,
    );
    if (response.isOk) {
      print('Token Salvo');
    }
    return response;
  }
}
