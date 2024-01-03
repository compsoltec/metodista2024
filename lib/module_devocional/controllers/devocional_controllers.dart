import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:notification2/module_devocional/module_devocional.dart';
import 'package:notification2/module_devocional/providers/devocional_provider.dart';
import 'package:notification2/module_devocional/repositories/devocional_repositories.dart';

class DevocionalController extends GetxController {
  final devocionalRepository =
      Get.put(DevocionalRepository(api: DevocionalProvider()));

  final devocionalList = <DevocionalModels>[].obs;
  RxBool loading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getDevocional();
  }

  getDevocional() {
    loading(true);
    devocionalRepository.getDevocional().then((data) {
      devocionalList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }
}
