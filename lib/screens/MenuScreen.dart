import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final double? insiderId;

  MenuScreen({
    required this.insiderId,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<dynamic> futureData;
  @override
  void initState() {
    super.initState();
    futureData = apis().getMenuList(widget.insiderId);
  }

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
              child: FutureBuilder(
                  future: futureData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While the future is being resolved, show a loading spinner.
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // If the future resolves with an error, show an error message.
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text("Menu",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 30,
                                      decoration: TextDecoration.none)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // MenuButton(
                            //   text: "Alcohol drinks",
                            //   onPressed: () => {},
                            //   heightofButton: 140,
                            //   widthofButton: 300,
                            //   borderRadius: 20,
                            // ),
                            Center(
                              child: CustomButtonStroked(
                                text: "+",
                                fontSize: 60,
                                verticalPadding: 2,
                                widthofButton: 100,
                                heightofButton: 100,
                                borderRadius: 30,
                                horizontalPadding: 2,
                                onPressed: () => {},
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  })),
        ],
      ),
    );
  }
}
