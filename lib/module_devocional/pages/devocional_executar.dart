import 'dart:io';
import 'dart:ui';
import 'package:audio_session/audio_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../../module_services/audio_services/audio_services.dart';
import '../../module_services/module_services.dart';

class ExecutarDevocional extends StatefulWidget {
  final String foto, titulo, devocional, data;
  const ExecutarDevocional(
      {super.key,
      required this.foto,
      required this.titulo,
      required this.devocional,
      required this.data});
  @override
  State<ExecutarDevocional> createState() => _ExecutarDevocionalState();
}

class _ExecutarDevocionalState extends State<ExecutarDevocional> {
  static int _nextMediaId = 0;
  AudioPlayer? _player;
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final _playlist = ConcatenatingAudioSource(children: [
      ClippingAudioSource(
        start: Duration(seconds: 0),
        child: AudioSource.uri(Uri.parse(widget.devocional)),
        tag: MediaItem(
          id: '${_nextMediaId++}',
          album: widget.titulo,
          title: widget.data,
          artUri: Uri.parse(widget.foto),
        ),
      ),
    ]);
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player!.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player!.setAudioSource(_playlist);
    } catch (e, stackTrace) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      print(stackTrace);
    }
  }

  //SHARED

  Future<void> share() async {
    await FlutterShare.share(
        title: widget.data,
        text: widget.titulo,
        linkUrl: widget.devocional,
        chooserTitle: widget.titulo);
  }

  Future<void> shareFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return null;

    await FlutterShare.shareFile(
      title: widget.titulo,
      text: widget.data,
      filePath: result.files[0] as String,
    );
  }

  @override
  void dispose() {
    _player!.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player!.positionStream,
          _player!.bufferedPositionStream,
          _player!.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          elevation: 0,
          onPressed: () {},
          label: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    showSliderDialog(
                      context: context,
                      title: "Adjust volume",
                      divisions: 10,
                      min: 0.0,
                      max: 1.0,
                      stream: _player!.volumeStream,
                      onChanged: _player!.setVolume,
                    );
                  },
                  icon: const Icon(
                    Icons.volume_up,
                    size: 30,
                    color: Color.fromRGBO(45, 45, 42, 1.0),
                  ),
                ),
                StreamBuilder<PlayerState>(
                  stream: _player!.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState?.processingState;
                    final playing = playerState?.playing;
                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        width: 64.0,
                        height: 64.0,
                        child: CircularProgressIndicator(),
                      );
                    } else if (playing != true) {
                      return IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: Color.fromRGBO(45, 45, 42, 1.0),
                        ),
                        iconSize: 70.0,
                        onPressed: _player!.play,
                      );
                    } else if (processingState != ProcessingState.completed) {
                      return IconButton(
                        icon: Icon(
                          Icons.pause,
                          color: Colors.grey,
                        ),
                        iconSize: 64.0,
                        onPressed: _player!.pause,
                      );
                    } else {
                      return IconButton(
                        icon: Icon(
                          Icons.replay,
                          color: Colors.grey,
                        ),
                        iconSize: 64.0,
                        onPressed: () => _player!.seek(Duration.zero,
                            index: _player!.effectiveIndices!.first),
                      );
                    }
                  },
                ),
                IconButton(
                  onPressed: () {
                    share();
                  },
                  icon: const Icon(
                    Icons.share,
                    size: 30,
                    color: Color.fromRGBO(45, 45, 42, 1.0),
                  ),
                )
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: <Widget>[
          _buildWidgetAlbumCoverBlur(mediaQuery),
          _buildWidgetContainerMusicPlayer(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetContainerMusicPlayer(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(top: mediaQuery.padding.top + 16.0),
      child: Column(
        children: <Widget>[
          _buildWidgetActionAppBar(),
          SizedBox(height: 48.0),
          _buildWidgetPanelMusicPlayer(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetPanelMusicPlayer(MediaQueryData mediaQuery) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48.0),
            topRight: Radius.circular(48.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 36.0),
              _buildWidgetArtistPhoto(mediaQuery),
              SizedBox(height: 48.0),
              _buildWidgetLinearProgressIndicator(),
              SizedBox(height: 4.0),
              //_buildWidgetLabelDurationMusic(),
              SizedBox(height: 36.0),
              _buildWidgetMusicInfo(),
              // _buildWidgetControlMusicPlayer(),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetControlMusicPlayer() {
    return Expanded(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                  onPressed: () {
                    showSliderDialog(
                      context: context,
                      title: "Adjust volume",
                      divisions: 10,
                      min: 0.0,
                      max: 1.0,
                      stream: _player!.volumeStream,
                      onChanged: _player!.setVolume,
                    );
                  },
                  icon: Icon(Icons.volume_up)),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  share();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetMusicInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.titulo,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Campton_Light",
              fontSize: 20.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.0),
          Text(
            'Pr.Douglas Marins',
            style: TextStyle(
              fontFamily: "Campton_Light",
              color: Color.fromRGBO(45, 45, 42, 1.0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetLinearProgressIndicator() {
    return Column(
      children: <Widget>[
        StreamBuilder<PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            return SeekBar(
              duration: positionData?.duration ?? Duration.zero,
              position: positionData?.position ?? Duration.zero,
              bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
              onChangeEnd: (newPosition) {
                _player!.seek(newPosition);
              },
              onChanged: (Duration value) {},
            );
          },
        ),
      ],
    );
  }

  Widget _buildWidgetArtistPhoto(MediaQueryData mediaQuery) {
    return Center(
      child: Container(
        width: mediaQuery.size.width / 2.5,
        height: mediaQuery.size.width / 2.5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
          image: DecorationImage(
            image: NetworkImage(
              widget.foto,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetActionAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Text(
            "Devocional",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Campton_Light",
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
            ),
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetAlbumCoverBlur(MediaQueryData mediaQuery) {
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height / 1.8,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(widget.foto),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
      ),
    );
  }
}
