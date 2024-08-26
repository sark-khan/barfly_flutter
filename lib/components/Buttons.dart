import 'package:barfly/appConstants.dart';
import 'package:barfly/components/CustomText.dart';
import 'package:barfly/responses/GetOrderDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

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
      colors: [Color(0xFF42E695), Color(0xFF3BB2B8)],
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
  final TextEditingController menuNameController;
  final bool isEditable;
  final String staticText;
  final VoidCallback? onIconPressed;

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
    required this.menuNameController,
    this.isEditable = false,
    this.staticText = '',
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onPressed: isEditable ? null : onPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: verticalPadding, horizontal: 10),
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
                              child: isEditable
                                  ? TextField(
                                      controller: menuNameController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter text...',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
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
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          text,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: null,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Add spacing between the input field and icon
                        if (isEditable)
                          Container(
                            width: constraints.maxWidth / 6,
                            height: heightofButton - 10,
                            decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: ElevatedButton(
                              onPressed: onIconPressed ?? () => {},
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
                          )
                        else
                          Container(
                            width: constraints.maxWidth / 6,
                            height: heightofButton - 10,
                            decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Center(
                              child: Text(
                                'Icon',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: fontWeight,
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
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            side: const BorderSide(strokeAlign: 2, color: Colors.white),
            backgroundColor: backgroundColor),
        child: Container(
          // color: Colors.amber,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w300,

                // backgroundColor: Color(0xFF2ac4aa)
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String itemName;
  final String quantity;
  final String price;
  final double fontSize;
  final String type;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  // final Gradient gradient;
  const MenuItem({
    Key? key,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.onPressed,
    required this.type,
    this.heightofButton = 70,
    this.widthofButton = 240,
    this.fontSize = 28,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
    // this.gradient
    // Default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          itemName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          // maxLines: null,
                        ),
                        SizedBox(
                          height: 0.1,
                        ),
                        Text(
                          "${quantity} ${type == "Drink" ? "l" : "g"}",
                          // textHeightBehavior: TextHeightBehavior.,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: textColor,
                            // backgroundColor: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          // maxLines: null,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          "CHF $price",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          // maxLines: null,
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

class MenuImage extends StatelessWidget {
  final String imageId;
  // final String quantity;
  // final String price;
  // final double fontSize;
  // final String type;
  // final VoidCallback onPressed;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  // final Gradient gradient;
  const MenuImage({
    Key? key,
    required this.imageId,
    // required this.quantity,
    // required this.price,
    // required this.onPressed,
    // required this.type,
    this.heightofButton = 70,
    this.widthofButton = 50,
    // this.fontSize = 28,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
    // this.gradient
    // Default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Center(
                  child: Image.asset(
                    "Coca-Cola-2.png",
                    width: widthofButton - 5,
                    height: heightofButton - 5,
                  ),
                ),
                // ElevatedButton with transparent background
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddMenuItem extends StatelessWidget {
  final String imageId;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final TextEditingController description;
  final TextEditingController price;
  final TextEditingController quantity;
  final String productType;

  const AddMenuItem({
    Key? key,
    required this.imageId,
    required this.description,
    required this.price,
    required this.quantity,
    this.productType = "Drink",
    this.heightofButton = 70,
    this.widthofButton = 50,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.buttonBackgroundColor = const Color(0xFF3ab0a6),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100, // Fixed width for Add Image button
                        height: heightofButton *
                            0.35, // Adjust the height as needed
                        margin: EdgeInsets.only(
                            top: 30), // Move it down from the top
                        decoration: BoxDecoration(
                          border: Border.all(color: textColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: 'Add\n',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24.0),
                                  ),
                                  TextSpan(
                                    text: 'Image',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.zero,
                        width: constraints.maxWidth *
                            0.35, // Half of the available width
                        height: heightofButton *
                            0.11, // Adjust the height as needed
                        // margin: EdgeInsets.only(
                        //     top: 20), // Move it down from the top
                        decoration: BoxDecoration(
                          border: Border.all(color: textColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: TextField(
                            controller: description,
                            // textAlignVer tical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                                hintText: 'Description',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero),
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: fontWeight,
                            ),
                            textAlign: TextAlign.center,
                            // maxLines: null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.zero,
                            width: constraints.maxWidth *
                                0.18, // Half of the available width
                            height: heightofButton *
                                0.10, // Adjust the height as needed
                            // margin: EdgeInsets.only(
                            //     top: 20), // Move it down from the top
                            decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: TextField(
                                controller: quantity,
                                // textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5)),
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: fontWeight,
                                ),
                                textAlign: TextAlign.center,
                                // maxLines: null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${productType == "Drink" ? "ml" : "g"}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: fontWeight,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.zero,
                            width: constraints.maxWidth *
                                0.18, // Half of the available width
                            height: heightofButton *
                                0.10, // Adjust the height as needed
                            margin: EdgeInsets.only(
                                left: 5), // Move it down from the top
                            decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: TextField(
                                controller: price,
                                // textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5)),
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: fontWeight,
                                ),
                                textAlign: TextAlign.center,
                                // maxLines: null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "chf",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: fontWeight,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class EventsButton extends StatelessWidget {
  final String eventType;
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
  final double fontSize;

  const EventsButton({
    Key? key,
    required this.onPressed,
    required this.eventType,
    required this.imagePath,
    this.heightofButton = 70,
    this.widthofButton = 240,
    this.fontSize = 28,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.buttonBackgroundColor =
        const Color(0xFF3ab0a6), // Updated with a default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, top: 20, bottom: 20, left: 24),
                            child: Text(
                              eventType,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: fontWeight,
                                    decoration: TextDecoration.none,
                                    height: 1.1),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 5, right: 5),
                            child: Image.asset(
                              imagePath,
                              width: widthofButton / 3,
                              height: heightofButton / 2,
                            ),
                          ),
                        )
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

class PastEvents extends StatelessWidget {
  final String monthName;
  final String year;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;

  const PastEvents({
    Key? key,
    required this.onPressed,
    required this.monthName,
    required this.year,
    this.heightofButton = 70,
    this.widthofButton = 240,
    this.fontSize = 28,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.buttonBackgroundColor =
        const Color(0xFF3ab0a6), // Updated with a default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF555986), // hsl(246deg 36% 39%)
                          Color(0xFF4A5B94), // hsl(234deg 39% 40%)
                          Color(0xFF3E5CA3), // hsl(222deg 40% 41%)
                          Color(0xFF3366B2), // hsl(210deg 43% 43%)
                          Color(0xFF2A6DB3), // hsl(199deg 45% 44%)
                          Color(0xFF2182B6), // hsl(187deg 47% 45%)
                          Color(0xFF1A93B8), // hsl(175deg 50% 46%)
                        ],
                        stops: [
                          0.0,
                          0.17,
                          0.33,
                          0.5,
                          0.67,
                          0.83,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 50.0, top: 20, bottom: 20, right: 30),
                            child: Text(
                              year,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.none,
                                    height: 1.1),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 16, right: 30, left: 30),
                            child: Text(
                              monthName,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: fontWeight,
                                    decoration: TextDecoration.none,
                                    height: 1.1),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
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

class UpcomingEvents extends StatelessWidget {
  final String eventName;
  final String date;
  final String timeRange;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;

  const UpcomingEvents({
    Key? key,
    required this.onPressed,
    required this.eventName,
    required this.date,
    required this.timeRange,
    this.heightofButton = 70,
    this.widthofButton = 240,
    this.fontSize = 28,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.buttonBackgroundColor =
        const Color(0xFF3ab0a6), // Updated with a default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5, left: 20),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'XTRA ',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: textColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.none,
                                          height: 1.1),
                                    ),
                                  ),
                                  TextSpan(
                                    text: eventName,
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none,
                                          height: 1.1),
                                    ),
                                  ),
                                ])),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 0, right: 5, left: 20),
                            child: Text(
                              date,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                    height: 1.1),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 16, right: 5, left: 20),
                            child: Text(
                              timeRange,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                    height: 1.1),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
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

class InsiderScreenButton extends StatelessWidget {
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
  final double maxWidth;

  const InsiderScreenButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.maxWidth,
    this.heightofButton = 64,
    this.widthofButton = 152,
    this.fontSize = 24,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.backgroundColor = const Color(0xFF7e83a3),
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF18d9ad), Color(0xFF3ab1a6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ), // Default color
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: heightofButton,
          minWidth: widthofButton,
          maxWidth: maxWidth),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          backgroundColor: backgroundColor,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 3, left: 20, right: 20),
          child: CustomText(
            text: text,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
            maxLines: null,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}

class CustomStrokedButton extends StatelessWidget {
  final bool isAdding;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double borderRadius;
  final double fontSize;
  final Color backgroundColor;

  const CustomStrokedButton({
    Key? key,
    required this.isAdding,
    required this.onPressed,
    this.height = 64,
    this.width = 152,
    this.borderRadius = 8.0,
    this.fontSize = 24,
    this.backgroundColor = const Color(0xFF292c4c),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        child: Image.asset(
          isAdding ? "Save.png" : "addButton.png",
          width: width,
          height: height,
        ),
      ),
    );
  }
}

class AddCounterButton extends StatelessWidget {
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
  final Color backgroundColor;
  final Gradient gradient;

  const AddCounterButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.heightofButton = 64,
    this.widthofButton = 152,
    this.fontSize = 24,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.backgroundColor = const Color(0xFF7e83a3),
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF16DBAD), Color(0xFF3BAFA6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    // Default color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthofButton,
      height: heightofButton,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Container(
          // color: Colors.amber,
          width: widthofButton,
          height: heightofButton,
          // alignment: Alignment.center,
          margin: EdgeInsets.only(top: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Add ",
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
                maxLines: null,
                softWrap: true,

                // overflow: TextOverflow.visible,
              ),
              CustomText(
                text: text,
                textAlign: TextAlign.center,
                fontWeight: fontWeight,
                fontSize: fontSize,
                maxLines: null,
                softWrap: true,

                // overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButtonNew extends StatelessWidget {
  final String text;
  final double fontSize;
  final VoidCallback onPressed;
  void Function(int?) onIconPressed;
  final Color textColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final TextEditingController menuNameController;
  final bool isEditable;
  final String staticText;
  final Gradient gradient;
  final String iconIndex;
  final bool isIconSelected;

  MenuButtonNew({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.onIconPressed,
    required this.iconIndex,
    required this.isIconSelected,
    this.heightofButton = 70,
    this.widthofButton = 240,
    this.fontSize = 28,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    required this.menuNameController,
    this.isEditable = false,
    this.staticText = '',
    this.gradient = const LinearGradient(
      colors: [Color(0xFF16DBAD), Color(0xFF3BAFA6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthofButton,
      height: heightofButton,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        onPressed: isEditable ? () => {} : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0, // Set elevation to 0 to avoid shadow blur
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 25,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: isEditable
                        ? TextField(
                            controller: menuNameController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              hintText: 'Enter text...',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            style: TextStyle(
                                color: textColor,
                                fontSize: 22,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                            maxLines: null,
                            // autofocus: true, // Ensure focus to avoid blurring
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                text,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 22,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: null,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(
                  width: 1,
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: heightofButton,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: isEditable
                      ? ElevatedButton(
                          onPressed: () {
                            _showIconDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                          ),
                          child: isIconSelected
                              ? Center(
                                  child: SvgPicture.asset(
                                    'Choose_Icons_Drink$iconIndex.svg',
                                    fit: BoxFit.contain,
                                    color: Colors.white,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: "Add Icon",
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      maxLines: null,
                                      fontSize: 18,
                                      overflow: TextOverflow.visible,
                                    ),
                                    CustomText(
                                      fontWeight: FontWeight.w500,
                                      text: "+",
                                      fontSize: 30,
                                      overflow: TextOverflow.visible,
                                    )
                                  ],
                                ),
                        )
                      : Center(
                          child: SvgPicture.asset(
                            'Choose_Icons_Drink$iconIndex.svg',
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showIconDialog(BuildContext context) {
    List<String> iconList =
        List.generate(16, (index) => "Choose_Icons_Drink${index + 1}.svg");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: APPCOLORS.backgroundColor,
            elevation: 0,
            contentPadding: EdgeInsets.all(10),
            content: IntrinsicHeight(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: APPCOLORS.backgroundColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: CustomText(
                          text: "Choose Icon",
                          fontSize: 23,
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                      Wrap(
                        spacing: 0,
                        runSpacing: 10,
                        children: iconList.asMap().entries.map((entry) {
                          int index = entry.key;
                          String iconName = entry.value;
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Close the dialog
                              onIconPressed(index +
                                  1); // Call the callback with the index
                            },
                            child: SvgPicture.asset(
                              iconName,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class MenuItemRow extends StatelessWidget {
  final String itemName;
  final String quantity;
  final double fontSize;
  final String currency;
  final int price;
  final String imageUrl;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final Color backgroundColor;
  final Gradient gradient;

  const MenuItemRow({
    super.key,
    required this.itemName,
    required this.onPressed,
    required this.imageUrl,
    this.quantity = "",
    this.currency = "",
    this.price = -1,
    this.heightofButton = 64,
    this.widthofButton = 152,
    this.fontSize = 24,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.backgroundColor = const Color(0xFF7e83a3),
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF16DBAD), Color(0xFF3BAFA6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    // Default color
  });

  @override
  Widget build(BuildContext context) {
    print("$imageUrl imageURl");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 21,
            child: Container(
              height: heightofButton,
              // width: 40,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text: itemName,
                        softWrap: true,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text: quantity,
                        softWrap: true,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text: "$currency $price",
                        softWrap: true,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    // CustomText(
                    //   text: "$currency $price",
                    //   softWrap: true,
                    //   // maxLines: null,
                    //   fontSize: 20,
                    //   fontWeight: FontWeight.w400,
                    // )
                  ],
                ),
              ),
            )),
        Expanded(
            flex: 1,
            child: SizedBox(
              width: 1,
            )),
        Expanded(
          flex: 11,
          child: Container(
            // width: 200,
            height: heightofButton,
            decoration: BoxDecoration(
                color: const Color(0xFF2a3a55),
                borderRadius: BorderRadius.circular(borderRadius)),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Image.network(
                  imageUrl,
                  // width: widthofButton,
                  // height: heightofButton,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    print(error.toString());
                    print("erorr while loading image");
                    return Image.asset('cocaCola.png');
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: SizedBox(
              width: 1,
            )),
        Expanded(
            flex: 11,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                width: widthofButton,
                height: heightofButton,
                child: Image.asset(
                  "edit.png",
                  width: widthofButton,
                  height: heightofButton,
                ),
              ),
            ))
      ],
    );
  }
}

class ItemStockListRow extends StatelessWidget {
  final String itemName;
  final String quantity;
  final double fontSize;
  final String currency;
  final int price;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final Color backgroundColor;
  final Gradient gradient;

  const ItemStockListRow({
    super.key,
    required this.itemName,
    required this.onPressed,
    this.quantity = "",
    this.currency = "",
    this.price = -1,
    this.heightofButton = 64,
    this.widthofButton = 152,
    this.fontSize = 24,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.backgroundColor = const Color(0xFF7e83a3),
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF16DBAD), Color(0xFF3BAFA6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    // Default color
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 10,
            child: Container(
              height: heightofButton,
              // width: 40,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expanded(
                    //     flex: 15,
                    //     child: SizedBox(
                    //       width: 1,
                    //     )),
                    Expanded(
                      flex: 121,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CustomText(
                              text: itemName,
                              softWrap: true,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CustomText(
                              text: quantity,
                              softWrap: true,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CustomText(
                              text: "$currency $price",
                              softWrap: true,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // CustomText(
                          //   text: "$currency $price",
                          //   softWrap: true,
                          //   // maxLines: null,
                          //   fontSize: 20,
                          //   fontWeight: FontWeight.w400,
                          // )
                        ],
                      ),
                    ),
                    Expanded(flex: 26, child: SizedBox(width: 1)),
                    Expanded(
                      flex: 70,
                      child: Container(
                        // width: 200,
                        height: heightofButton,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Image.asset("cocaCola.png")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
            flex: 1,
            child: SizedBox(
              width: 1,
            )),
        Expanded(
          flex: 4,
          child: Container(
            // width: 200,
            height: heightofButton,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: Colors.white, width: 1)),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 0),
                  child: Text(
                    "...",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Helvetica"),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class AddQuantityRow extends StatelessWidget {
  final String counterName;
  final String quantity;
  final double fontSize;
  final String currency;
  final TextEditingController quantityController;
  final int price;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonBackgroundColor;
  final double heightofButton;
  final double widthofButton;
  final double borderRadius;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final Color backgroundColor;
  final Gradient gradient;

  const AddQuantityRow({
    super.key,
    required this.counterName,
    required this.quantityController,
    required this.onPressed,
    this.quantity = "20",
    this.currency = "",
    this.price = -1,
    this.heightofButton = 64,
    this.widthofButton = 152,
    this.fontSize = 24,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w300,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 25.0,
    this.backgroundColor = const Color(0xFF7e83a3),
    this.buttonBackgroundColor = APPCOLORS.buttonColor,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF16DBAD), Color(0xFF3BAFA6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    // Default color
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 8, //
            child: CustomText(
              text: counterName,
              textAlign: TextAlign.center,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            )),
        Expanded(
            flex: 1,
            child: SizedBox(
              width: 1,
            )),
        Expanded(
            flex: 5,
            child: Container(
              width: 89,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Center(
                child: TextField(
                  controller: quantityController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Helvetica",
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets
                        .zero, // Ensures the text is centered within the box
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class LiveOrderButton extends StatelessWidget {
  final List<Item> items; // List of items in the order
  final String tokenNumber; // The token number for the order
  final VoidCallback onPressed; // Function to execute on button press
  final double widthofButton; // Width of the button
  Gradient gradient; // Background gradient for the button
  final String status;

  LiveOrderButton({
    Key? key,
    required this.items,
    required this.tokenNumber,
    required this.onPressed,
    required this.status,
    this.widthofButton = 312,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF16DBAD), Color(0xFF3BAFA6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == "Waiting") {
    } else if (status == "InProgress") {
      gradient = const LinearGradient(
        colors: [Color(0xFFF4AA03), Color(0xFFF4AA03)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      gradient = const LinearGradient(
        colors: [Color(0xFF5B5BCE), Color(0xFF5B5BCE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        constraints:
            BoxConstraints(minWidth: widthofButton, maxWidth: widthofButton),
        decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(22),
            color: Colors.green),
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Token Number Display
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 2, bottom: 2, right: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD800FF),
                      borderRadius: BorderRadius.circular(11)),
                  child: Text(
                    tokenNumber,
                    maxLines: null,
                    softWrap: true,
                    style: const TextStyle(
                        fontFamily: "Helvetica",
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // Displaying multiple items within the order
                ...items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            "${item.quantity}x",
                            maxLines: null,
                            softWrap: true,
                            style: const TextStyle(
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 30,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            item.itemId.itemId.itemName,
                            maxLines: null,
                            softWrap: true,
                            style: const TextStyle(
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
