import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:notification2/module_testemunhos/providers/testemunhos_provider.dart';
import 'package:notification2/module_testemunhos/repositories/testemunhos_repositories.dart';

import '../models/testemunhos_model.dart';

class TestemunhosController extends GetxController {
  final testemunhosRepository =
      Get.put(TestemunhosRepository(api: TestemunhosProvider()));

  final testemunhosList = <TestemunhosModels>[].obs;
  RxBool loading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getTestemunhos();
  }

  getTestemunhos() {
    loading(true);
    testemunhosRepository.getTestemunhos().then((data) {
      testemunhosList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }
}
