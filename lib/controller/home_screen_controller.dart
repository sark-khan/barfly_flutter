import 'package:barfly/apis.dart';
import 'package:barfly/screens/GetCounterListQuantity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var counterListQuantity = <CounterListQuantity>[].obs;
  var isLoading = true.obs;
  final String itemId;
  var totalCounters = 0.obs;
  HomeScreenController(this.itemId);

  @override
  void onInit() {
    // fetchCountersWithQuantity(itemId);
    super.onInit();
  }

  Future<void> fetchLiveEvents() async {
    try {
      ReturnObj<List<CounterListQuantity>> result =
          await apis().GetCounterListQuantityApi(itemId);
      if (result.status) {
        counterListQuantity.value = result.data!;
        totalCounters.value = result.data!.length;
      } else {
        Fluttertoast.showToast(msg: "Error occured while fetching counterList");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
