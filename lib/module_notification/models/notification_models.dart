class NotificationModels {
  List<String>? registrationIds;
  Notification? notification;

  NotificationModels(
      {required this.registrationIds, required this.notification});

  NotificationModels.fromJson(Map<String, dynamic> json) {
    registrationIds = json['registration_ids'].cast<String>();
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registration_ids'] = this.registrationIds;
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    return data;
  }
}

class Notification {
  String? body;
  String? title;

  Notification({this.body, this.title});

  Notification.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['title'] = this.title;
    return data;
  }
}
