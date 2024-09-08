import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/controller/ongoing_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final OngoingEventController _controller =
      Get.put(OngoingEventController()); // Initialize GetX controller

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      child: Stack(
        children: [
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
                        const SizedBox(height: 40),
                        Obx(() {
                          if (_controller.isLoading.value) {
                            return CircularProgressIndicator(); // Show loading indicator when loading
                          }

                          if (_controller.ongoingEventDetails.isNotEmpty) {
                            return Column(
                              children: [
                                ..._controller.ongoingEventDetails.values.map(
                                    (eventDetail) => OngoingEventDetailsButton(
                                          widthofButton: screenWidth - 70,
                                          onPressed: () {
                                            // Handle button press
                                          },
                                          activeUsers: eventDetail.activeUsers
                                              .toString(),
                                          eventName: eventDetail.eventName,
                                          date:
                                              "${eventDetail.from.toString().split(" ")[1].split(".")[0]} - ${eventDetail.to.toString().split(" ")[1].split(".")[0]}",
                                          totalOrders: eventDetail.totalOrders
                                              .toString(),
                                        )),
                                const SizedBox(height: 20),
                                Container(
                                  width: screenWidth * 0.62,
                                  height: 3,
                                  color: Colors.white,
                                ) // Add your SizedBox here
                              ],
                            );
                          }
                          return SizedBox(
                            height: 1,
                          );
                        }),
                        SizedBox(
                          height: 20,
                        ),
                        EventsButton(
                          onPressed: () {
                            Get.toNamed(
                                "/upcoming-events"); // Use GetX for navigation
                          },
                          widthofButton: screenWidth - 70,
                          heightofButton: 140,
                          borderRadius: 30,
                          fontWeight: FontWeight.w500,
                          eventType: "Upcoming\nEvents",
                          imagePath: "upcomingEventsLogo.png",
                        ),
                        const SizedBox(height: 20),
                        EventsButton(
                          onPressed: () {
                            Get.toNamed(
                                "/past-events"); // Use GetX for navigation
                          },
                          widthofButton: screenWidth - 70,
                          heightofButton: 140,
                          borderRadius: 30,
                          fontWeight: FontWeight.w500,
                          eventType: "Past\nEvents",
                          imagePath: "upcomingEventsLogo.png",
                        ),
                        const SizedBox(height: 20),
                        EventsButton(
                          onPressed: () {},
                          widthofButton: screenWidth - 70,
                          heightofButton: 140,
                          borderRadius: 30,
                          fontWeight: FontWeight.w500,
                          eventType: "Feedback",
                          imagePath: "feedbackLogo.png",
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
