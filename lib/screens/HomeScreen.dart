import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/responses/GetItemsOfMenuResponse.dart';
import 'package:barfly/responses/GetMenuOfInsiderResponse.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

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
            decoration: const BoxDecoration(color: APPCOLORS.backgroundColor),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        const Text(
                          APP_TEXT_CONSTANTS.HOME,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: 30,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 60),
                        EventsButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/upcoming-events");
                            },
                            widthofButton:
                                screenWidth < 350 ? 350 : screenWidth - 100,
                            heightofButton: 140,
                            borderRadius: 30,
                            fontWeight: FontWeight.w500,
                            eventType: "Upcoming\nEvents",
                            imagePath: "upcomingEventsLogo.png"),
                        const SizedBox(
                          height: 20,
                        ),
                        EventsButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/past-events");
                            },
                            widthofButton:
                                screenWidth < 350 ? 350 : screenWidth - 100,
                            heightofButton: 140,
                            borderRadius: 30,
                            fontWeight: FontWeight.w500,
                            eventType: "Past\nEvents",
                            imagePath: "upcomingEventsLogo.png"),
                        const SizedBox(
                          height: 20,
                        ),
                        EventsButton(
                            onPressed: () {},
                            widthofButton:
                                screenWidth < 350 ? 350 : screenWidth - 100,
                            heightofButton: 140,
                            borderRadius: 30,
                            fontWeight: FontWeight.w500,
                            eventType: "Feedback",
                            imagePath: "feedbackLogo.png"),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}
