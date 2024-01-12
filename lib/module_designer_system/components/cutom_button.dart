import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool showProgress;
  final Color color;
  final Color textColor;
  const CustomButton(
      {super.key,
      required this.textColor,
      required this.text,
      required this.onPressed,
      required this.color,
      this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1.0, color: color)),
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Text(
                text,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              )),
      ),
    );
  }
}
