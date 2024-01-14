import 'package:notification2/module_notification/models/notification_models.dart';
import 'package:notification2/module_notification/providers/notification_provider.dart';

class NotificationRepository {
  final NotificationProvider api;

  NotificationRepository({required this.api});

  getToken(String title, String body) {
    return api.getToken(title, body);
  }

  postNotificaiton(NotificationModels notificationModels) {
    return api.postNotification(notificationModels);
  }
}
