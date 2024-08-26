import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/BottomNavigator.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/components/CustomText.dart';
import 'package:barfly/responses/GetCounterResponse.dart';
import 'package:flutter/material.dart';

class InsiderScreen extends StatefulWidget {
  bool isAdding = false;
  @override
  State createState() => _InsiderScreenState();
}

class _InsiderScreenState extends State<InsiderScreen> {
  late Future<dynamic> futureData;
  @override
  void initState() {
    super.initState();
    futureData = apis().getInsiderList();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: futureData,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          ReturnObj<List<Counter>> response = snapshot.data;
          if (response.data == null || response.data!.isEmpty) {
            return PopScope(
              canPop: true,
              child: Stack(children: [
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  decoration:
                      const BoxDecoration(color: APPCOLORS.backgroundColor),
                  child: Container(
                    height: screenHeight - 200,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 80),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: CustomText(
                                text: "Connect with \nyour guests!",
                                fontWeight: FontWeight.w100,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: screenHeight / 5),
                            CustomStrokedButton(
                              isAdding: false,
                              onPressed: () {},
                              borderRadius: 20,
                              fontSize: 80,
                              backgroundColor: const Color(0xFF292c4c),
                            ),
                            SizedBox(height: screenHeight / 4),
                          ]),
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return Scaffold(
              body: PopScope(
                canPop: true,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      height: screenHeight,
                      decoration: const BoxDecoration(
                        color: APPCOLORS.backgroundColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 80),
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: const Center(
                                child: CustomText(
                                  text: "Connect with your guests!",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 30,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Wrap(
                              spacing: screenWidth < 768
                                  ? screenWidth
                                  : 20, // Add space between each button
                              runSpacing: 20, // Add space between rows
                              alignment:
                                  WrapAlignment.center, // Center the items
                              children: response.data!.expand((datum) {
                                return [
                                  InsiderScreenButton(
                                    text: datum.counterName,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        "/menu-screen",
                                        arguments: {
                                          "insiderId": datum.id,
                                          "counterName": datum.counterName,
                                        },
                                      );
                                    },
                                    heightofButton: 64,
                                    widthofButton: 152,
                                    maxWidth: screenWidth * 0.80,
                                    fontWeight: FontWeight.w500,
                                    borderRadius: 22,
                                    fontSize: 35,
                                  ),
                                ];
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            Visibility(
                              visible: !widget.isAdding,
                              child: CustomStrokedButton(
                                isAdding: false,
                                onPressed: () {
                                  setState(() {
                                    widget.isAdding = true;
                                  });
                                },
                                borderRadius: 20,
                                fontSize: 70,
                                backgroundColor: const Color(0xFF292c4c),
                              ),
                            ),
                            Visibility(
                              visible: widget.isAdding,
                              child: Container(
                                  width: 264,
                                  height: 296,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                      color: APPCOLORS.backgroundColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 32),
                                      AddCounterButton(
                                        heightofButton: 80,
                                        widthofButton: 200,
                                        borderRadius: 20,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        text: "Counter",
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              "/counter-settings-screen",
                                              arguments: {
                                                "isFirstTime": true,
                                                "counterId": ""
                                              });
                                        },
                                      ),
                                      const SizedBox(height: 6),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: CustomText(
                                          text:
                                              "A Counter is your digital menu for your guests. They can view it on countr app",
                                          fontSize: 10,
                                          softWrap: true,
                                          fontWeight: FontWeight.w300,
                                          maxLines: null,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 26),
                                      AddCounterButton(
                                        heightofButton: 80,
                                        widthofButton: 200,
                                        borderRadius: 20,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        text: "Survey",
                                        onPressed: () {},
                                      ),
                                      const SizedBox(height: 6),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: CustomText(
                                          text:
                                              "Ask your guests whatever you need to know.",
                                          fontSize: 10,
                                          softWrap: true,
                                          fontWeight: FontWeight.w300,
                                          maxLines: null,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: APPCOLORS
                            .backgroundColor, // Set the desired background color
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 30,
                        ),
                        child: BottomNavigator(
                          onPressed: () => {},
                          text: "dsds",
                          imagePath: "sdsdsd",
                          widthofButton: 200,
                          heightofButton: 56,
                          borderRadius: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
