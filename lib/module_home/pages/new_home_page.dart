import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_devocional/controllers/devocional_controllers.dart';
import 'package:notification2/module_home/module_home.dart';
import 'package:notification2/module_home/pages/material_design.dart';
import 'package:notification2/module_home/pages/sliping_card.dart';
import 'package:notification2/module_youtube/components/custom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../module_devocional/pages/devocional.dart';
import '../../modulo_pix/module_pix.dart';
import '../components/aniversariantes.dart';
import '../components/pastoral.dart';
import '../widget/body_home_widget.dart';

class NewHome extends CustomDrawerContent {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> with SingleTickerProviderStateMixin {
  final Uri _url = Uri.parse('https://wa.me/5524999868778');
  final Uri _urlInsta =
      Uri.parse('https://www.instagram.com/metodistajardimbelvedere/');
  final Uri _urlYoutube =
      Uri.parse('https://www.youtube.com/@igrejametodistajardimbelve1956');
  final Uri _urlFacebook =
      Uri.parse('https://www.facebook.com/igrejametodistajdbelvedere/');
  DevocionalController devocionalController = Get.put(DevocionalController());
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                child: Material(
                  shadowColor: Colors.grey.shade600,
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
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/novotemplo.jpeg'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _socialMedia(img: 'whats_logo.png', ontap: _launchUrl),
                        const SizedBox(
                          height: 3,
                        ),
                        _socialMedia(
                            img: 'face_logo.png', ontap: _launchUrlFacabook),
                        const SizedBox(
                          height: 3,
                        ),
                        _socialMedia(
                            img: 'insta_logo.png', ontap: _launchUrlInsta),
                        // const Padding(
                        //   padding: EdgeInsets.only(right: 10),
                        //   child: AoVivo(),
                        // ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Metodista Jardim Belvedere',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                'Desde 2007',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => devocionalController.loading.value
                                      ? Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        )
                                      : Devocional(
                                          devocionalList: devocionalController
                                              .devocionalList,
                                        ),
                                ),
                                const SizedBox(height: 20),
                                _title(title: 'Pastoral'),
                                const SizedBox(height: 15),
                                Obx(
                                  () => homeController.isLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        )
                                      : Pastoral(
                                          pastoral: homeController
                                              .homeModel!.pastoral!,
                                        ),
                                ),
                                const SizedBox(height: 20),
                                _title(title: 'Nosso Pix:'),
                                const ScreenPixCopy(),
                                _title(title: 'Programações'),
                                const SizedBox(height: 15),

                                // BodyHome(),
                              ]),
                        ),
                        BodyHome(),
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Aniversariantes",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 15),
                        Aniversariantes()
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _title({
    required String title,
  }) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _socialMedia({
    required String img,
    required VoidCallback ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, right: 10),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: const [
                BoxShadow(color: Colors.white, blurRadius: 7.0),
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/$img'),
              )),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchUrlInsta() async {
    if (!await launchUrl(_urlInsta)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchUrlYoutube() async {
    if (!await launchUrl(_urlYoutube)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchUrlFacabook() async {
    if (!await launchUrl(_urlFacebook)) {
      throw Exception('Could not launch $_url');
    }
  }
}
