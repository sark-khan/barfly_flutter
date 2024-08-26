import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/controller/live_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveOrdersScreen extends StatelessWidget {
  final LiveOrderController controller = Get.put(LiveOrderController());

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
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1227, vertical: 50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 34,
                      height: 32,
                      child: Image.asset("back_button.png")),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 19,
                  ),
                  Center(
                    child: Text(
                      APP_TEXT_CONSTANTS.live,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 30,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.liveOrders.isEmpty) {
                  return const Center(child: Text('No live orders available'));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.liveOrders.length + 1,
                      itemBuilder: (context, index) {
                        if (index < controller.liveOrders.length) {
                          final order = controller.liveOrders[index];
                          return Column(
                            children: [
                              LiveOrderButton(
                                status: order.status,
                                items: order.items,
                                tokenNumber: order.tokenNumber.toString(),
                                onPressed: () {
                                  controller.updateOrderStatus(
                                      order.status, order.id);
                                },
                                widthofButton: 312,
                              ),
                              const SizedBox(
                                  height: 20), // Adjust the height as needed
                            ],
                          );
                        } else {
                          return Center(
                            child: CustomButtonStroked(
                              text: "+",
                              fontSize: 50,
                              borderRadius: 20,
                              onPressed: () => {
                                Navigator.pushNamed(context, "/event-creation")
                              },
                              widthofButton: 80,
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
              }),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}
