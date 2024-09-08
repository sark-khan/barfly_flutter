import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/commonFunction.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/responses/GetUpcomingEventsResponse.dart';

import 'package:flutter/material.dart';

class UpcomingEventsScreen extends StatefulWidget {
  UpcomingEventsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _UpcomingEventsScreenState();
}

class _UpcomingEventsScreenState extends State<UpcomingEventsScreen> {
  late Future<dynamic> futureData;
  @override
  void initState() {
    super.initState();
    futureData = apis().GetUpcomingEventsApi();
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
                    ReturnObj<List<UpcomingEvent>> response = snapshot.data!;
                    return Align(
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
                                const SizedBox(height: 80),
                                const Text(
                                  APP_TEXT_CONSTANTS.UPCOMING_EVENTS,
                                  style: TextStyle(
                                    fontFamily: "Helvetica",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                ...response.data!.expand((data) {
                                  return [
                                    UpcomingEvents(
                                      onPressed: () => {},
                                      eventName: data.eventName,
                                      date: formatTimestamp(
                                          data.startingDate.toString()),
                                      timeRange:
                                          "${formatTime(data.from.toString())}-${formatTime(data.to.toString())}",
                                      heightofButton: 150,
                                      borderRadius: 25,
                                      widthofButton: screenWidth < 320
                                          ? 320
                                          : screenWidth - 50,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ];
                                }),
                                CustomStrokedButton(
                                  isAdding: false,
                                  fontSize: 50,
                                  borderRadius: 20,
                                  onPressed: () => {
                                    Navigator.pushNamed(
                                        context, "/event-creation")
                                  },
                                  // widthofButton: 80,
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                        child: Text('No Past Events available'));
                  }
                }))
      ]),
    );
  }
}
