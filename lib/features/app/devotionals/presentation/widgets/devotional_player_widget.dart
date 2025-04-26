import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/themes/themes.dart';
import '../../devotionals.dart';

class DevotionalPlayerWidget extends StatefulWidget {
  final Devotional devotional;
  final VoidCallback onTap;

  const DevotionalPlayerWidget({
    super.key,
    required this.devotional,
    required this.onTap,
  });

  @override
  State<DevotionalPlayerWidget> createState() => _DevotionalPlayerWidgetState();
}

class _DevotionalPlayerWidgetState extends State<DevotionalPlayerWidget> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  late Stream<PositionData> _positionDataStream = Stream.value(
    PositionData(Duration.zero, Duration(seconds: 1)),
  );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudio();
  }

  Future<void> _setupAudio() async {
    await _audioPlayer.setUrl(widget.devotional.audioUrl);

    _positionDataStream = Rx.combineLatest2<Duration, Duration?, PositionData>(
      _audioPlayer.positionStream,
      _audioPlayer.durationStream,
      (position, duration) => PositionData(position, duration ?? Duration.zero),
    );

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });

    setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPurple.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.devotional.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.devotional.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'por ${widget.devotional.author}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data ??
                          PositionData(Duration.zero, Duration(seconds: 1));

                      final progress = positionData.position.inSeconds /
                          positionData.duration.inSeconds
                              .clamp(1, double.infinity);

                      return LinearProgressIndicator(
                        value: progress > 1 ? 1 : progress,
                        backgroundColor: AppColors.sage.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation(AppColors.copper),
                        minHeight: 4,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                isPlaying ? _audioPlayer.pause() : _audioPlayer.play();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.copper,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
