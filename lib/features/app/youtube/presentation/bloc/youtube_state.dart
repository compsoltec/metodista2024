import '../../youtube.dart';

abstract class YoutubeState {}

class YoutubeLoading extends YoutubeState {}

class YoutubeLoaded extends YoutubeState {
  final List<YoutubeVideo> videos;
  YoutubeLoaded(this.videos);
}

class YoutubeError extends YoutubeState {
  final String message;
  YoutubeError(this.message);
}
