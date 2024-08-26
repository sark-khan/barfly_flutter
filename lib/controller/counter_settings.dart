import 'package:barfly/apis.dart';
import 'package:barfly/responses/GetCounterSettings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CounterSettingsController extends GetxController {
  var counterSettings = CounterSettings(
          id: "",
          counterName: "",
          isSelfPickUp: true,
          isTableService: false,
          totalTables: 0)
      .obs;
  var isLoading = true.obs;
  final String counterId;
  final bool isFirstTime;
  CounterSettingsController(this.counterId, this.isFirstTime);

  @override
  void onInit() {
    print("$isLoading");
    super.onInit();
    isFirstTime ? isLoading.value = false : fetchCounterSettings();
  }

  Future<ReturnObj> addCounterWithSettings(String counterName) async {
    try {
      if (counterName == "") {
        // Fluttertoast.showToast(msg: "Please Enter the Counter Name");
        return ReturnObj(
            message: "Please Enter the Counter Name", status: false);
      }
      isLoading.value = true;
      counterSettings.value.counterName = counterName;
      ReturnObj response = await apis().createCounter(counterSettings.value);
      return response;
      // Fluttertoast.showToast(msg: response.message);
    } catch (e) {
      return ReturnObj(message: "An error occured", status: false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<ReturnObj> updateCounterSettings() async {
    isLoading.value = true;
    try {
      ReturnObj response = await apis().updateCounterSettings(
        counterSettings.value,
      );
      return response;
    } catch (e) {
      return ReturnObj(message: "An Error occured", status: false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCounterSettings() async {
    isLoading.value = true;
    try {
      ReturnObj<CounterSettings> result =
          await apis().getCounterSettings(counterId);
      if (result.status) {
        counterSettings.value = result.data!;
      } else {
        Fluttertoast.showToast(
            msg: "Error occurred while fetching counter settings");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
