// import 'dart:convert';
// import 'dart:ui';

// import 'package:barfly/apis.dart';
// import 'package:barfly/appConstants.dart';
// import 'package:barfly/responses/GetCounterResponse.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class EventCreationScreen extends StatefulWidget {
//   final String? productType;
//   EventCreationScreen({this.productType, Key? key}) : super(key: key);
//   @override
//   State createState() => _EventCreationScreenState();
// }

// class _EventCreationScreenState extends State<EventCreationScreen> {
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedFromTime;
//   TimeOfDay? _selectedToTime;
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController fromTimeController = TextEditingController();
//   final TextEditingController toTimeController = TextEditingController();
//   final TextEditingController locationName = TextEditingController();
//   final TextEditingController eventName = TextEditingController();

//   List<Counter> insiders = [];
//   List<Counter> selectedInsiders = [];
//   Map<String, bool> selectedCheckboxes = {};

//   String? selectedAge;

//   @override
//   void initState() {
//     super.initState();
//     _fetchInsiders();
//   }

//   void _createEvent() async {
//     print("${selectedInsiders} sssssss ${selectedCheckboxes.entries}");
//     var eventJson = json.encode({
//       "locationName": locationName.text,
//       "eventName": eventName.text,
//       "date": dateController.text,
//       "from": fromTimeController.text,
//       "to": toTimeController.text,
//       "ownerId":
//           "6664799e869feb8e4668eb1d", // Example ownerId, replace with actual ID
//       "insiders": selectedInsiders.map((insider) {
//         return {
//           "insiderId": insider.id,
//           "isBar": selectedCheckboxes['${insider.counterName}-Bar'] ?? false,
//           "isFeedback":
//               selectedCheckboxes['${insider.counterName}-Feedback'] ?? false,
//           "isLounge":
//               selectedCheckboxes['${insider.counterName}-Lounge'] ?? false,
//         };
//       }).toList(),
//       "ageLimit": selectedAge == "No Limit" ? null : int.parse(selectedAge!)
//     });

//     ReturnObj response = await apis().createEvent(eventJson);

//     if (response.status) {
//       Fluttertoast.showToast(msg: "Event Creaeted Successfully");
//       Navigator.pushNamed(context, "/home-screen");
//     } else {
//       Fluttertoast.showToast(msg: response.message);
//     }
//   }

//   Future<void> _fetchInsiders() async {
//     // Replace this with your API call to fetch insiders
//     ReturnObj<List<Counter>> fetchedInsiders = await apis().getInsiderList();
//     if (fetchedInsiders.status) {
//       setState(() {
//         insiders = fetchedInsiders.data!;
//       });
//     } else {
//       Fluttertoast.showToast(msg: "Failed to fetch insiders");
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         dateController.text = _selectedDate!.toLocal().toString().split(' ')[0];

//         print(
//             "ssssssssssssssssssssssssssssssssss ${dateController.text}"); // Format the date as needed
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context, bool isFrom) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: isFrom
//           ? (_selectedFromTime ?? TimeOfDay.now())
//           : (_selectedToTime ?? TimeOfDay.now()),
//     );
//     if (picked != null &&
//         (isFrom ? picked != _selectedFromTime : picked != _selectedToTime)) {
//       setState(() {
//         if (isFrom) {
//           _selectedFromTime = picked;
//           fromTimeController.text = _selectedFromTime!.format(context);
//           print(
//               "tttttttttttttttttt ${fromTimeController.text}"); // Format the time as needed
//         } else {
//           _selectedToTime = picked;
//           toTimeController.text =
//               _selectedToTime!.format(context); // Format the time as needed
//         }
//       });
//     }
//   }

//   // void _createEvent() async {
//   //   if (locationName.text.isEmpty ||
//   //       eventName.text.isEmpty ||
//   //       dateController.text.isEmpty ||
//   //       fromTimeController.text.isEmpty ||
//   //       toTimeController.text.isEmpty ||
//   //       selectedInsiders.isEmpty ||
//   //       selectedAge == null) {
//   //     Fluttertoast.showToast(msg: "Please Enter all the Details");
//   //     return;
//   //   }
//   //   ReturnObj response = await apis().sendOtp(locationName.text);
//   //   if (response.status) {
//   //     Navigator.pushNamed(context, "/home-screen");
//   //     Fluttertoast.showToast(msg: response.message);
//   //   } else {
//   //     Fluttertoast.showToast(msg: response.message);
//   //   }
//   //   return;
//   // }

