import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/components/CustomText.dart';
import 'package:barfly/responses/GetItemsOfMenuResponse.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ItemListStock extends StatefulWidget {
  final String? menuId;
  final String? nameOfMenu;

  const ItemListStock({
    required this.menuId,
    required this.nameOfMenu,
    super.key,
  });

  @override
  State createState() => _ItemListStockState();
}

class _ItemListStockState extends State<ItemListStock> {
  late Future<dynamic> futureData;
  // List<GetMenuOfInsderData> menuItems = [];
  // TextEditingController menuName = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureData = _fetchMenuData();
  }

  void _addItemToMenu() {
    Navigator.pushNamed(context, "/new-item-menu", arguments: {
      "menuCategoryId": widget.menuId,
      "menuCategoryName": widget.nameOfMenu
    });
    return;
  }

  Future<ReturnObj<List<MenuCategoryItem>>> _fetchMenuData() async {
    final response = await apis().getItemsOfMenu(widget.menuId!);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int toggleIndex = 0;
    return PopScope(
      canPop: true,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0407),
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(color: APPCOLORS.backgroundColor),
            child: FutureBuilder(
              future: futureData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  ReturnObj<List<MenuCategoryItem>> response = snapshot.data;

                  if (response.data == null || response.data!.isEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 80),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              widget.nameOfMenu!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                fontSize: 30,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight / 4),
                          CustomStrokedButton(
                            isAdding: false,
                            fontSize: 60,
                            // verticalPadding: 0,
                            // widthofButton: screenWidth / 5,
                            // heightofButton: screenHeight / 9,
                            borderRadius: 20,
                            // horizontalPadding: 0,
                            onPressed: () {
                              _addItemToMenu();
                            },
                          ),
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
                          const Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Item list/ stock",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                fontSize: 30,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 34),
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
                                    decoration: TextDecoration.none,
                                    height: 1.64,
                                    fontWeight: FontWeight.w300),
                                TextStyle(
                                    fontFamily: "Helvetica",
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                    height: 1.64,
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
                                // setState(() {
                                //   toggleIndex = index!;
                                // });
                                // updateData();
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: CustomText(
                                      text: "Items",
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 20, bottom: 5, top: 5),
                                    child: CustomText(
                                      text: "QTY",
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                    ),
                                  )),
                            ],
                          ),
                          ...response.data!.expand((datum) {
                            return [
                              ItemStockListRow(
                                widthofButton:
                                    screenWidth - screenWidth * 0.0407,
                                heightofButton: 96,
                                itemName: datum.itemName,
                                onPressed: () => {},
                                quantity: datum.quantity,
                                currency: datum.currency,
                                price: datum.price,
                                borderRadius: 20,
                              ),
                              const SizedBox(height: 20),
                            ];
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomStrokedButton(
                            isAdding: false,
                            fontSize: 60,
                            // verticalPadding: 0,
                            // widthofButton: screenWidth / 5,
                            // heightofButton: screenHeight / 9,
                            borderRadius: 20,
                            // horizontalPadding: 0,
                            onPressed: () {
                              _addItemToMenu();
                            },
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          CustomText(
                            text: "Add items",
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    );
                  }
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
