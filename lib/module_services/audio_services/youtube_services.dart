import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../module_youtube/constants/string.dart';
import '../../module_youtube/models/channel_model.dart';
import '../../module_youtube/models/video_model.dart';


const CHAVE_YOUTUBE_API_ANDROID = 'AIzaSyBuRWgo4ODmR5XhZd43FQnG5qzrDpGpf-w';
const CHAVE_YOUTUBE_API_IOS = 'AIzaSyDkBWgIvJIIdNdGahe_YffRQMukBYOMlEc';
const URL_BASE = 'https://www.googleapis.com/youtube/v3/';

class Services {
  //
  static const CHANNEL_ID = 'UCqxk4B6CQIxsaEWVhcDln6g';
  static const _baseUrl = 'www.googleapis.com';

  static Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

  static Future<VideosList> getVideosList(
      {String? playListId, String? pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId!,
      'maxResults': '8',
      'pageToken': pageToken!,
      'key': API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}
