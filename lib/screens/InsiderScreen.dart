import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class InsiderScreen extends StatefulWidget {
  @override
  State createState() => _InsiderScreenState();
}

class _InsiderScreenState extends State<InsiderScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
        canPop: true,
        child: Stack(children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(color: AppColors.backgroundColor),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("Connect with \n your guests!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: 30,
                            decoration: TextDecoration.none)),
                  ),
                ]),
          ),
          Center(
            child: CustomButton(
              text: "Add\nInsider\n+",
              onPressed: () => {},
              heightofButton: 160,
              widthofButton: 180,
              fontWeight: FontWeight.w600,
              borderRadius: 20,
              fontSize: 30,
              horizontalPadding: 5,
            ),
          ),
        ]));
  }
}
