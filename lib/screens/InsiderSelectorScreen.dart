// import 'package:barfly/apis.dart';
// import 'package:barfly/appConstants.dart';
// import 'package:barfly/components/Buttons.dart';
// import 'package:barfly/responses/CreateInsiderResponse.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class InsiderSelectorScreen extends StatefulWidget {
//   final double? insiderCount;

//   InsiderSelectorScreen({
//     this.insiderCount = 1,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State createState() => _InsiderSelectorScreenState();
// }

// class _InsiderSelectorScreenState extends State<InsiderSelectorScreen> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController insiderName =
//         TextEditingController(text: "Insider ${widget.insiderCount}");
//     void createNewInsider(insiderType) async {
//       ReturnObj<CreateInsiderData> response =
//           await apis().createInsider(insiderName.text, insiderType);
//       if (response.status) {
//         Navigator.pushNamed(context, "/menu-screen",
//             arguments: {"insiderId": response.data!.id});
//         return;
//       } else {
//         Fluttertoast.showToast(msg: response.message);
//         return;
//       }
//     }

//     return Scaffold(
//       body: PopScope(
//         canPop: true,
//         child: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               height: double.infinity,
//               decoration: const BoxDecoration(color: APPCOLORS.backgroundColor),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 70,
//                     ),
//                     Container(
//                       width: 300,
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 5, horizontal: 15),
//                       decoration: BoxDecoration(
//                           color: const Color(0xFF4f5273),
//                           borderRadius: BorderRadius.circular(20.0)),
//                       child: TextField(
//                         controller: insiderName,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                         ),
//                         textAlign: TextAlign.center,
//                         textAlignVertical: TextAlignVertical.center,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintStyle: TextStyle(
//                             color: Colors.white,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     CustomButton(
//                       text: "Bar/Menu",
//                       heightofButton: 150,
//                       borderRadius: 30,
//                       onPressed: () => {createNewInsider("Bar")},
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     CustomButton(
//                       text: "Lounge",
//                       heightofButton: 150,
//                       borderRadius: 30,
//                       onPressed: () => {},
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     CustomButton(
//                       text: "Feedback",
//                       heightofButton: 150,
//                       borderRadius: 30,
//                       onPressed: () => {},
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
