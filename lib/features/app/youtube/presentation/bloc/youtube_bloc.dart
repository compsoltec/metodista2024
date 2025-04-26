import '../../../../../core/core.dart';
import '../../youtube.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  final GetYoutubeVideosUseCase getVideos;

  YoutubeBloc(this.getVideos) : super(YoutubeLoading()) {
    on<FetchYoutubeVideos>(_onFetchYoutubeVideos);
  }

  Future<void> _onFetchYoutubeVideos(
      FetchYoutubeVideos event, Emitter<YoutubeState> emit) async {
    emit(YoutubeLoading());
    try {
      final videos = await getVideos();
      emit(YoutubeLoaded(videos));
    } catch (e) {
      emit(YoutubeError('Erro ao carregar vídeos'));
    }
  }
}
