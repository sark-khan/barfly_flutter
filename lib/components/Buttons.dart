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
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
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

// import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final VoidCallback onPressed;
  final Color textColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;

  const MenuButton({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController menuTextController = TextEditingController();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth < widthofButton
              ? constraints.maxWidth
              : widthofButton,
          height: heightofButton,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Stack(
              children: [
                // Gradient background
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 42, 240, 194),
                          Color(0xFF3ab0a6)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                // ElevatedButton with transparent background
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: verticalPadding, horizontal: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: heightofButton - 10,
                            decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: TextField(
                                controller: menuTextController,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  hintText: 'Enter text...',
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: fontWeight,
                                ),
                                textAlign: TextAlign.left,
                                maxLines: null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Add spacing between the input field and icon
                        Container(
                          width: constraints.maxWidth / 6,
                          height: heightofButton - 10,
                          decoration: BoxDecoration(
                            border: Border.all(color: textColor),
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                            ),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                    backgroundColor: Colors.transparent),
                                children: [
                                  TextSpan(
                                    text: 'Add\n',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                  TextSpan(
                                    text: 'Icon\n',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "+",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomButtonStroked extends StatelessWidget {
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
  final Color backgroundColor;
  const CustomButtonStroked({
    Key? key,
    required this.text,
    required this.onPressed,
    this.heightofButton = 70,
    this.widthofButton = 240,
    this.fontSize = 24,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.backgroundColor = const Color(0xFF292c4c),
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF18d9ad), Color(0xFF3ab1a6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ), // Default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightofButton,
      width: widthofButton,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            side: const BorderSide(strokeAlign: 2, color: Colors.white),
            backgroundColor: backgroundColor),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
              // backgroundColor: Color(0xFF2ac4aa)
            ),
          ),
        ),
      ),
    );
  }
}
