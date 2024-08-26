import 'package:flutter/material.dart';

class AddItemsInputField extends StatelessWidget {
  final double widthOfField;
  final double heightofField;
  final TextEditingController controller;
  final double borderRadius;
  final double fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final String hintText;
  const AddItemsInputField({
    super.key,
    required this.widthOfField,
    required this.heightofField,
    required this.controller,
    required this.fontSize,
    this.fontWeight,
    this.height,
    this.hintText = "",
    this.borderRadius = 18,
  });
  Widget build(BuildContext context) {
    return Container(
      width: widthOfField,
      height: heightofField,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.white54,
              fontSize: fontSize,
              fontFamily: "Helvetica",
              height: height,
              fontWeight: fontWeight),
          contentPadding: const EdgeInsets.only(
              left: 15.0, right: 12, top: 10.0, bottom: 0),
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          height: height,
          fontWeight: fontWeight,
          fontFamily: "Helvetica",
        ),
      ),
    );
  }
}
