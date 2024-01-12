import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? maxLength;
  final double? height;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.labelText,
      required this.validator,
      required this.obscureText,
      required this.controller,
      this.maxLength,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        maxLines: maxLength,
        decoration: InputDecoration(
            labelText: labelText,
            // Set border for enabled state (default)
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.5, color: Color.fromRGBO(28, 28, 47, 1.0)),
              borderRadius: BorderRadius.circular(15),
            ),
            // Set border for focused state
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.5, color: Color.fromRGBO(28, 28, 47, 1.0)),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}
