import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:metodista/module_notification/models/token_models.dart';
import 'package:metodista/modulo_documentos/presenter/presenter.dart';
import 'package:metodista/modulo_main_widget/presenter/main_widget.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:uuid/uuid.dart';

import 'module_config/module_config.dart';
import 'module_home/module_home.dart';
import 'module_home/pages/home_page.dart';
import 'module_services/module_services.dart';
import 'module_services/notification_services.dart';
import 'module_services/service_locator.dart';
import 'modulo_atividade/modulo_atividade.dart';
import 'services/notification_services.dart';

const String authorization =
    'Key=AAAAP_L4yBQ:APA91bFdtOCmGPwRNGZeDg2RGMx22hXcdqT2RQNmTti2gSgIj5dxuT20KacT1Vpg09wcyb6kkFu4Gz_LuBcz9QONunSg7bvbl889D-yXyJhg-arSKsqBSFd3dFOWk5XJzCuFpEd4PWqz';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initServiceLocator();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  initializerRequest();
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
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Upgrader();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    getDeviceToken();
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    _saveToken(token!);
    return token;
  }

  _saveToken(String token) async {
    String userId = Uuid().v4();

    postToken(TokenModels(token: token, uuid: userId));

    final SharedPreferenceModule pref = getIt.get();
    pref.saveUserData(token);

    setState(() {
      devocionalController.getDevocional();

      homeController.fetchData();
    });
  }

  Future<void> postToken(TokenModels tokenModels) async {
    var data =
        json.encode({"token": tokenModels.token, "uuid": tokenModels.uuid});
    final response = await Dio().post(
      ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_USERS,
      data: data,
    );
    if (response.statusCode == 200) {
      print('Token Salvo');
    }
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
      home: MultiBlocProvider(
        providers: [
          Provider<NotificationService>(
              create: (context) => NotificationService()),
          BlocProvider(create: (_) => getIt<AtividadeCubit>()..getAtividade()),
          Provider<NotificationService>(
              create: (context) => NotificationService()),
          BlocProvider(
              create: (_) => getIt<DocumentosCubit>()..getDocumentos()),
        ],
        child: MainWidget(),
      ),
    );
  }
}
