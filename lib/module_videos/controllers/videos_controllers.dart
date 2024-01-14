import 'package:get/get.dart';
import 'package:notification2/module_videos/models/videos_models.dart';

import '../providers/videos_provider.dart';
import '../repositories/videos_repository.dart';

class VideosController extends GetxController {
  final videosRepository = Get.put(VideosRepository(api: VideosProvider()));

  final videosList = <VideosModels>[].obs;
  RxBool loading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getVideos();
  }

  getVideos() {
    loading(true);
    videosRepository.getVideos().then((data) {
      videosList.value = data;
      loading(false);
    }, onError: (e) {
      loading(false);
    });
  }
}
