import 'package:flutter/material.dart';
import 'package:notification2/admin/admin.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final String titulo;
  final String data;
  CategoryCard({required this.titulo, required this.data});

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
              Container(
                height: 80,
                width: 90,
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: [
                      Color(0xffFCE183),
                      Color(0xffF68D7F),
                    ],
                        center: Alignment(0, 0),
                        radius: 0.8,
                        focal: Alignment(0, 0),
                        focalRadius: 0.1)),
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset('assets/headphone_8.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
