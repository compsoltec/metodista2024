import 'package:flutter/material.dart';

import '../../app_properties.dart';

class DetailsComponents extends StatelessWidget {
  final String image;
  const DetailsComponents({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(-1, 0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              height: screenAwareSize(220, context),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0, top: 20),
                    child: Container(
                      child: Hero(
                        tag: image,
                        child: Image.network(
                          image,
                          fit: BoxFit.contain,
                          height: 230,
                          width: 230,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