//   void _showInsidersModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setModalState) {
//             return Container(
//               color: Color(0xFF4f5273),
//               padding: EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: insiders.map((insider) {
//                   bool isSelected = selectedInsiders.contains(insider);
//                   return Column(
//                     children: [
//                       CheckboxListTile(
//                         title: Text(
//                           insider.counterName,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         value: isSelected,
//                         onChanged: (bool? value) {
//                           setModalState(() {
//                             setState(() {
//                               if (value == true) {
//                                 selectedInsiders.add(insider);
//                               } else {
//                                 selectedInsiders.remove(insider);
//                                 selectedCheckboxes
//                                   ..remove('${insider.counterName}-Bar')
//                                   ..remove('${insider.counterName}-Lounge')
//                                   ..remove('${insider.counterName}-Feedback');
//                               }
//                             });
//                           });
//                         },
//                       ),
//                       if (isSelected) ...[
//                         if (insider.hasBar)
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: selectedCheckboxes[
//                                         '${insider.counterName}-Bar'] ??
//                                     false,
//                                 onChanged: (bool? value) {
//                                   setModalState(() {
//                                     setState(() {
//                                       selectedCheckboxes[
//                                               '${insider.counterName}-Bar'] =
//                                           value!;
//                                     });
//                                   });
//                                 },
//                               ),
//                               Text('Bar',
//                                   style: TextStyle(color: Colors.white)),
//                             ],
//                           ),
//                         if (insider.hasLounge)
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: selectedCheckboxes[
//                                         '${insider.counterName}-Lounge'] ??
//                                     false,
//                                 onChanged: (bool? value) {
//                                   setModalState(() {
//                                     setState(() {
//                                       selectedCheckboxes[
//                                               '${insider.counterName}-Lounge'] =
//                                           value!;
//                                     });
//                                   });
//                                 },
//                               ),
//                               Text('Lounge',
//                                   style: TextStyle(color: Colors.white)),
//                             ],
//                           ),
//                         if (insider.hasFeedback)
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: selectedCheckboxes[
//                                         '${insider.counterName}-Feedback'] ??
//                                     false,
//                                 onChanged: (bool? value) {
//                                   setModalState(() {
//                                     setState(() {
//                                       selectedCheckboxes[
//                                               '${insider.counterName}-Feedback'] =
//                                           value!;
//                                     });
//                                   });
//                                 },
//                               ),
//                               Text('Feedback',
//                                   style: TextStyle(color: Colors.white)),
//                             ],
//                           ),
//                       ],
//                     ],
//                   );
//                 }).toList(),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return PopScope(
//         canPop: true,
//         child: Scaffold(
//           body: Stack(
//             children: [
//               Container(
//                 height: screenHeight,
//                 width: screenWidth,
//                 decoration: const BoxDecoration(color: Color(0xFF292c4c)),
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const SizedBox(
//                           height: 80.0,
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 40.0),
//                           child: Text(
//                             APP_TEXT_CONSTANTS.EVENTS,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w100,
//                               fontSize: 30,
//                               decoration: TextDecoration.none,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 40.0),
//                           child: TextField(
//                             controller: locationName,
//                             style: TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Color(0xFF4f5273),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                               hintText: 'Location Name',
//                               hintStyle:
//                                   TextStyle(color: Colors.white, fontSize: 18),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 40.0),
//                           child: TextField(
//                             controller: eventName,
//                             style: TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Color(0xFF4f5273),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                               hintText: 'Event Name',
//                               hintStyle:
//                                   TextStyle(color: Colors.white, fontSize: 18),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 40.0),
//                           child: TextField(
//                             controller: dateController,
//                             style: TextStyle(color: Colors.white),
//                             readOnly:
//                                 true, // This makes the TextField read-only
//                             onTap: () =>
//                                 _selectDate(context), // Open date picker on tap
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Color(0xFF4f5273),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                               hintText: 'Date',
//                               hintStyle: const TextStyle(
//                                   color: Colors.white, fontSize: 18),
//                               suffixIcon: IconButton(
//                                 icon: const Icon(Icons.calendar_today,
//                                     color: Colors.white),
//                                 onPressed: () => _selectDate(
//                                     context), // Open date picker on icon press
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 40.0),
//                           child: TextField(
//                             controller: fromTimeController,
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                             readOnly:
//                                 true, // This makes the TextField read-only
//                             onTap: () => _selectTime(
//                                 context, true), // Open time picker on tap
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Color(0xFF4f5273),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                               hintText: 'From Time',
//                               hintStyle: TextStyle(
//                                 color: Colors.white,
//                               ),
//                               suffixIcon: IconButton(
//                                 icon: Icon(Icons.access_time,
//                                     color: Colors.white),
//                                 onPressed: () => _selectTime(context,
//                                     true), // Open time picker on icon press
//                               ),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 40.0),
//                           child: TextField(
//                             controller: toTimeController,
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                             readOnly:
//                                 true, // This makes the TextField read-only
//                             onTap: () => _selectTime(
//                                 context, false), // Open time picker on tap
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Color(0xFF4f5273),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                               hintText: 'To Time',
//                               hintStyle: TextStyle(
//                                 color: Colors.white,
//                               ),
//                               suffixIcon: IconButton(
//                                 icon: Icon(Icons.access_time,
//                                     color: Colors.white),
//                                 onPressed: () => _selectTime(context,
//                                     false), // Open time picker on icon press
//                               ),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 40.0),
//                           child: DropdownButtonFormField<String>(
//                             value: selectedAge,
//                             items: List.generate(
//                                     60, (index) => (index + 1).toString())
//                                 .map((age) {
//                               return DropdownMenuItem<String>(
//                                 value: age,
//                                 child: Text(age),
//                               );
//                             }).toList()
//                               ..add(
//                                 const DropdownMenuItem<String>(
//                                   value: 'No Limit',
//                                   child: Text('No Limit'),
//                                 ),
//                               ),
//                             hint: const Text(
//                               'Select Age',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedAge = newValue;
//                               });
//                             },
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Color(0xFF4f5273),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 40.0),
//                           child: ElevatedButton(
//                             onPressed: () => _showInsidersModal(context),
//                             child: Text(
//                               selectedInsiders.isNotEmpty
//                                   ? 'Selected Insiders (${selectedInsiders.length})'
//                                   : 'Select Insiders',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF4f5273),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           height: 60,
//                           width: 220,
//                           child: ElevatedButton(
//                             onPressed: _createEvent,
//                             style: ElevatedButton.styleFrom(
//                                 side: const BorderSide(
//                                     strokeAlign: 2, color: Colors.white),
//                                 backgroundColor: Color(0xFF292c4c)),
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 5.0, horizontal: 10.0),
//                               child: Text(
//                                 "Activate",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
