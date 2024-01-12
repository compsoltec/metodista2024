import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? label;
  final Color? hintColor;
  final Color? prefixColor;
  final Color? borderColor;
  final Color? labelColor;
  final Icon? icon;
  final String? Function(String?)? validators;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextFormField(
      {super.key,
      this.borderColor,
      this.hintColor,
      this.hintText,
      this.label,
      this.prefixColor,
      this.icon,
      this.inputFormatters,
      this.validators,
      this.labelColor,
      this.textInputType,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TextFormField(
        validator: validators,
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: hintText,
          label: Text(
            label!,
            style: GoogleFonts.quicksand(fontSize: 14, color: labelColor),
          ),
          prefixIconColor: prefixColor,
          prefixIcon: icon,
          labelStyle: GoogleFonts.quicksand(fontSize: 14, color: Colors.white),
          hintStyle: GoogleFonts.quicksand(
            fontSize: 14,
            color: hintColor,
          ),
        ),
      ),
    );
  }
}
