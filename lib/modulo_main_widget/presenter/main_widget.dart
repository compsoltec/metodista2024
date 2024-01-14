import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/admin/admin.dart';
import 'package:notification2/module_home/pages/new_home_page.dart';
import 'package:notification2/module_inscricoes/pages/inscricoes.dart';
import 'package:notification2/module_login/controllers/login_controllers.dart';
import 'package:notification2/module_login/pages/login_page.dart';
import 'package:notification2/module_pastorais/controllers/pastorais_controllers.dart';
import 'package:notification2/module_pastorais/pages/pastorais_lista.dart';
import 'package:notification2/module_templo.dart/pages/listar_templo.dart';
import 'package:notification2/module_videos/pages/video_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../module_devocional/pages/devocional_lista.dart';
import '../../module_services/module_services.dart';
import '../../module_services/service_locator.dart';
import '../../module_testemunhos/pages/testemunho.dart';
import '../../module_youtube/components/custom_drawer.dart';
import '../../module_youtube/youtube/youtube.dart';

class MainWidget extends StatefulWidget {
  MainWidget({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  late CustomDrawerController _drawerController;
  final PastoraisController pastoraisController =
      Get.put(PastoraisController());
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _drawerController = CustomDrawerController(
      initialPage: NewHome(),
      items: [
        CustomDrawerItem.initWithPage(
          text: const Text('Início',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: const SizedBox(
            width: 30,
            height: 30,
            child: Icon(Icons.home, color: Colors.white),
          ),
          page: NewHome(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Testemunhos',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: const SizedBox(
            width: 30,
            height: 30,
            child: Icon(Icons.handshake, color: Colors.white),
          ),
          page: Testemunho(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Devocional',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: const SizedBox(
              width: 30,
              height: 30,
              child: Icon(Icons.headphones, color: Colors.white)),
          page: DevocionalLista(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Agenda Templo',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: const SizedBox(
              width: 30,
              height: 30,
              child: Icon(Icons.edit_note, color: Colors.white)),
          page: ListarTemplo(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Inscrições',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Icon(Icons.edit_document, color: Colors.white)),
          page: Atividade(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Reels',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/icone_youtube.png')),
          page: VideoPage(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Pastorais',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: const SizedBox(
              width: 30,
              height: 30,
              child: Icon(
                Icons.menu_book_sharp,
                color: Colors.white,
                size: 25,
              )),
          page: PastoraisLista(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Youtube',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                'assets/social.png',
                color: Colors.white,
              )),
          page: Cultos_Youtube(),
        ),
        loginController.isAdmin
            ? CustomDrawerItem.initWithPage(
                text: const Text(
                  'Administrador',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.settings,
                      size: 25,
                      color: Colors.white,
                    )),
                page: LoginPage(),
              )
            : CustomDrawerItem.initWithPage(
                text: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.login,
                      size: 25,
                      color: Colors.white,
                    )),
                page: LoginPage(),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomDrawer(
        controller: _drawerController,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(45, 45, 42, 1.0),
        ),
      ),
    );
  }
}
