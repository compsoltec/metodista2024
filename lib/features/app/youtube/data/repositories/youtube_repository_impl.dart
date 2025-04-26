import '../../youtube.dart';

class YoutubeRepositoryImpl implements YoutubeRepository {
  final YoutubeRemoteDataSource remoteDataSource;

  YoutubeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<YoutubeVideo>> getYoutubeVideos() {
    return remoteDataSource.fetchVideos();
  }
}
