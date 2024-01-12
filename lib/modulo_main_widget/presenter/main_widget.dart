import 'package:flutter/material.dart';
import 'package:notification2/admin/admin.dart';
import 'package:notification2/module_home/pages/new_home_page.dart';
import 'package:notification2/module_inscricoes/pages/inscricoes.dart';
import 'package:notification2/module_templo.dart/pages/listar_templo.dart';
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
            'Pedido de Oração',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          // icon: SizedBox(
          //     height: 30,
          //     width: 30,
          //     child: Image.asset('images/icone_oracao.png')),
          // page: PedidoDeOracao(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Espaço Kids',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          // icon: SizedBox(
          //     width: 30,
          //     height: 30,
          //     child: Image.asset('images/icone_kids.png')),
          // page: MenuKidsScreen(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Youtube',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/icone_youtube.png')),
          page: Cultos_Youtube(),
        ),
        CustomDrawerItem.initWithPage(
          text: const Text(
            'Youtube',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/icone_youtube.png')),
          page: HomePageAdmin(),
        ),
        // CustomDrawerItem.initWithPage(
        //     text: const Text(
        //       'Ministérios',
        //       style: TextStyle(color: Colors.white, fontSize: 18),
        //     ),
        //     icon: SizedBox(
        //         width: 30,
        //         height: 30,
        //         child: Image.asset('images/icone_ministerio.png')),
        //     page: MenuMinisterios()),
        // pref.getAdminData().contains('admin')
        //     ? CustomDrawerItem.initWithPage(
        //         text: const Text(
        //           'Administrativo',
        //           style: TextStyle(color: Colors.white, fontSize: 18),
        //         ),
        //         icon:
        //             const Icon(Icons.admin_panel_settings, color: Colors.white),
        //         page: MenuAdministrativo())
        //     : CustomDrawerItem.initWithPage(
        //         text: const Text(
        //           'Login',
        //           style: TextStyle(color: Colors.transparent, fontSize: 18),
        //         ),
        //         icon: const Icon(Icons.admin_panel_settings,
        //             color: Colors.transparent),
        //         page: LoginPage())
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
