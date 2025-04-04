import 'package:flutter/material.dart';

import 'app.dart';
import 'core/core.dart';
import 'core/di/injection_container.dart' as di;

const String authorization =
    'Key=AAAAP_L4yBQ:APA91bFdtOCmGPwRNGZeDg2RGMx22hXcdqT2RQNmTti2gSgIj5dxuT20KacT1Vpg09wcyb6kkFu4Gz_LuBcz9QONunSg7bvbl889D-yXyJhg-arSKsqBSFd3dFOWk5XJzCuFpEd4PWqz';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await di.init();

  runApp(const App());
}
