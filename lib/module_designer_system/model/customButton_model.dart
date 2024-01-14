import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtomModel {
  String? image;
   VoidCallback? page;
  String? text;
  CustomButtomModel({
    required this.image,
    required this.page,
    required this.text,
  });
}
