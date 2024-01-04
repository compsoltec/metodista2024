import 'package:get/get.dart' hide Response;
import '../models/models.dart';
import '../providers/biblia_provider.dart';
import '../repositories/biblia_repositories.dart';

class BibliaController extends GetxController {
  final devocionalRepository =
      Get.put(BibliaRepository(api: BibliaProvider()));

  final devocionalList = <BibliaModels>[].obs;
  RxBool loading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getBiblia();
  }

  getBiblia() {
    loading(true);
    devocionalRepository.getBiblia().then((data) {
      devocionalList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }
}
