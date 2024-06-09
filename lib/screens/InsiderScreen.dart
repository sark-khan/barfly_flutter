import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/responses/GetInsiderResponse.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class InsiderScreen extends StatefulWidget {
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
          // While the future is being resolved, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If the future resolves with an error, show an error message.
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          ReturnObj<List<GetInsiderData>> response = snapshot.data;

          print("${response.data!.length}>>>>>>>>>>>>>>>>>>>>>>>>");
          if (response.data == null || response.data!.isEmpty) {
            return PopScope(
                canPop: true,
                child: Stack(children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    decoration:
                        const BoxDecoration(color: APPCOLORS.backgroundColor),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text("Connect with \nyour guests!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 30,
                                      decoration: TextDecoration.none)),
                            ),
                            SizedBox(
                              height: screenHeight / 5,
                            ),
                            CustomButton(
                              text: "Add\nInsider\n+",
                              onPressed: () => {
                                Navigator.pushNamed(
                                    context, "/insider-selector-screen")
                              },
                              heightofButton: 160,
                              widthofButton: 180,
                              fontWeight: FontWeight.w600,
                              borderRadius: 20,
                              fontSize: 30,
                              horizontalPadding: 5,
                            ),
                            SizedBox(
                              height: screenHeight / 4,
                            )
                          ]),
                    ),
                  ),
                  // Center(
                  //   child: CustomButton(
                  //     text: "Add\nInsider\n+",
                  //     onPressed: () => {
                  //       Navigator.pushNamed(context, "/insider-selector-screen")
                  //     },
                  //     heightofButton: 160,
                  //     widthofButton: 180,
                  //     fontWeight: FontWeight.w600,
                  //     borderRadius: 20,
                  //     fontSize: 30,
                  //     horizontalPadding: 5,
                  //   ),
                  // ),
                ]));
          } else {
            return Scaffold(
              body: SingleChildScrollView(
                child: PopScope(
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
                              const SizedBox(
                                height: 80,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  "Connect with \nyour guests!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 30,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ...response.data!.expand((datum) {
                                return [
                                  CustomButtonStroked(
                                    text: datum.insiderName,
                                    onPressed: () {
                                      // Handle button press
                                    },
                                    heightofButton: 80,
                                    widthofButton: screenWidth - 100,
                                    fontWeight: FontWeight.w600,
                                    borderRadius: 20,
                                    fontSize: 20,
                                    horizontalPadding: 5,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ];
                              }).toList(),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                text: "Add\nInsider\n+",
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/insider-selector-screen",
                                      arguments: {
                                        "insiderCount":
                                            response.data!.length + 1
                                      });
                                },
                                heightofButton: 160,
                                widthofButton: 180,
                                fontWeight: FontWeight.w600,
                                borderRadius: 20,
                                fontSize: 30,
                                horizontalPadding: 5,
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          // If the future resolves without data, show a default message.
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
