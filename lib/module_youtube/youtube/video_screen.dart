import 'package:flutter/material.dart';
import '../models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  //
  VideoPlayerScreen({required this.videoItem});
  final VideoItem videoItem;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  //
  YoutubePlayerController? _controller;
  bool? _isPlayerReady;
  final UniqueKey youtubeKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      flags: YoutubePlayerFlags(
        isLive: true,
      ),
      initialVideoId: widget.videoItem.video!.resourceId!.videoId!,
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady! && mounted && _controller!.value.isFullScreen) {
      //
    }
  }

  @override
  void deactivate() {
    _controller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).orientation == Orientation.landscape
            ? null // show nothing in lanscape mode
            : AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  widget!.videoItem.video!.title!,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Quicksand'),
                ),
                iconTheme: IconThemeData(color: Colors.black),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.black),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.white),
              child: YoutubePlayer(
                key: youtubeKey,
                controller: _controller!,
                showVideoProgressIndicator: true,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                ],
                onReady: () {
                  print('Player is ready.');
                  _isPlayerReady = true;
                },
              ),
            )));
  }
}
