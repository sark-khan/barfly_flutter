import 'package:barfly/apis.dart';
import 'package:barfly/responses/GetCounterResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CounterListController extends GetxController {
  var counterList = <Counter>[].obs;
  var isLoading = true.obs;
  CounterListController();
  var counterSelected = <String, bool>{}.obs;
  var isRepetitive = false.obs;
  var repetitiveDays = List<bool>.filled(7, false).obs;
  var isWeekDays = false.obs;
  var isWeekEnds = false.obs;
  var isWholeWeek = false.obs;
  var daysMapping = <String>[
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  var isRepetitiveSubmitted = false.obs;
  var fromDate = "".obs;
  var toDate = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchCounter();
  }

  void updateRepetitive(int index, bool val) {
    isRepetitive.value = true;
    repetitiveDays[index] = val;
  }

  void updateWeekDays(bool val) {
    isWeekDays.value = val;
    if (isWholeWeek.value == true) {
      return;
    }
    isRepetitive.value = val;
    for (int i = 0; i < 5; i++) {
      repetitiveDays[i] = val;
    }
  }

  ReturnObj submitValue() {
    if (fromDate.value == "" || toDate.value == "") {
      return ReturnObj(
          message: "Please select to and from Date", status: false);
    }
    for (int i = 0; i < 7; i++) {
      if (repetitiveDays[i] == true) {
        isRepetitiveSubmitted.value = true;
        return ReturnObj(message: "Days Addedd Successfully", status: true);
      }
    }
    return ReturnObj(
        message: "Please select days bfore submtting", status: false);
  }

  void updateWholeWeek(bool val) {
    isWholeWeek.value = val;
    isRepetitive.value = val;
    for (int i = 0; i < 7; i++) {
      repetitiveDays[i] = val;
    }
  }

  void updateWeekends(bool val) {
    isWeekEnds.value = val;
    if (isWholeWeek.value == true) {
      return;
    }
    isRepetitive.value = val;

    repetitiveDays[5] = val;
    repetitiveDays[6] = val;
  }

  Future<void> fetchCounter() async {
    isLoading.value = true;
    try {
      ReturnObj<List<Counter>> result = await apis().getInsiderList();
      if (result.status) {
        counterList.value = result.data!;
        for (int i = 0; i < counterList.length; i++) {
          counterSelected[counterList[i].id] = false;
        }
      } else {
        Fluttertoast.showToast(msg: result.message);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
