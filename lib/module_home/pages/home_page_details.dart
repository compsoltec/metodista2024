import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:notification2/module_home/models/home_model.dart';

import '../components/details_components.dart';

class HomePageDetails extends StatelessWidget {
  final String image;
  final String pastoral;
  const HomePageDetails({
    Key? key,
    required this.image,
    required this.pastoral,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 80.0,
                  ),
                  DetailsComponents(
                    image: image,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 40.0, bottom: 130),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        color: Colors.black.withOpacity(1.0),
                        child: Text(
                          pastoral,
                          style: const TextStyle(
                              color: const Color(0xfefefefe),
                              fontWeight: FontWeight.w800,
                              fontFamily: "NunitoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
