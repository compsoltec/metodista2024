import 'package:get/get.dart';
import 'package:notification2/module_videos/models/videos_models.dart';

import '../../module_config/constants/constants.dart';

class VideosProvider extends GetConnect {
  Future<List<VideosModels>> getVideos() async {
    String baseUrl =
        ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_VIDEOS;
    List<VideosModels> videosList = <VideosModels>[];
    final response = await get(baseUrl, decoder: (body) {
      videosList = videosFromJson(body['data']);
      return videosList;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar o Videos');
    }
    return videosList;
  }

 
}
