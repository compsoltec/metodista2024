import 'package:flutter/cupertino.dart';
import 'custom_alert_dialog.dart';

void showAlert(String message, BuildContext context) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
            textLeft: '',
            onPressedLeft: () {
              Navigator.pop(context);
            },
            onPressed: () {
              Navigator.pop(context);
            },
            title: 'Escala',
            descriptions: message,
            text: 'Ok');
      });
}
