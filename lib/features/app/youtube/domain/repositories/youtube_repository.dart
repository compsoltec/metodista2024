import 'package:metodista/features/app/youtube/youtube.dart';

abstract class YoutubeRepository {
  Future<List<YoutubeVideo>> getYoutubeVideos();
}
