import 'package:barfly/appConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final Gradient gradient;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.heightofButton = 70,
    this.widthofButton = 240,
    this.fontSize = 28,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.buttonBackgroundColor = AppColors.buttonColor,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF18d9ad), Color(0xFF3ab1a6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ), // Default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthofButton,
      height: heightofButton,
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius))),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: horizontalPadding),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
