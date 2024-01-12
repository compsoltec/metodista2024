import 'package:flutter/material.dart';
import 'package:notification2/admin/admin.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final String titulo;
  final String data;
  final String image;
  final bool isNetwork;
  CategoryCard(
      {required this.titulo,
      required this.data,
      required this.image,
      required this.isNetwork});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 80,
                width: 150,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    this.titulo,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              isNetwork
                  ? Container(
                      height: 80,
                      width: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover),
                          gradient: RadialGradient(
                              colors: [
                                Color(0xff596678),
                                Color(0xff323a45),
                              ],
                              center: Alignment(0, 0),
                              radius: 0.8,
                              focal: Alignment(0, 0),
                              focalRadius: 0.1)),
                      padding: EdgeInsets.all(8.0),
                    )
                  : Container(
                      height: 80,
                      width: 90,
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/metodista-842fa.appspot.com/o/WhatsApp%20Image%202022-08-12%20at%2012.51.32.jpeg?alt=media&token=ab516b3a-c9dc-425d-8fd1-a5b74edd1fd7',
                        fit: BoxFit.cover,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
