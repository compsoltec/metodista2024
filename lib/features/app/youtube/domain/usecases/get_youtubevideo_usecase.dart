import '../../youtube.dart';

class GetYoutubeVideosUseCase {
  final YoutubeRepository repository;

  GetYoutubeVideosUseCase(this.repository);

  Future<List<YoutubeVideo>> call() async {
    return await repository.getYoutubeVideos();
  }
}
