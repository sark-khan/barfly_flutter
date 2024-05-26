// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';

class EntryScreen extends StatefulWidget {
  @override
  State createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
        canPop: true,
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
                      height: 40.0,
                    ),
                    Image.asset(
                      "barfly.png",
                      width: 200,
                      height: 300,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 220,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushNamed(
                              context, "/bussiness-details-screen")
                        },
                        style: ElevatedButton.styleFrom(
                            // shape: CircleBorder(eccentricity: 0.),
                            backgroundColor: Color(0xFF2ac4aa)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: Text(
                            "Sign Up!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
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
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                            // shape: CircleBorder(eccentricity: 0.),
                            side: const BorderSide(
                                strokeAlign: 2, color: Colors.white),
                            backgroundColor: Color(0xFF292c4c)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: Text(
                            "Log In!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
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
