import 'package:barfly/appConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigator extends StatelessWidget {
  final String text;
  // final String currentTab;
  final double fontSize;
  final String imagePath;
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
  final bool isLoading;
  final bool useSvg;

  const BottomNavigator({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.imagePath,
    // required this.currentTab,
    this.useSvg = false,
    this.isLoading = true,
    this.heightofButton = 70,
    this.widthofButton = 240,
    this.fontSize = 28,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.buttonBackgroundColor = APPCOLORS.backgroundColor,
    this.gradient = const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xFF623E87), // Dark Blue
        Color(0xFF473F88), // Blue/Purple
      ],
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF34396e),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, "/live-orders")},
                child: Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 5),
                  width: 18,
                  height: 18,
                  child: SvgPicture.asset(
                    "Circle_Settings.svg",
                    color: Colors.white54,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, "/home-screen")},
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "Home.svg",
                    color: Colors.white54,
                    width: 29,
                    height: 29,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    {Navigator.pushNamed(context, "/account-details-screen")},
                child: Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 5),
                  child: SvgPicture.asset(
                    "Settings.svg",
                    color: Colors.white54,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
