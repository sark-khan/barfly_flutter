import 'package:barfly/appConstants.dart';
import 'package:barfly/components/CustomText.dart';
import 'package:barfly/controller/counter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class EventCreationScreen extends StatefulWidget {
  const EventCreationScreen({
    super.key,
  });

  @override
  State createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  late final CounterListController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(CounterListController());
  }

  DateTime? _selectedDate;
  TimeOfDay? _selectedFromTime;
  TimeOfDay? _selectedToTime;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController fromTimeController = TextEditingController();
  final TextEditingController toTimeController = TextEditingController();
  final TextEditingController eventName = TextEditingController();
  String? selectedAge;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = _selectedDate!.toLocal().toString().split(' ')[0];

        print(
            "ssssssssssssssssssssssssssssssssss ${dateController.text}"); // Format the date as needed
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFrom
          ? (_selectedFromTime ?? TimeOfDay.now())
          : (_selectedToTime ?? TimeOfDay.now()),
    );
    if (picked != null &&
        (isFrom ? picked != _selectedFromTime : picked != _selectedToTime)) {
      setState(() {
        if (isFrom) {
          _selectedFromTime = picked;
          fromTimeController.text = _selectedFromTime!.format(context);
          // Format the time as needed
        } else {
          _selectedToTime = picked;
          toTimeController.text =
              _selectedToTime!.format(context); // Format the time as needed
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PopScope(
        canPop: true,
        child: Stack(children: [
          Container(
              width: screenWidth,
              height: screenHeight,
              decoration: const BoxDecoration(color: APPCOLORS.backgroundColor),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    CustomText(
                      text: "Events",
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 10.0, horizontal: 40.0),
                    //   child: TextField(
                    //     controller: locationName,
                    //     style: TextStyle(color: Colors.white),
                    //     decoration: InputDecoration(
                    //       filled: true,
                    //       fillColor: Color(0xFF4f5273),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(22)),
                    //       hintText: 'Location Name',
                    //       hintStyle: TextStyle(
                    //         color: Colors.white54,
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 23,
                    //         decoration: TextDecoration.none,
                    //       ),
                    //       contentPadding: EdgeInsets.symmetric(
                    //           horizontal: 20.0, vertical: 10.0),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      child: TextField(
                        controller: eventName,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22)),
                          hintText: 'Event Name',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                            decoration: TextDecoration.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      child: TextField(
                        controller: dateController,
                        style: TextStyle(color: Colors.white),
                        readOnly: true, // This makes the TextField read-only
                        onTap: () =>
                            _selectDate(context), // Open date picker on tap
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22)),
                          hintText: 'Date',
                          hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                            decoration: TextDecoration.none,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today,
                                color: Colors.white),
                            onPressed: () => _selectDate(
                                context), // Open date picker on icon press
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      child: TextField(
                        controller: fromTimeController,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w400,
                          fontSize: 23,
                          decoration: TextDecoration.none,
                        ),
                        readOnly: true, // This makes the TextField read-only
                        onTap: () => _selectTime(
                            context, true), // Open time picker on tap
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22)),
                          hintText: 'From (xx.xx)',
                          hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                            decoration: TextDecoration.none,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.access_time,
                                color: Colors.white),
                            onPressed: () => _selectTime(context,
                                true), // Open time picker on icon press
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      child: TextField(
                        controller: toTimeController,
                        style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w400,
                          fontSize: 23,
                          decoration: TextDecoration.none,
                        ),
                        readOnly: true, // This makes the TextField read-only
                        onTap: () => _selectTime(
                            context, false), // Open time picker on tap
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22)),
                          hintText: 'To (xx.xx)',
                          hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                            decoration: TextDecoration.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time, color: Colors.white),
                            onPressed: () => _selectTime(context,
                                false), // Open time picker on icon press
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.counterList.isNotEmpty) {
                        return Column(
                          children: controller.counterList.map((data) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20.0, left: 40, right: 40),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: const Color(0x727E83A3),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(data.counterName,
                                          style: const TextStyle(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 23,
                                            decoration: TextDecoration.none,
                                          )),
                                    ),
                                    FlutterSwitch(
                                      onToggle: (val) => {
                                        controller.counterSelected[data.id] =
                                            val
                                      },
                                      inactiveColor: Colors.white,
                                      activeColor: Color(0xFF08F748),
                                      width: 56,
                                      height: 22,
                                      toggleSize: 22,
                                      padding: 0,
                                      borderRadius: 16,
                                      // value: true,
                                      value:
                                          controller.counterSelected[data.id]!,
                                      toggleColor: Color(0xFF292C4C),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color(0x737E83A3),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: DropdownButton<String>(
                        // Added space between text and icon using a SizedBox
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                                width:
                                    8), // Adjust the width to your preference
                            Image.asset(
                              'dropDown.png', // Path to your custom image
                              width: 24,
                              height: 24,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        hint: const Text(
                          "Age Limit",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                          ),
                        ),
                        value: selectedAge,
                        iconSize: 24,
                        dropdownColor: Color(0xFF3d3f57),
                        underline: const SizedBox(),
                        style: const TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w400,
                          fontSize: 23,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAge = newValue!;
                          });
                        },
                        items:
                            List.generate(60, (index) => (index + 1).toString())
                                .map((age) {
                          return DropdownMenuItem<String>(
                            value: age,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 2),
                              child: Text(age),
                            ),
                          );
                        }).toList()
                              ..add(
                                const DropdownMenuItem<String>(
                                  value: 'No Limit',
                                  child: Text('No Limit'),
                                ),
                              ),
                      ),
                    ),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 40.0),
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            elevation:
                                0, // Set elevation to 0 to avoid shadow blur
                            backgroundColor:
                                controller.isRepetitiveSubmitted.value == true
                                    ? Color(0xFF55C166)
                                    : Color(0x737E83A3),
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () => {
                              Get.toNamed("/add-repetitive-day-screen",
                                  arguments: {
                                    "controller": controller,
                                    "date": dateController.text
                                  })
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 30),
                              child: const Text(
                                "Serientyp",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 23,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () => {
                        if (controller.isCounterSelected())
                          {}
                        else
                          {
                            Fluttertoast.showToast(
                                msg:
                                    "Please select atleast one counter to create event")
                          }
                      },
                      child: Container(
                        width: 193,
                        height: 57,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(22)),
                        child: const Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Activate",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w400,
                              fontSize: 23,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
