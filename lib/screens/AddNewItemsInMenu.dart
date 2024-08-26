import 'dart:convert';
import 'dart:io' as io; // For mobile
import 'dart:html' as html;
import 'package:barfly/apis.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/components/CustomText.dart';
import 'package:barfly/components/InputFieldList.dart';
import 'package:barfly/components/InputFields.dart';
import 'package:barfly/components/drop_down_list.dart';
import 'package:barfly/responses/get_particular_order_resposne.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddNewItemInMenuScreen extends StatefulWidget {
  final String? menuCategoryId;
  final String? menuCategoryName;
  final String? itemId;

  const AddNewItemInMenuScreen({
    required this.menuCategoryId,
    required this.menuCategoryName,
    this.itemId,
    super.key,
  });

  @override
  State createState() => _AddNewItemInMenuScreenState();
}

class _AddNewItemInMenuScreenState extends State<AddNewItemInMenuScreen> {
  int toggleIndex = 0;
  final ImagePicker picker = ImagePicker();
  io.File? imageFile; // For mobile
  html.File? imageFileWeb; // For web
  String? imageUrl;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController availableQuantityController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.itemId == "") {
    } else {
      fetchItemDetails(widget.itemId!);
    }
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
        imageUrl = result.data!.itemId.image;
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
      setState(() {});
    }
  }

  Future<XFile> htmlFileToXFile(html.File htmlFile) async {
    final reader = html.FileReader();
    reader.readAsDataUrl(htmlFile);
    await reader.onLoadEnd.first;
    final bytes = reader.result as String;
    return XFile.fromData(base64Decode(bytes.split(',').last),
        name: htmlFile.name);
  }

  void _addItems() async {
    html.File? selectedFile;

    // if (kIsWeb && imageFileWeb != null) {
    //   selectedFile = await htmlFileToXFile(imageFileWeb!);
    // } else if (!kIsWeb && imageFile != null) {
    selectedFile = imageFileWeb as html.File;
    // }

    if (selectedFile != null) {
      ReturnObj response = await apis().createItemOfMenu(
        nameController.text,
        toggleIndex == 0 ? "Drink" : "Food",
        quantityController.text,
        priceController.text,
        descriptionController.text,
        "CHF",
        widget.menuCategoryId!,
        availableQuantityController.text,
        widget.itemId == "" ? true : false,
        widget.itemId!,
        selectedFile,
      );

      if (response.status) {
        Fluttertoast.showToast(msg: "Created Successfully");
        Navigator.pushNamed(context, "/menu-item-screen", arguments: {
          "menuId": widget.menuCategoryId,
          "nameOfMenu": widget.menuCategoryName,
        });
        return;
      }
      Fluttertoast.showToast(msg: "Error occurred");
    } else {
      Fluttertoast.showToast(msg: "Please select an image");
    }
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        if (files != null && files.isNotEmpty) {
          final reader = html.FileReader();
          reader.readAsDataUrl(files[0]);
          reader.onLoadEnd.listen((event) {
            setState(() {
              imageFileWeb = files[0];
              imageUrl = reader.result as String;
            });
          });
        }
      });
    } else {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imageFile = io.File(pickedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // int toggleIndex = 0;
    // void _addItems() async {
    //   var selectedFile = kIsWeb ? imageFileWeb : imageFile;
    //   if (selectedFile != null) {
    //     ReturnObj response = await apis().createItemOfMenu(
    //       nameController.text,
    //       toggleIndex == 0 ? "Drink" : "Food",
    //       quantityController.text,
    //       priceController.text,
    //       descriptionController.text,
    //       "CHF",
    //       widget.menuCategoryId!,
    //       availableQuantityController.text,
    //       widget.itemId == "" ? true : false,
    //       widget.itemId!,
    //       selectedFile,
    //     );

    //     if (response.status) {
    //       Fluttertoast.showToast(msg: "Created Successfully");
    //       Navigator.pushNamed(context, "/menu-item-screen", arguments: {
    //         "menuId": widget.menuCategoryId,
    //         "nameOfMenu": widget.menuCategoryName,
    //       });
    //       return;
    //     }
    //     Fluttertoast.showToast(msg: "Error occurred");
    //   } else {
    //     Fluttertoast.showToast(msg: "Please select an image");
    //   }
    // }

    return PopScope(
        canPop: true,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(color: Color(0xFF292c4c)),
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(
                        //   height: 100.0,
                        // ),
                        Container(
                          width: 168,
                          height: 40,
                          child: ToggleSwitch(
                            minWidth: MediaQuery.of(context).size.width,
                            minHeight: 40,
                            initialLabelIndex: toggleIndex,
                            cornerRadius: 15.0,
                            fontSize: 20,
                            activeFgColor: Color(0xFF292C4C),
                            inactiveBgColor: Colors.transparent,
                            inactiveFgColor: Colors.white,
                            totalSwitches: 2,
                            labels: const ["Drink", "Food"],
                            customTextStyles: const [
                              TextStyle(
                                  fontFamily: "Helvetica",
                                  fontSize: 20,
                                  height: 2.04,
                                  fontWeight: FontWeight.w300),
                              TextStyle(
                                  fontFamily: "Helvetica",
                                  fontSize: 20,
                                  height: 2.04,
                                  fontWeight: FontWeight.w300)
                            ],
                            borderWidth: 1,
                            borderColor: [Colors.white],
                            activeBgColors: const [
                              [Colors.white],
                              [Colors.white],
                            ],
                            onToggle: (index) {
                              toggleIndex = index!;
                              setState(() {});
                              // setState(() {
                              //   toggleIndex = index!;
                              // });
                              // updateData();
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          controller: nameController,
                          hintText: "Name item",
                          isPassword: false,
                          fontSize: 23,
                          fontWeight: FontWeight.w300,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                              width: 168,
                              height: 192,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.white)),
                              child: imageUrl != null
                                  ? Image.network(
                                      imageUrl!,
                                      // width: widthofButton,
                                      // height: heightofButton,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        print(error.toString());
                                        print("erorr while loading image");
                                        return Image.asset('cocaCola.png');
                                      },
                                    )
                                  : imageFile != null
                                      ? Image.file(
                                          imageFile!, // For mobile
                                          fit: BoxFit.cover,
                                        )
                                      : const Center(
                                          child: CustomText(
                                            text: "Choose Photo from library",
                                            fontSize: 23,
                                            color: Color(0x80FFFFFF),
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: screenWidth < 400 ? screenWidth * 0.834 : 328,
                          height: 104,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF4f5273),
                              border:
                                  Border.all(color: const Color(0xFF4f5273))),
                          child: TextField(
                            maxLines: null,
                            controller: descriptionController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Helvetica",
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Description (optional)",
                              hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 23,
                                  fontFamily: "Helvetica",
                                  // height: widget.height,
                                  fontWeight: FontWeight.w300),
                              contentPadding: EdgeInsets.only(
                                  left: 15.0, right: 17, top: 0.0, bottom: 0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 81,
                            ),
                            CustomText(
                              text: "Amount",
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            CustomText(
                              text: "Unit",
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AddItemsInputField(
                              hintText: "0",
                              fontSize: 23,
                              borderRadius: 10,
                              fontWeight: FontWeight.w300,
                              widthOfField: 136,
                              heightofField: 56,
                              controller: availableQuantityController,
                            ),
                            const SizedBox(
                              width: 48,
                            ),
                            AddItemsDropdownField(
                              hintText: toggleIndex == 0 ? "ml" : "g",
                              isDrinks: toggleIndex == 0 ? true : false,
                              fontSize: 23,
                              borderRadius: 10,
                              fontWeight: FontWeight.w300,
                              widthOfField: 80,
                              heightofField: 56,
                              controller: quantityController,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 19,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 80,
                            ),
                            CustomText(
                              text: "Price",
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: 164,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 136,
                              height: 56,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      10), // Padding for internal spacing
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "CHF",
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Helvetica"),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Space between "CHF" and the TextField
                                  Expanded(
                                    child: TextField(
                                      controller: priceController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 10, right: 10, top: 5.5),
                                        border: InputBorder.none,
                                        hintText: "0",
                                        hintStyle: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 23,
                                          fontFamily: "Helvetica",
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Helvetica",
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 130),
                          ],
                        ),
                        // AddMenuItem(
                        //     price: priceController,
                        //     quantity: quantityController,
                        //     description: descriptionController,
                        //     imageId: "image",
                        //     widthofButton: screenWidth / 2,
                        //     heightofButton:
                        //         screenHeight < 400 ? 400 : screenHeight * 0.45,
                        //     borderRadius: 25,
                        //     productType: toggleIndex == 0 ? "Drink" : "Snack"),
                        SizedBox(
                          height: 40,
                        ),
                        CustomButtonStroked(
                          text: "Add to ${widget.menuCategoryName}",
                          onPressed: () => {_addItems()},
                          horizontalPadding: 10,
                          widthofButton: screenWidth / 2,
                          fontSize: 20,
                          borderRadius: 20,
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: screenWidth * 0.14, top: 50),
                child: GestureDetector(
                  onTap: () {
                    // Storage.removeOrderDetails();
                    // Storage.removeTotalOrderPrice();
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 34,
                      height: 32,
                      child: Image.asset("back_button.png")),
                ),
              ),
            ],
          ),
        ));
  }
}
