import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/core.dart';
import 'core/di/injection_container.dart' as di;
import 'features/app/presentation/app.dart';

const String authorization =
    'Key=AAAAP_L4yBQ:APA91bFdtOCmGPwRNGZeDg2RGMx22hXcdqT2RQNmTti2gSgIj5dxuT20KacT1Vpg09wcyb6kkFu4Gz_LuBcz9QONunSg7bvbl889D-yXyJhg-arSKsqBSFd3dFOWk5XJzCuFpEd4PWqz';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const App());
}
