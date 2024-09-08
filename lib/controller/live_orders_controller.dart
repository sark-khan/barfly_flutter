import 'package:barfly/apis.dart';
import 'package:barfly/responses/GetOrderDetails.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';

class LiveOrderController extends GetxController {
  var liveOrders = <OrderDetail>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLiveOrders();
  }

  Future<void> fetchLiveOrders() async {
    try {
      isLoading(true);
      // Fetch the live orders
      ReturnObj<List<OrderDetail>> result = await apis().getLiveOrderDetails();
      if (result.status) {
        liveOrders.value = result.data!;
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch live orders");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateOrderStatus(String status, String orderId) async {
    String newStatus;
    // Color newColor;
    print(status);
    if (status == "Waiting") {
      newStatus = "InProgress";
      // newColor = Colors.yellow;
    } else if (status == "InProgress") {
      newStatus = "Ready";
      // newColor = Colors.green;
    } else {
      return;
    }

    ReturnObj response = await apis().updateStatusOfOrder(newStatus, orderId);

    if (response.status) {
      await fetchLiveOrders();
      liveOrders.refresh();
      //resh the UI
    } else {
      Fluttertoast.showToast(msg: "Failed to update order status");
    }
  }
}
