import 'package:barfly/apis.dart';
import 'package:barfly/responses/get_particular_order_resposne.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';

class AddNewItemController extends GetxController {
  TextEditingController quantityController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController availableQuantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int toggleIndex = 0;

  var isLoading = true.obs;
  final String itemId;

  AddNewItemController(this.itemId);

  @override
  void onInit() {
    fetchItemDetails(itemId); // Fetch data using the itemId
    super.onInit();
  }

  Future<void> fetchItemDetails(String itemId) async {
    try {
      ReturnObj<ParticularItemDetails> result =
          await apis().getParticularOrder(itemId);
      if (result.status) {
        quantityController.text = result.data!.availableQuantity.toString();
        nameController.text = result.data!.itemId.itemName;
        availableQuantityController.text =
            result.data!.availableQuantity.toString();
        descriptionController.text = result.data!.itemId.description;
        priceController.text = result.data!.price.toString();
        if (result.data!.itemId.type == "Drink") {
          toggleIndex = 0;
        } else {
          toggleIndex = 1;
        }
      } else {
        Fluttertoast.showToast(
            msg: "Error occurred while fetching counterList");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
