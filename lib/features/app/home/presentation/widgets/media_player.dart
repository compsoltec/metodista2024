import 'dart:async';

import 'package:flutter/material.dart';
import 'package:metodista/features/app/notices/notices.dart';

import '../../../../../core/core.dart';
import 'full_screen_video.dart';

class MediaPlayerWidget extends StatefulWidget {
  final List<Notices> notices;

  const MediaPlayerWidget({super.key, required this.notices});

  @override
  State<MediaPlayerWidget> createState() => _MediaPlayerWidgetState();
}

class _MediaPlayerWidgetState extends State<MediaPlayerWidget> {
  late List<VideoPlayerController> _controllers;
  int _current = 0;
  bool _showControls = true;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  Future<void> _initializeControllers() async {
    _controllers = widget.notices.map((notice) {
      final controller = VideoPlayerController.network(notice.image)
        ..initialize().then((_) {
          setState(() {});
        })
        ..setLooping(true);
      controller.addListener(_controllerListener);
      return controller;
    }).toList();
  }

  void _controllerListener() {
    // Rebuild UI when playback state changes
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    for (var controller in _controllers) {
      controller.removeListener(_controllerListener);
      controller.dispose();
    }
    super.dispose();
  }

  void _resetHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _controllers[_current].value.isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _resetHideControlsTimer();
      }
    });
  }

  void _togglePlayPause() {
    final controller = _controllers[_current];
    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
        _hideControlsTimer?.cancel();
        _showControls = true;
      } else {
        controller.play();
        _resetHideControlsTimer();
      }
    });
  }

  void _goToFullscreen(int index) async {
    final controller = _controllers[index];
    // Pause all videos
    for (var c in _controllers) {
      c.pause();
    }

    // Enter fullscreen
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YoutubeStyleFullscreenPlayer(
          controller: controller,
          title: "Video ${index + 1}",
          video: widget.notices[index],
        ),
      ),
    );

    // Resume regular playback state after exiting fullscreen
    setState(() {});
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    if (_controllers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final videoHeight = screenWidth * 9 / 16; // 16:9 aspect ratio by default

    return Column(
      children: [
        SizedBox(
          height: videoHeight,
          child: CarouselSlider.builder(
            itemCount: _controllers.length,
            itemBuilder: (context, index, _) {
              final controller = _controllers[index];

              if (!controller.value.isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }

              return GestureDetector(
                onTap: _toggleControls,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Video player
                      AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),

                      // Overlay controls (only shown when _showControls is true)
                      if (_showControls || !controller.value.isPlaying)
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                              stops: const [0.0, 0.2, 0.8, 1.0],
                            ),
                          ),
                        ),

                      // Play/Pause button
                      if (_showControls || !controller.value.isPlaying)
                        IconButton(
                          icon: Icon(
                            controller.value.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            size: 64,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          onPressed: _togglePlayPause,
                        ),

                      // Bottom controls bar
                      if (_showControls)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Video progress slider
                                VideoProgressIndicator(
                                  controller,
                                  allowScrubbing: true,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  colors: const VideoProgressColors(
                                    playedColor: Colors.red,
                                    bufferedColor: Colors.grey,
                                    backgroundColor: Colors.white24,
                                  ),
                                ),

                                // Time display and fullscreen button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_formatDuration(controller.value.position)} / ${_formatDuration(controller.value.duration)}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.fullscreen,
                                          color: Colors.white),
                                      onPressed: () => _goToFullscreen(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Top bar with title and back button
                      if (_showControls)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Video ${index + 1}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.settings,
                                      color: Colors.white),
                                  onPressed: () {
                                    // Show settings dialog
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Video Settings'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              title:
                                                  const Text('Playback Speed'),
                                              trailing: DropdownButton<double>(
                                                value: controller
                                                    .value.playbackSpeed,
                                                items: [
                                                  0.5,
                                                  0.75,
                                                  1.0,
                                                  1.25,
                                                  1.5,
                                                  2.0
                                                ]
                                                    .map((speed) =>
                                                        DropdownMenuItem(
                                                          value: speed,
                                                          child:
                                                              Text('${speed}x'),
                                                        ))
                                                    .toList(),
                                                onChanged: (double? speed) {
                                                  if (speed != null) {
                                                    controller.setPlaybackSpeed(
                                                        speed);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text('Close'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: videoHeight,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  for (int i = 0; i < _controllers.length; i++) {
                    if (i != index) _controllers[i].pause();
                  }
                  _showControls = true;
                  _resetHideControlsTimer();
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Video navigation dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.notices.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _jumpToSlide(entry.key),
              child: Container(
                width: _current == entry.key ? 12.0 : 8.0,
                height: _current == entry.key ? 12.0 : 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? Colors.red
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
            );
          }).toList(),
        ),

        // Video title and description
        if (_controllers[_current].value.isInitialized)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.notices[_current].name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "This is a description for Video ${_current + 1}. You can replace this with actual video metadata.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _jumpToSlide(int index) {
    setState(() {
      _current = index;
      for (int i = 0; i < _controllers.length; i++) {
        if (i != index) _controllers[i].pause();
      }
      _controllers[index].play();
      _showControls = true;
      _resetHideControlsTimer();
    });
  }
}
