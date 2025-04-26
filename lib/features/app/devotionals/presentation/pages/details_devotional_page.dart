import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:metodista/core/themes/app_colors.dart';
import 'package:rxdart/rxdart.dart';

import '../../devotionals.dart';

class PositionData {
  final Duration position;
  final Duration duration;

  PositionData(this.position, this.duration);
}

class DevotionalDetailPage extends StatefulWidget {
  final Devotional devotional;

  const DevotionalDetailPage({super.key, required this.devotional});

  @override
  State<DevotionalDetailPage> createState() => _DevotionalDetailPageState();
}

class _DevotionalDetailPageState extends State<DevotionalDetailPage> {
  late AudioPlayer _audioPlayer;
  late Stream<PositionData> _positionDataStream = Stream.value(
    PositionData(Duration.zero, Duration(seconds: 1)),
  );
  double volume = 0.5;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudio();
  }

  Future<void> _setupAudio() async {
    await _audioPlayer.setUrl(widget.devotional.audioUrl);
    _audioPlayer.setVolume(volume);

    _positionDataStream = Rx.combineLatest2<Duration, Duration?, PositionData>(
      _audioPlayer.positionStream,
      _audioPlayer.durationStream,
      (position, duration) => PositionData(position, duration ?? Duration.zero),
    );

    // Notifica o Flutter que o estado mudou após configurar a Stream
    setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Ouvindo agora',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.devotional.imageUrl,
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.devotional.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'por ${widget.devotional.author}',
              style: TextStyle(color: AppColors.secondaryColor),
            ),
            const SizedBox(height: 16),
            _buildProgressBar(),
            const SizedBox(height: 16),
            _buildControls(),
            const SizedBox(height: 16),
            _buildVolumeControl(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    if (_audioPlayer.playerState.processingState == ProcessingState.idle) {
      return const CircularProgressIndicator();
    }

    return StreamBuilder<PositionData>(
      stream: _positionDataStream,
      builder: (context, snapshot) {
        final positionData =
            snapshot.data ?? PositionData(Duration.zero, Duration(seconds: 1));

        return ProgressBar(
          progress: positionData.position,
          total: positionData.duration,
          onSeek: _audioPlayer.seek,
          barHeight: 5,
          baseBarColor: Colors.grey.shade300,
          progressBarColor: AppColors.primaryColor,
          thumbColor: AppColors.primaryColor,
          timeLabelTextStyle: TextStyle(color: AppColors.primaryColor),
        );
      },
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay_10),
          iconSize: 36,
          onPressed: () {
            final newPosition =
                _audioPlayer.position - const Duration(seconds: 10);
            _audioPlayer.seek(
                newPosition > Duration.zero ? newPosition : Duration.zero);
          },
        ),
        StreamBuilder<PlayerState>(
          stream: _audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data?.playing ?? false;

            return IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              ),
              iconSize: 64,
              color: AppColors.primaryColor,
              onPressed: () {
                if (isPlaying) {
                  _audioPlayer.pause();
                } else {
                  _audioPlayer.play();
                }
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.forward_10),
          iconSize: 36,
          onPressed: () {
            final newPosition =
                _audioPlayer.position + const Duration(seconds: 10);
            if (_audioPlayer.duration != null &&
                newPosition < _audioPlayer.duration!) {
              _audioPlayer.seek(newPosition);
            }
          },
        ),
      ],
    );
  }

  Widget _buildVolumeControl() {
    return Column(
      children: [
        const Text('Volume'),
        Slider(
          value: volume,
          min: 0,
          max: 1,
          divisions: 10,
          onChanged: (value) {
            setState(() {
              volume = value;
              _audioPlayer.setVolume(volume);
            });
          },
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.secondaryColor.withOpacity(0.3),
        ),
      ],
    );
  }
}
