import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: use_build_context_synchronously
import 'package:video_player/video_player.dart';

import '../../../../../core/core.dart';
import '../../../notices/notices.dart';

class YoutubeStyleFullscreenPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final String title;
  final Notices video;

  const YoutubeStyleFullscreenPlayer({
    super.key,
    required this.controller,
    required this.title,
    required this.video,
  });

  @override
  State<YoutubeStyleFullscreenPlayer> createState() =>
      _YoutubeStyleFullscreenPlayerState();
}

class _YoutubeStyleFullscreenPlayerState
    extends State<YoutubeStyleFullscreenPlayer> {
  bool _showControls = true;
  Timer? _hideControlsTimer;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _enterFullscreenMode();
    widget.controller.play();
    widget.controller.setLooping(true);
    _startHideControlsTimer();
    widget.controller.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  Future<void> _enterFullscreenMode() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _exitFullscreenMode() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    if (_isLocked) return;
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && widget.controller.value.isPlaying) {
        setState(() => _showControls = false);
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _toggleControls() {
    if (_isLocked) return;
    setState(() => _showControls = !_showControls);
    if (_showControls) _startHideControlsTimer();
  }

  void _togglePlayPause() {
    setState(() {
      widget.controller.value.isPlaying
          ? widget.controller.pause()
          : widget.controller.play();
      _startHideControlsTimer();
    });
  }

  void _toggleLock() {
    setState(() {
      _isLocked = !_isLocked;
      if (_isLocked) {
        _hideControlsTimer?.cancel();
        _showControls = false;
      } else {
        _showControls = true;
        _startHideControlsTimer();
      }
    });
  }

  void _seekBy(Duration offset) {
    final pos = widget.controller.value.position + offset;
    widget.controller.seekTo(pos);
    _startHideControlsTimer();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return d.inHours > 0 ? '${twoDigits(d.inHours)}:$m:$s' : '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.controller.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        await _exitFullscreenMode();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: _toggleControls,
          onDoubleTap: _togglePlayPause,
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
              ),
              if (_showControls && !_isLocked) _buildControlsOverlay(context),
              if (_isLocked && !_showControls)
                Positioned(
                  top: 24,
                  right: 24,
                  child: Icon(Icons.lock, color: Colors.white60),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlsOverlay(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () async {
                  await _exitFullscreenMode();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(_isLocked ? Icons.lock : Icons.lock_open,
                    color: Colors.white),
                onPressed: _toggleLock,
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_10, color: Colors.white, size: 36),
              onPressed: () => _seekBy(const Duration(seconds: -10)),
            ),
            IconButton(
              icon: Icon(
                widget.controller.value.isPlaying
                    ? Icons.pause_circle
                    : Icons.play_circle,
                size: 48,
                color: Colors.white,
              ),
              onPressed: _togglePlayPause,
            ),
            IconButton(
              icon: const Icon(Icons.forward_10, color: Colors.white, size: 36),
              onPressed: () => _seekBy(const Duration(seconds: 10)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              VideoProgressIndicator(
                widget.controller,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Colors.red,
                  bufferedColor: Colors.grey,
                  backgroundColor: Colors.white30,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  IconButton(
                    icon: const Icon(Icons.fullscreen, color: Colors.white),
                    onPressed: () async {
                      await _exitFullscreenMode();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
