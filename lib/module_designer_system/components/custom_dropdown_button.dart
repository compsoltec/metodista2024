import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../module_config/constants/colors_constants.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String?> items;
  final String dropdownValue;
  final Function(Object?)? onChanged;
  const CustomDropDownButton(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.dropdownValue});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: ColorsConstants().primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton(
              borderRadius: BorderRadius.circular(15),
              value: dropdownValue,
              items: items.map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value!),
                );
              }).toList(),
              onChanged: onChanged,
              icon: Icon(Icons.arrow_drop_down,
                  color: ColorsConstants().primaryColor),
              isExpanded: true, //make true to take width of parent widget
              underline: Container(), //empty line
              style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              dropdownColor: Colors.white,
              iconEnabledColor: Colors.white, //Icon color
            )));
  }
}
