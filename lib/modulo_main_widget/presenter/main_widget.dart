import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metodista/module_cadastro/pages/visulizar_cadastro.dart';
import 'package:metodista/module_login/controllers/login_controllers.dart';
import 'package:metodista/module_login/pages/login_page.dart';
import 'package:metodista/module_ministerios/pages/pages.dart';
import 'package:metodista/module_pastorais/controllers/pastorais_controllers.dart';
import 'package:metodista/module_pastorais/pages/pastorais_lista.dart';
import 'package:metodista/modulo_atividade/presenter/presenter.dart';
import 'package:metodista/modulo_documentos/presenter/presenter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../module_devocional/controllers/controllers.dart';
import '../../module_devocional/pages/devocional.dart';
import '../../module_devocional/pages/devocional_lista.dart';
import '../../module_home/components/pastoral.dart';
import '../../module_home/module_home.dart';
import '../../module_testemunhos/pages/testemunho.dart';
import '../../module_youtube/components/custom_drawer.dart';
import '../../module_youtube/constants/string.dart';
import '../../module_youtube/youtube/youtube.dart';

class MainWidget extends StatefulWidget {
  MainWidget({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  late CustomDrawerController _drawerController;
  final PastoraisController pastoraisController =
      Get.put(PastoraisController());
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _drawerController = CustomDrawerController(
      initialPage: NewHome(),
      items: _buildDrawerItems(),
    );
  }

  List<CustomDrawerItem> _buildDrawerItems() {
    return [
      _buildDrawerItem('Início', Icons.home, NewHome()),
      _buildDrawerItem('Testemunhos', Icons.handshake, Testemunho()),
      _buildDrawerItem('Devocional', Icons.headphones, DevocionalLista()),
      _buildDrawerItem('Inscrições', Icons.edit_document, AtividadePage()),
      _buildDrawerItem('Curriculos', Icons.app_registration_rounded,
          VisualizarCadastrados()),
      _buildDrawerItem('Documentos', Icons.document_scanner, Documentos()),
      _buildDrawerItem('Pastorais', Icons.menu_book_sharp, PastoraisLista()),
      _buildDrawerItem('Youtube', Icons.play_circle_outline, Cultos_Youtube(),
          isImageIcon: true, imagePath: 'assets/social.png'),
      _buildDrawerItem('Ministerios', Icons.people, HomeMinisterios(),
          isImageIcon: true, imagePath: 'assets/pessoas.png'),
      _buildAdminOrLoginItem(),
    ];
  }

  CustomDrawerItem _buildDrawerItem(String text, IconData icon, Widget page,
      {bool isImageIcon = false, String? imagePath}) {
    return CustomDrawerItem.initWithPage(
      text:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
      icon: SizedBox(
        width: 30,
        height: 30,
        child: isImageIcon
            ? Image.asset(imagePath!, color: Colors.white)
            : Icon(icon, color: Colors.white),
      ),
    );
  }

  CustomDrawerItem _buildAdminOrLoginItem() {
    return loginController.isAdmin
        ? _buildDrawerItem('Administrador', Icons.settings, LoginPage())
        : _buildDrawerItem('Login', Icons.login, LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomDrawer(
        controller: _drawerController,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2D2D2A),
              Color(0xFF1A1A18),
            ],
          ),
        ),
      ),
    );
  }
}

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

  final DevocionalController devocionalController =
      Get.put(DevocionalController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSocialMediaButtons(),
                  _buildChurchInfo(),
                  _buildContentCards(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.menu, color: Colors.white),
        ),
        onPressed: widget.onMenuPressed,
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/novotemplo.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaButtons() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _socialMediaButton(icon: 'whats_logo.png', onTap: _launchUrl),
          const SizedBox(width: 10),
          _socialMediaButton(icon: 'face_logo.png', onTap: _launchUrlFacabook),
          const SizedBox(width: 10),
          _socialMediaButton(icon: 'insta_logo.png', onTap: _launchUrlInsta),
        ],
      ),
    );
  }

  Widget _buildChurchInfo() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Metodista Jardim Belvedere',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Desde 2007',
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: 16,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCards() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
              'Devocional',
              Obx(() => devocionalController.loading.value
                  ? _buildShimmerLoading()
                  : Devocional(
                      devocionalList: devocionalController.devocionalList))),
          _buildSection(
              'Pastoral',
              Obx(() => homeController.isLoading.value
                  ? _buildShimmerLoading()
                  : Pastoral(pastoral: homeController.homeModel!.pastoral!))),
          _buildSection('Nosso PIX', const ScreenPixCopy()),
          _buildSection('Programações', BodyHome()),
          _buildSection('Aniversariantes', Aniversariantes()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(title),
          const SizedBox(height: 15),
          content,
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _socialMediaButton(
      {required String icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.asset(
          'assets/$icon',
          width: 25,
          height: 25,
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
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
      throw Exception('Could not launch $_urlInsta');
    }
  }

  Future<void> _launchUrlYoutube() async {
    if (!await launchUrl(_urlYoutube)) {
      throw Exception('Could not launch $_urlYoutube');
    }
  }

  Future<void> _launchUrlFacabook() async {
    if (!await launchUrl(_urlFacebook)) {
      throw Exception('Could not launch $_urlFacebook');
    }
  }
}

class BodyHome extends GetView<HomeController> {
  final devocionalController = Get.put(DevocionalController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => devocionalController.loading.value
        ? _buildLoadingShimmer()
        : Container(
            child: Column(
              children: [
                Obx(() => homeController.isLoading.value
                    ? _buildLoadingShimmer()
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: CustomScrollView(
                              physics: BouncingScrollPhysics(),
                              slivers: [
                                SliverToBoxAdapter(
                                  child: ProductList(
                                    pastoral:
                                        homeController.homeModel!.pastoral!,
                                    products:
                                        homeController.homeModel!.programacao!,
                                    cardHeight:
                                        MediaQuery.of(context).size.height /
                                            3.7,
                                    cardWidth:
                                        MediaQuery.of(context).size.width / 1.8,
                                    viewportFraction: 0.6,
                                    autoPlay: false,
                                    loop: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
              ],
            ),
          ));
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class Aniversariantes extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.isLoading.value
        ? _buildLoadingShimmer()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2D2D2A),
                  Color(0xFF1A1A18),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider.builder(
                itemCount: homeController.homeModel!.aniversariantes!.length,
                itemBuilder: (context, indice, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/aniversario.png',
                          width: 45,
                          height: 45,
                          color: Colors.black87,
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            homeController.homeModel!.aniversariantes![indice],
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 0.3,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ));
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class ScreenPixCopy extends StatelessWidget {
  const ScreenPixCopy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/pix.png"),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "PIX: $cnpj",
                  style: GoogleFonts.montserrat(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                FlutterClipboard.copy(cnpj).then((value) {
                  _showCopySuccess(context);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 16, color: Colors.grey[700]),
                    SizedBox(width: 4),
                    Text(
                      "Copiar",
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCopySuccess(BuildContext context) {
    showDialogAlert(
      context: context,
      title: 'Copiado',
      message: 'Chave PIX copiada com sucesso',
      actionButtonTitle: 'OK',
    );
  }
}
