import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/CustomText.dart';
import 'package:barfly/controller/counter_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SettingScreenCounter extends StatefulWidget {
  final String counterId;
  final bool isFirstTime;
  final String counterName;
  const SettingScreenCounter({
    required this.isFirstTime,
    this.counterId = "",
    this.counterName = "",
    super.key,
  });

  @override
  State createState() => _SettingScreenCounterState();
}

class _SettingScreenCounterState extends State<SettingScreenCounter> {
  late final CounterSettingsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
        CounterSettingsController(widget.counterId, widget.isFirstTime));
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController totalTables = TextEditingController();
    TextEditingController counterName = TextEditingController();
    totalTables.text = controller.counterSettings.value.totalTables.toString();

    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if (didPop) {
            Get.delete<CounterSettingsController>();
          }
        },
        child: Stack(children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(color: APPCOLORS.backgroundColor),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (widget.isFirstTime == false) {
                counterName.text = controller.counterSettings.value.counterName;
              }
              print("${counterName.text} value of conter Name");
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: 240,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: const Color(0x727E83A3),
                          ),
                          child: Center(
                              child: TextField(
                            textAlign: TextAlign.center,
                            controller: counterName,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 23,
                              decoration: TextDecoration.none,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              hintText: widget.isFirstTime
                                  ? 'Enter Counter Name'
                                  : null, // The hint text
                              hintStyle: TextStyle(
                                color: Colors
                                    .white38, // The color of the hint text
                                fontSize: 23, // The font size of the hint text
                              ),
                            ),
                          )),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.only(left: 29),
                        //   child: const Icon(
                        //     color: Color(0x727E83A3),
                        //     Icons.settings,
                        //     size: 36,
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(
                      height: 56,
                    ),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 264, minWidth: 264),
                      child: IntrinsicWidth(
                          child: IntrinsicHeight(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: const CustomText(
                                    text: "Settings",
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  height: 62,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 145,
                                      child: CustomText(
                                        text: "Table service",
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 31,
                                        child: SizedBox(
                                          width: 1,
                                        )),
                                    Expanded(
                                      flex: 56,
                                      child: FlutterSwitch(
                                        onToggle: (val) => {
                                          controller.counterSettings
                                              .update((settings) {
                                            settings?.isTableService = val;
                                          })
                                        },
                                        inactiveColor: Colors.white,
                                        activeColor: Color(0xFF08F748),
                                        width: 56,
                                        height: 22,
                                        toggleSize: 22,
                                        padding: 0,
                                        borderRadius: 16,
                                        value: controller.counterSettings.value
                                            .isTableService,
                                        toggleColor: Color(0xFF292C4C),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: controller
                                      .counterSettings.value.isTableService,
                                  child: SizedBox(
                                    height: 8,
                                  ),
                                ),
                                Visibility(
                                  visible: controller
                                      .counterSettings.value.isTableService,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 145,
                                        child: CustomText(
                                          text: "Number of tables",
                                          fontSize: 25,
                                          fontWeight: FontWeight.w300,
                                          softWrap: true,
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                        flex: 31,
                                      ),
                                      Expanded(
                                        flex: 56,
                                        child: Container(
                                          width: 56,
                                          height: 46,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: TextField(
                                              onChanged: (value) {
                                                // Update the totalTables value in the controller
                                                controller.counterSettings
                                                    .update((settings) {
                                                  settings?.totalTables =
                                                      int.tryParse(value) ?? 0;
                                                });
                                              },
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly, // Restrict input to digits only
                                              ],
                                              controller: totalTables,
                                              decoration: const InputDecoration(
                                                border: InputBorder
                                                    .none, // Removes the underline
                                                focusedBorder: InputBorder
                                                    .none, // Ensures it stays removed when focused
                                                enabledBorder: InputBorder
                                                    .none, // Ensures it stays removed when enabled
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 5,
                                                    left: 5,
                                                    right:
                                                        5), // Optional: add padding if needed
                                              ),
                                              style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 23),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 145,
                                      child: CustomText(
                                        text: "Self pick-up",
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 31,
                                        child: SizedBox(
                                          width: 1,
                                        )),
                                    Expanded(
                                      flex: 56,
                                      child: FlutterSwitch(
                                        onToggle: (val) => {
                                          controller.counterSettings
                                              .update((settings) {
                                            settings?.isSelfPickUp = val;
                                          })
                                        },
                                        inactiveColor: Colors.white,
                                        activeColor: Color(0xFF08F748),
                                        width: 56,
                                        height: 22,
                                        toggleSize: 22,
                                        padding: 0,
                                        borderRadius: 16,
                                        value: controller
                                            .counterSettings.value.isSelfPickUp,
                                        toggleColor: Color(0xFF292C4C),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 19,
                                ),
                                Center(
                                  child: Container(
                                    height: 56,
                                    width: 136,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation:
                                            0, // Set elevation to 0 to avoid shadow blur
                                        backgroundColor: Color(0XFF0022FF),
                                        shadowColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                      ),
                                      onPressed: () async {
                                        ReturnObj res = widget.isFirstTime
                                            ? await controller
                                                .addCounterWithSettings(
                                                    counterName.text)
                                            : await controller
                                                .updateCounterSettings();
                                        Fluttertoast.showToast(
                                            msg: res.message);
                                        if (res.status) {
                                          Navigator.pushNamed(
                                              context, "/insider-screen");
                                          return;
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: const CustomText(
                                          text: "SAVE",
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                )
                              ]),
                        ),
                      )),
                    ),
                    const SizedBox(height: 40),
                    // Additional UI Elements
                  ],
                ),
              );
            }),
          ),
        ]),
      ),
    );
  }
}
