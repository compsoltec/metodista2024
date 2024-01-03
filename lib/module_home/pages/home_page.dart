import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_home/pages/categoty_list.dart';
import 'package:notification2/module_services/module_services.dart';
import '../module_home.dart';
import 'package:notification2/module_devocional/module_devocional.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

HomeController homeController = Get.put(HomeController());
DevocionalController devocionalController = Get.put(DevocionalController());

List<String> timelines = ['Metodista Jardim Belvedere', '', ''];
String selectedTimeline = 'Weekly featured';

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  late TabController tabController;
  late TabController bottomTabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
        height: kToolbarHeight + MediaQuery.of(context).padding.top,
        child: const Center(
          child: Text(
            'Metodista Jardim Belvedere',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ));

    Widget topHeader = Padding(
      padding: const EdgeInsets.only(left: 20, right: 16.0),
      child: InkWell(
          onTap: () {
            setState(() {
              selectedTimeline = timelines[0];
            });
          },
          child: Text(
            '',
            style: TextStyle(
                fontSize: timelines[0] == selectedTimeline ? 20 : 14,
                color: Colors.white),
          )),
    );

    Widget tabBar = Padding(
      padding: EdgeInsets.only(top: 20),
      child: TabBar(
        tabs: [
          Tab(text: 'Devocional'),
          Tab(text: 'Sports'),
          Tab(text: 'Headsets'),
          Tab(text: 'Wireless'),
          Tab(text: 'Bluetooth'),
        ],
        labelStyle: const TextStyle(fontSize: 16.0),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14.0,
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white,
        isScrollable: true,
        indicatorColor: Colors.black,
        controller: tabController,
      ),
    );

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/novotemplo.jpeg',
                ),
                fit: BoxFit.cover,
                opacity: 0.3)),
        //painter: MainBackground(),
        child: SizedBox(
            child: Obx(() => homeController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TabBarView(
                    controller: bottomTabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                        SafeArea(
                          child: NestedScrollView(
                            headerSliverBuilder: (BuildContext context,
                                bool innerBoxIsScrolled) {
                              // These are the slivers that show up in the "outer" scroll view.
                              return <Widget>[
                                SliverToBoxAdapter(
                                  child: appBar,
                                ),
                                SliverToBoxAdapter(
                                  child: topHeader,
                                ),
                                SliverToBoxAdapter(
                                  child: ProductList(
                                    products:
                                        homeController.homeModel!.fotosCultos!,
                                    cardHeight:
                                        MediaQuery.of(context).size.height /
                                            3.7,
                                    cardWidth:
                                        MediaQuery.of(context).size.width / 1.8,
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: ProductList(
                                    products:
                                        homeController.homeModel!.campanhas!,
                                    cardHeight:
                                        MediaQuery.of(context).size.height /
                                            3.7,
                                    cardWidth:
                                        MediaQuery.of(context).size.width / 1.8,
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: tabBar,
                                )
                              ];
                            },
                            body: TabView(
                              tabController: tabController,
                            ),
                          ),
                        ),
                        CategoryListPage(),
                        Container(),
                        Container(),
                      ]))),
      ),
    );
  }
}
