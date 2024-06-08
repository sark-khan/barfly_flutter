// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';

class BussinessDetailsScreen extends StatefulWidget {
  @override
  State createState() => _BussinessDetailsScreenState();
}

class _BussinessDetailsScreenState extends State<BussinessDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
        canPop: false,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(color: Color(0xFF292c4c)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'What kind of a \n',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                              TextSpan(
                                text: 'business',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' are you?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 240,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushNamed(
                              context, "/account-details-screen",
                              arguments: {"productType": "Bar"})
                        },
                        style: ElevatedButton.styleFrom(
                            // shape: CircleBorder(eccentricity: 0.),
                            backgroundColor: Color(0xFF2ac4aa)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: Text(
                            "Bar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              // backgroundColor: Color(0xFF2ac4aa)
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 240,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushNamed(
                              context, "/account-details-screen",
                              arguments: {"productType": "Club"})
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2ac4aa)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: Text(
                            "Club",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              // backgroundColor: Color(0xFF2ac4aa)
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 240,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushNamed(
                              context, "/account-details-screen",
                              arguments: {"productType": "Foodtruck"})
                        },
                        style: ElevatedButton.styleFrom(
                            // shape: CircleBorder(eccentricity: 0.),
                            backgroundColor: Color(0xFF2ac4aa)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: Text(
                            "Foodtruck",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              // backgroundColor: Color(0xFF2ac4aa)
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 240,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushNamed(
                              context, "/account-details-screen",
                              arguments: {"productType": "Restaurant"})
                        },
                        style: ElevatedButton.styleFrom(
                            // shape: CircleBorder(eccentricity: 0.),
                            backgroundColor: Color(0xFF2ac4aa)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: Text(
                            "Restaurant",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              // backgroundColor: Color(0xFF2ac4aa)
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 240,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushNamed(
                              context, "/account-details-screen",
                              arguments: {"productType": "Business"})
                        },
                        style: ElevatedButton.styleFrom(
                            // shape: CircleBorder(eccentricity: 0.),
                            side: const BorderSide(
                                strokeAlign: 2, color: Colors.white),
                            backgroundColor: Color(0xFF292c4c)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: Text(
                            "Other",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              // backgroundColor: Color(0xFF2ac4aa)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
