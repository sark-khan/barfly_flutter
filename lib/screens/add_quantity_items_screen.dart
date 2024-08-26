import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/components/CustomText.dart';
import 'package:barfly/controller/add_quantity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQuantityItemsScreen extends StatefulWidget {
  final String? itemId;
  final String? nameOfItem;

  const AddQuantityItemsScreen({
    required this.itemId,
    required this.nameOfItem,
    super.key,
  });

  @override
  State createState() => _AddQuantityItemsScreenState();
}

class _AddQuantityItemsScreenState extends State<AddQuantityItemsScreen> {
  @override
  Widget build(BuildContext context) {
    final AddQuantityController controller =
        Get.put(AddQuantityController(widget.itemId!));
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1399),
              width: screenWidth,
              height: screenHeight,
              decoration: const BoxDecoration(color: APPCOLORS.backgroundColor),
              child: FutureBuilder<void>(
                future: controller.fetchCountersWithQuantity(widget.itemId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    int total = 0;
                    if (controller.counterListQuantity.isEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 80),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                widget.nameOfItem!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 30,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // SizedBox(height: screenHeight / 4),
                            SizedBox(height: screenHeight / 4),
                          ],
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 80),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                widget.nameOfItem!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 30,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 34),
                            ...controller.counterListQuantity.map((datum) {
                              total += datum.availableQuantity;
                              return Column(
                                children: [
                                  AddQuantityRow(
                                    widthofButton:
                                        screenWidth - screenWidth * 0.0407,
                                    heightofButton: 96,
                                    counterName: datum.counterName,
                                    onPressed: () => {},
                                    quantity:
                                        datum.availableQuantity.toString(),
                                    quantityController: TextEditingController(
                                        text:
                                            datum.availableQuantity.toString()),
                                    // price: datum.,
                                    borderRadius: 20,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            }).toList(),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 2,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                  flex: 8,
                                  child: CustomText(
                                    text: "Total",
                                    textAlign: TextAlign.center,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 5,
                                  child: CustomText(
                                    text: total.toString(),
                                    textAlign: TextAlign.center,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
