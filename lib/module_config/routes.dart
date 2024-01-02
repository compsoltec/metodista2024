import 'package:get/get.dart';
import '../admin/module_home/module_home.dart';

class Routes {
  static const String Tela_Home = "/home";
  static const String Tela_HomeEdit = "/home_edit";

  static final routes = [
    GetPage(
      name: Tela_Home,
      page: () => HomePageAdmin(),
    ),
    GetPage(name: Tela_HomeEdit, page: () => HomePageEdit()),
  ];
}
