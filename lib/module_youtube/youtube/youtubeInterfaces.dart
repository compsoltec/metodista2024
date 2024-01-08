import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/custom_drawer.dart';
import '../models/channel_model.dart';
import '../models/video_model.dart';
import '../services/API.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_screen.dart';

class Cultos_Youtube extends CustomDrawerContent {
  @override
  _Cultos_YoutubeState createState() => _Cultos_YoutubeState();
}

class _Cultos_YoutubeState extends State<Cultos_Youtube> {
  ChannelInfo? _channelInfo;
  VideosList? _videosList;
  Item? _item;
  bool? _loading;
  String? _playListId;
  String? _nextPageToken;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList?.videos = [];
    _getChannelInfo();
  }

  _getChannelInfo() async {
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo!.items![0];
    _playListId = _item!.contentDetails!.relatedPlaylists!.uploads;
    print('_playListId $_playListId');
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList(
      playListId: _playListId,
      pageToken: _nextPageToken,
    );
    _nextPageToken = tempVideosList.nextPageToken;
    _videosList!.videos!.addAll(tempVideosList.videos!);
    print('videos: ${_videosList!.videos!.length}');
    print('_nextPageToken $_nextPageToken');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: SizedBox(
            width: MediaQuery.of(context).size.width * 1 / 3,
            child: Align(
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                child: Material(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: widget.onMenuPressed,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.black),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Colors.white),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/cultoscanal.png'),
                          fit: BoxFit.fill)),
                ),
                _buildInfoView(),
                Expanded(
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (_videosList!.videos!.length >=
                          int.parse(_item!.statistics!.videoCount!)) {
                        return true;
                      }
                      if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent) {
                        _loadVideos();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _videosList!.videos!.length,
                      itemBuilder: (context, index) {
                        VideoItem videoItem = _videosList!.videos![index];
                        return InkWell(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VideoPlayerScreen(
                                videoItem: videoItem,
                              );
                            }));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: videoItem.video!.thumbnails!
                                      .thumbnailsDefault!.url!,
                                ),
                                const SizedBox(width: 20),
                                Flexible(child: Text(videoItem.video!.title!)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _buildInfoView() {
    return _loading!
        ? const CircularProgressIndicator.adaptive()
        : Container(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        _item!.snippet!.thumbnails!.medium!.url!,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        _item!.snippet!.title!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(_item!.statistics!.videoCount!),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          );
  }
}
