import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/CustomText.dart';
import 'package:barfly/controller/counter_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddRepetitiveScreen extends StatefulWidget {
  final CounterListController controller;
  final String? date;
  const AddRepetitiveScreen({
    required this.controller,
    this.date,
    super.key,
  });

  @override
  State createState() => _AddRepetitiveScreenState();
}

class _AddRepetitiveScreenState extends State<AddRepetitiveScreen> {
  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;

  late TextEditingController fromDateController = TextEditingController();

  final TextEditingController toDateController = TextEditingController();
  String? selectedAge;
  @override
  void initState() {
    super.initState();
    fromDateController.text = widget.date!;
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedFromDate) {
      setState(() {
        _selectedFromDate = picked;
        String date = _selectedFromDate!.toLocal().toString().split(' ')[0];
        fromDateController.text = date;
        widget.controller.fromDate.value = date; // Format the date as needed
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedToDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedToDate) {
      setState(() {
        _selectedToDate = picked;
        String date = _selectedToDate!.toLocal().toString().split(' ')[0];
        toDateController.text = date;
        widget.controller.toDate.value = date;
        print(
            "ssssssssssssssssssssssssssssssssss ${toDateController.text}"); // Format the date as needed
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
                    const SizedBox(
                      height: 100,
                    ),
                    const CustomText(
                      text: "Serientyp",
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Obx(() {
                      if (widget.controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            color: Color(0x737E83A3),
                            borderRadius: BorderRadius.circular(22)),
                        child: Wrap(
                          spacing: 0,
                          runSpacing: 16,
                          children: List.generate(
                              widget.controller.repetitiveDays.length, (index) {
                            return SizedBox(
                              width: 154,
                              height: 27,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                    scale:
                                        1.5, // Adjust the scale to increase/decrease the size
                                    child: Checkbox(
                                      value: widget
                                          .controller.repetitiveDays[index],
                                      onChanged: (val) => widget.controller
                                          .updateRepetitive(index, val!),
                                      activeColor: Color(
                                          0x70FFFFFF), // Color of the checkbox border when selected
                                      checkColor: Colors
                                          .black, // Color of the checkmark inside the checkbox
                                      side: const BorderSide(
                                        color: Color(0x70FFFFFF),
                                      ), // Outer line color
                                    ),
                                  ),
                                  Text(
                                    widget.controller.daysMapping[index],
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    maxLines: null,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                      decoration: TextDecoration.none,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 24,
                    ),
                    Obx(() {
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            color: Color(0x737E83A3),
                            borderRadius: BorderRadius.circular(22)),
                        child: Wrap(
                          spacing: 0,
                          runSpacing: 16,
                          children: [
                            SizedBox(
                              width: 154,
                              height: 27,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale:
                                        1.5, // Adjust the scale to increase/decrease the size
                                    child: Checkbox(
                                      value: widget.controller.isWeekDays.value,
                                      onChanged: (val) => widget.controller
                                          .updateWeekDays(val!),
                                      activeColor: Color(
                                          0x70FFFFFF), // Color of the checkbox border when selected
                                      checkColor: Colors
                                          .black, // Color of the checkmark inside the checkbox
                                      side: const BorderSide(
                                        color: Color(0x70FFFFFF),
                                      ), // Outer line color
                                    ),
                                  ),
                                  const Text(
                                    "WorkDays",
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    maxLines: null,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                      decoration: TextDecoration.none,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 154,
                              height: 27,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale:
                                        1.5, // Adjust the scale to increase/decrease the size
                                    child: Checkbox(
                                      value: widget.controller.isWeekEnds.value,
                                      onChanged: (val) => widget.controller
                                          .updateWeekends(val!),
                                      activeColor: const Color(
                                          0x70FFFFFF), // Color of the checkbox border when selected
                                      checkColor: Colors
                                          .black, // Color of the checkmark inside the checkbox
                                      side: const BorderSide(
                                        color: Color(0x70FFFFFF),
                                      ), // Outer line color
                                    ),
                                  ),
                                  const Text(
                                    "WeekEnds",
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    maxLines: null,
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              height: 27,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale:
                                        1.5, // Adjust the scale to increase/decrease the size
                                    child: Checkbox(
                                      value:
                                          widget.controller.isWholeWeek.value,
                                      onChanged: (val) => widget.controller
                                          .updateWholeWeek(val!),
                                      activeColor: const Color(
                                          0x70FFFFFF), // Color of the checkbox border when selected
                                      checkColor: Colors
                                          .black, // Color of the checkmark inside the checkbox
                                      side: const BorderSide(
                                        color: Color(0x70FFFFFF),
                                      ), // Outer line color
                                    ),
                                  ),
                                  const Text(
                                    "Whole Week",
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    maxLines: null,
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      child: TextField(
                        controller: fromDateController,
                        style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w400,
                          fontSize: 23,
                          decoration: TextDecoration.none,
                        ),
                        readOnly: true, // This makes the TextField read-only
                        onTap: () =>
                            _selectFromDate(context), // Open date picker on tap
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22)),
                          hintText: 'From Date',
                          hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                            decoration: TextDecoration.none,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today,
                                color: Colors.white),
                            onPressed: () => _selectFromDate(
                                context), // Open date picker on icon press
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 14,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      child: TextField(
                        controller: toDateController,
                        style: TextStyle(color: Colors.white),
                        readOnly: true, // This makes the TextField read-only
                        onTap: () =>
                            _selectToDate(context), // Open date picker on tap
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22)),
                          hintText: 'To Date',
                          hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                            decoration: TextDecoration.none,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today,
                                color: Colors.white),
                            onPressed: () => _selectToDate(
                                context), // Open date picker on icon press
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 46,
                    ),
                    GestureDetector(
                      onTap: () {
                        ReturnObj isChanged = widget.controller.submitValue();
                        if (isChanged.status) {
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(msg: isChanged.message);
                        }
                      },
                      child: Container(
                        width: 136,
                        height: 56,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(11)),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text(
                            textAlign: TextAlign.center,
                            "DONE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
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
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1227, vertical: 50),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, "/home-screen");
              },
              child: Container(
                  width: 34, height: 32, child: Image.asset("back_button.png")),
            ),
          ),
        ]),
      ),
    );
  }
}
