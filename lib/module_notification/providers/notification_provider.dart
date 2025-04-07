import 'dart:convert';

import 'package:get/get.dart';

import '../../module_config/module_config.dart';
import '../../module_services/module_services.dart';
import '../../module_services/service_locator.dart';
import '../models/notification_models.dart';
import '../models/token_models.dart';

class NotificationProvider extends GetConnect {
  Future<List<TokenModels>> getToken(
      String title, String bodyNotification) async {
    String baseUrl = ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_USERS;
    List<TokenModels> notificationList = <TokenModels>[];
    final response = await get(baseUrl, decoder: (body) {
      notificationList = tokenFromJson(body['data']);
      postNotification(NotificationModels(
          registrationIds: notificationList.map((e) => e.token).toList(),
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
          'Key=AAAAnGanRl8:APA91bHIWuWzL8RZJqchICYY_sX6obB9NzfH0DbBIY-0NKdFw-tU2yldqn8z-zRmJx0aX6ubnPhmQ7baJDAGs02FrTyNxC2RAR4FrpT0l1DCKkFiaAWmPgWBkBDsc7B7oTe4UwqmpEMS',
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
    var data =
        json.encode({"token": tokenModels.token, "uuid": tokenModels.uuid});
    final response = await post(
      ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_USERS,
      data,
    );
    if (response.statusCode == 200) {
      getTokenUuid();
    }
    if (response.isOk) {
      print('Token Salvo');
    }
    return response;
  }

  Future<List<TokenModels>> getTokenUuid() async {
    final SharedPreferenceModule pref = getIt.get();
    String baseUrl =
        '${ConstantsEndPoint.URL_BASE}${ConstantsEndPoint.URL_USERS}/${pref.getUserData()}';
    List<TokenModels> notificationList = <TokenModels>[];

    final response = await get(baseUrl, decoder: (body) {
      notificationList = tokenFromJson(body['data']);
      pref.saveUuid(body['data'][0]['uuid']);

      return notificationList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Devocional');
    }
    return notificationList;
  }
}
