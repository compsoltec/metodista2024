import '../../../../core/core.dart';
import 'pages.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
