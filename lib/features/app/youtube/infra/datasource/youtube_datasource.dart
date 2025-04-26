import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../youtube.dart';

class YoutubeRemoteDataSource {
  final http.Client client;
  final String apiKey = 'AIzaSyBIk8C95HcxHG8yhI7z5Dl9zNQcN2tCpl8';
  final String playlistId = 'UUqxk4B6CQIxsaEWVhcDln6g';

  YoutubeRemoteDataSource(this.client);

  Future<List<YoutubeVideo>> fetchVideos() async {
    final url =
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=10&playlistId=$playlistId&key=$apiKey';

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final videos = data['items'] as List;

      return videos.map((video) {
        final snippet = video['snippet'];
        final videoId = snippet['resourceId']['videoId'] as String;
        final title = snippet['title'] as String;

        return YoutubeVideo(id: videoId, title: title);
      }).toList();
    } else {
      throw Exception('Erro ao carregar vídeos');
    }
  }
}
