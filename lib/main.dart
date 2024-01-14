import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notification2/module_config/constants/constantsEndPoint.dart';
import 'package:notification2/module_login/controllers/login_controllers.dart';
import 'package:notification2/module_pastorais/controllers/pastorais_controllers.dart';
import 'package:notification2/module_testemunhos/controllers/controllers.dart';
import 'package:notification2/module_videos/controllers/videos_controllers.dart';
import 'package:notification2/modulo_main_widget/presenter/main_widget.dart';
import 'package:notification2/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'module_devocional/module_devocional.dart';
import 'module_home/module_home.dart';
import 'module_home/pages/home_page.dart';
import 'module_home/pages/new_home_page.dart';
import 'module_inscricoes/controllers/controllers.dart';
import 'module_services/module_services.dart';
import 'module_services/notification_services.dart';
import 'module_services/service_locator.dart';
import 'module_templo.dart/controllers/controllers.dart';
import 'services/firebase_messaging_service.dart';
import 'services/notification_services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

const String authorization =
    'Key=AAAAP_L4yBQ:APA91bFdtOCmGPwRNGZeDg2RGMx22hXcdqT2RQNmTti2gSgIj5dxuT20KacT1Vpg09wcyb6kkFu4Gz_LuBcz9QONunSg7bvbl889D-yXyJhg-arSKsqBSFd3dFOWk5XJzCuFpEd4PWqz';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  initializerRequest();
  initServiceLocator();
  NotificationService().initNotification();

  runApp(const MyApp());
}

initializerRequest() {
  HomeController homeController = Get.put(HomeController());
  homeController.fetchData();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
        _saveToken(value);
      }
    });
  }

  _saveToken(String token) async {
    final devocionalController = Get.put(DevocionalController());
    final testemunhosController = Get.put(TestemunhosController());
    final inscricoesController = Get.put(InscricoesController());
    final agendaTemploController = Get.put(AgendaTemploController());
    final homeController = Get.put(HomeController());
    final videoController = Get.put(VideosController());
    final pastoraisController = Get.put(PastoraisController());
    final loginController = Get.put(LoginController());

    final SharedPreferenceModule pref = getIt.get();
    pref.saveUserData(token);
    setState(() {
      devocionalController.getDevocional();
      testemunhosController.getTestemunhos();
      inscricoesController.getInscricoes();
      agendaTemploController.getAgendaTemplo();
      homeController.fetchData();
      videoController.getVideos();
      loginController.getLogin();
      pastoraisController.getPastorais();
    });
  }

  _saveTokenFirebase(String token) async {
    final body = json.encode({'token': token});

    final responseProd = await http.put(
        Uri.parse('${ConstantsEndPoint.URL_BASE}/token'),
        headers: {'Content-Type': 'application/json'},
        body: body);
    if (responseProd.statusCode == 200) {
      print('Aqui ${token}');
    } else {
      print(responseProd.statusCode);
    } // Print the Token in Console
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainWidget(),
    );
  }
}
