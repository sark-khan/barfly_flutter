import 'package:flutter/material.dart';

class AddItemsDropdownField extends StatelessWidget {
  final double widthOfField;
  final double heightofField;
  final bool isDrinks;
  final TextEditingController controller;
  final double borderRadius;
  final double fontSize;
  final String hintText;
  final FontWeight? fontWeight;
  final double? height;

  const AddItemsDropdownField({
    super.key,
    required this.widthOfField,
    required this.heightofField,
    required this.controller,
    required this.fontSize,
    required this.isDrinks,
    this.fontWeight,
    this.height,
    this.hintText = "",
    this.borderRadius = 18,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = hintText;
    List<String> items =
        isDrinks == true ? ['ml', 'cl', 'dl', 'l'] : ["g", "kg"];
    return Container(
      width: widthOfField,
      height: heightofField,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15.0, right: 12, top: 10.0, bottom: 0),
        ),
        hint: Text(
          hintText,
          style: TextStyle(
              color: Colors.white54,
              fontSize: fontSize,
              fontFamily: "Helvetica",
              height: height,
              fontWeight: fontWeight),
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          height: height,
          fontWeight: fontWeight,
          fontFamily: "Helvetica",
        ),
        dropdownColor: Colors.grey[800],
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.text = newValue ?? '';
        },
      ),
    );
  }
}
