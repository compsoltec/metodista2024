import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:notification2/module_home/widget/expanded_card_page.dart';
import 'package:notification2/module_home/widget/expanded_cart.dart';


class SlidingCardApp extends StatelessWidget {
  const SlidingCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.pinkAccent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _page() => const Center(
        child: Text(
          "Expandable Card",
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ExpandableCardPage(
        page: _page(),
        expandableCard: ExpandableCard(
          backgroundColor: Colors.pinkAccent,
          padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
          maxHeight: MediaQuery.of(context).size.height - 100,
          minHeight: 150,
          hasRoundedCorners: true,
          hasShadow: true,
          children: <Widget>[
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 65,
                    color: Colors.white,
                    child: const Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://s3.amazonaws.com/media.thecrimson.com/photos/2019/04/14/200610_1337381.jpeg",
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Old Town Road",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Lil Nas X",
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 180),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => 1,
                
                  child: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => 1,
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => 1,
                 
                  child: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 50,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}