import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/responses/GetEventMonthlyDetailsResponse.dart';
import 'package:flutter/material.dart';

class PastEventMonthlyDetailsScreen extends StatefulWidget {
  final String year;
  final String month;
  const PastEventMonthlyDetailsScreen({
    required this.year,
    required this.month,
    super.key,
  });

  @override
  State createState() => _PastEventMonthlyDetailsScreenState();
}

class _PastEventMonthlyDetailsScreenState
    extends State<PastEventMonthlyDetailsScreen> {
  late Future<dynamic> futureData;
  @override
  void initState() {
    super.initState();
    futureData = apis().getEventsMonthlyDetails(widget.year, widget.month);
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
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // If the future resolves with an error, show an error message.
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    ReturnObj<List<MonthlyEventDetail>> response =
                        snapshot.data!;
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
                                const SizedBox(height: 100),
                                Text(
                                  monthMap[int.tryParse(widget.month)]!,
                                  style: const TextStyle(
                                    fontFamily: "Helvetica",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  widget.year,
                                  style: const TextStyle(
                                    fontFamily: "Helvetica",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                ...response.data!.expand((data) {
                                  return [
                                    PastEventsMonthlyDetails(
                                      onPressed: () => {},
                                      eventName: data.name,
                                      date: data.eventDate
                                          .toString()
                                          .split(" ")[0],
                                      totalAmount: data.totalAmount.toString(),
                                      totalOrders: data.totalOrders.toString(),
                                      heightofButton: 90,
                                      borderRadius: 30,
                                      fontSize: 45,
                                      widthofButton: screenWidth < 320
                                          ? 320
                                          : screenWidth - 50,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ];
                                })
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
