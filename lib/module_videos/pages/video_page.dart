import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification2/module_videos/controllers/videos_controllers.dart';
import 'package:notification2/module_videos/pages/video_executar.dart';
import 'package:video_player/video_player.dart';

import '../../module_config/constants/colors_constants.dart';
import '../../module_youtube/components/custom_drawer.dart';

class VideoPage extends CustomDrawerContent {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final VideosController videosController = Get.put(VideosController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      child: Material(
                        shadowColor: Colors.transparent,
                        color: Colors.transparent,
                        child: IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Color.fromRGBO(45, 45, 42, 1.0),
                          ),
                          onPressed: widget.onMenuPressed,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Reels',
                        style: GoogleFonts.quicksand(
                            color: const Color.fromRGBO(45, 45, 42, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 2),
                  padding: EdgeInsets.all(10),
                  itemCount: videosController.videosList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Get.to(() => VideoExecutar(
                                video: videosController.videosList[index].video,
                                titulo:
                                    videosController.videosList[index].titulo,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(videosController
                                          .videosList[index].foto),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: ColorsConstants().primaryColor),
                              padding: const EdgeInsets.all(5),
                              width: 150,
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ClipOval(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  color: Colors.transparent
                                                      .withOpacity(0.1),
                                                  offset: const Offset(0, 10))
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: Image.asset(
                                              'assets/icone_youtube.png'))),
                                ],
                              )),
                        ));
                  })),
        ],
      ),
    ));
  }
}
