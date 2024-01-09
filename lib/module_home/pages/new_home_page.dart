import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:notification2/module_home/pages/material_design.dart';
import 'package:notification2/module_home/pages/sliping_card.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = const Color(0xff1a73e8);
  final _unselectedColor = const Color(0xff5f6368);
  final _tabs = [
    Tab(text: 'Tab1'),
    Tab(text: 'Tab2'),
    Tab(text: 'Tab3'),
  ];

  final _iconTabs = [
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.search)),
    Tab(icon: Icon(Icons.settings)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome'),
                  Text(
                    'Metodista Jardim Belvedere',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  Text('Welcome'),
                ],
              ),
              CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            'text $i',
                            style: TextStyle(fontSize: 16.0),
                          ));
                    },
                  );
                }).toList(),
              ),
              SlidingCardApp()
            ],
          ),
        ));
  }
  
}
