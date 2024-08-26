import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;
  final double? height;
  const CustomText(
      {super.key,
      required this.text,
      this.fontSize = 14.0,
      this.color = Colors.white,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.height = 1.15,
      this.softWrap = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontWeight: fontWeight,
        fontFamily: "Helvetica",
        height: height,
        color: color,
        fontSize: fontSize,
        decoration: TextDecoration.none,
      ),
    );
  }
}
