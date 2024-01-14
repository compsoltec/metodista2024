import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../../module_youtube/components/custom_drawer.dart';

class VideoExecutar extends StatefulWidget {
  final String video;
  final String titulo;
  const VideoExecutar({Key? key, required this.video, required this.titulo})
      : super(key: key);
  @override
  State<VideoExecutar> createState() => _VideoExecutarState();
}

class _VideoExecutarState extends State<VideoExecutar> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    // Substitua 'seu_video.mp4' pelo caminho do seu vídeo local ou URL
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/metodista-novo.appspot.com/o/videos%2FVIDEO-2023-12-11-12-26-20.mp4?alt=media&token=881314b6-f6b3-480b-a730-f15b0bdc4bd2'));
    chewieController = ChewieController(
      fullScreenByDefault: true,
      videoPlayerController: videoPlayerController!,
      aspectRatio: 9 / 16, // Proporção do vídeo (ajuste conforme necessário)
      autoPlay: true, // Iniciar a reprodução automaticamente
      looping: true, // Repetir o vídeo
      // Outras opções conforme necessário
    );
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.titulo,
          style: GoogleFonts.quicksand(
              color: const Color.fromRGBO(45, 45, 42, 1.0),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: chewieController != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Chewie(
                controller: chewieController!,
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
