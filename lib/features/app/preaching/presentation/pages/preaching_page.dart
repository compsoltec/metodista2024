import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../core/core.dart';
import '../../preaching.dart';

class PreachingPage extends StatefulWidget {
  final List<Preaching> preachings;

  const PreachingPage({super.key, required this.preachings});

  @override
  State<PreachingPage> createState() => _PreachingPageState();
}

class _PreachingPageState extends State<PreachingPage> {
  late AudioPlayer _audioPlayer;
  int currentIndex = 0;
  bool isPlaying = false;
  bool isShuffle = false;
  bool isRepeat = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadPreachingAudio();
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });
  }

  void _loadPreachingAudio() async {
    await _audioPlayer.setUrl(widget.preachings[currentIndex].audioUrl);
  }

  void _playPause() {
    isPlaying ? _audioPlayer.pause() : _audioPlayer.play();
  }

  void _next() {
    if (isShuffle) {
      currentIndex = (widget.preachings.length *
                  (DateTime.now().millisecondsSinceEpoch % 1000) /
                  1000)
              .floor() %
          widget.preachings.length;
    } else {
      currentIndex = (currentIndex + 1) % widget.preachings.length;
    }
    _loadPreachingAudio();
    _audioPlayer.play();
  }

  void _previous() {
    currentIndex = (currentIndex - 1 + widget.preachings.length) %
        widget.preachings.length;
    _loadPreachingAudio();
    _audioPlayer.play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preaching = widget.preachings[currentIndex];

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Current Playing
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    preaching.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        preaching.title,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'por ${preaching.author}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _playPause,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.copper,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final total = _audioPlayer.duration ?? Duration(seconds: 1);

                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: position.inSeconds / total.inSeconds,
                      backgroundColor: AppColors.lightGray,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.copper),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(position),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          _formatDuration(total),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),

          // Controls
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => isShuffle = !isShuffle);
                  },
                  child: Icon(Icons.shuffle,
                      color: isShuffle
                          ? AppColors.copper
                          : AppColors.textSecondary),
                ),
                GestureDetector(
                  onTap: _previous,
                  child: Icon(Icons.skip_previous,
                      color: AppColors.textPrimary, size: 32),
                ),
                GestureDetector(
                  onTap: _playPause,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.copper,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _next,
                  child: Icon(Icons.skip_next,
                      color: AppColors.textPrimary, size: 32),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => isRepeat = !isRepeat);
                    _audioPlayer
                        .setLoopMode(isRepeat ? LoopMode.one : LoopMode.off);
                  },
                  child: Icon(Icons.repeat,
                      color: isRepeat
                          ? AppColors.copper
                          : AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
