import 'package:barfly/apis.dart';
import 'package:barfly/commonFunction.dart';
import 'package:barfly/responses/GetCounterResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
    print("${fromDate.value} fromDate ${toDate.value} toDate");
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

  bool isCounterSelected() =>
      counterSelected.values.any((value) => value == true);

  Future<void> submitEvent(String selectedDate, String from, String to,
      String eventName, String selectedAge) async {
    if (isLoading.value) return;
    if (selectedDate.isEmpty ||
        from.isEmpty ||
        to.isEmpty ||
        eventName.isEmpty ||
        selectedAge.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the required details");
      return;
    }
    Map<String, String> dateObj;
    isLoading.value = true;

    if (isRepetitive.value) {
      dateObj = createDateTimeObjects(fromDate.value, from, to, toDate.value);
    } else {
      dateObj = createDateTimeObjects(selectedDate, from, to, selectedDate);
      // toDate.value = selectedDate;
      // fromDate.value = selectedDate;
    }
    var data = {
      "eventName": eventName,
      "startingDate": isRepetitive.value ? fromDate.value : selectedDate,
      "endDate": isRepetitive.value ? toDate.value : selectedDate,
      "isRepetitive": isRepetitive.value,
      "repetitiveDays": repetitiveDays.toList(),
      "from": dateObj["fromDateTime"],
      "to": dateObj["toDateTime"],
      "counterIds": counterSelected.entries
          .where((entry) => entry.value) // Filter entries where value is true
          .map((entry) => entry.key) // Map to the keys
          .toList(),
      "ageLimit": selectedAge,
    };
    ReturnObj res = await apis().createEvent(data);
    Fluttertoast.showToast(msg: res.message);
    isLoading.value = false;
    if (res.status) {
      Get.toNamed("/home-screen");
    }
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
