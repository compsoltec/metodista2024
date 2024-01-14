import '../providers/videos_provider.dart';

class VideosRepository {
  final VideosProvider api;

  VideosRepository({required this.api});

  getVideos() {
    return api.getVideos();
  }
}
