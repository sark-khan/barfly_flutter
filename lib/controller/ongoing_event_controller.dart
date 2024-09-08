import 'package:barfly/apis.dart';
import 'package:barfly/responses/GetOngoingEventDetails.dart';
import 'package:get/get.dart';

class OngoingEventController extends GetxController {
  var ongoingEventDetails =
      <String, OngoingEventDetail>{}.obs; // Observable map
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOngoingEventDetails(); // Fetch event details when controller is initialized
  }

  Future<void> fetchOngoingEventDetails() async {
    isLoading(true); // Set loading state to true
    var result =
        await apis().getOngoingEventDetails(); // Call your API function here

    if (result.status) {
      ongoingEventDetails
          .assignAll(result.data!); // Update the map with fetched data
    } else {
      // Handle errors, maybe show a snackbar or a dialog
      // Get.snackbar("Error", result.message);
      print("Error fetching ongoing event details: ${result.message}");
    }

    isLoading(false); // Set loading state to false
  }
}
