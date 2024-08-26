import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/responses/GetItemsOfMenuResponse.dart';
import 'package:flutter/material.dart';

class MenuItemScreen extends StatefulWidget {
  final String? menuId;
  final String? nameOfMenu;

  MenuItemScreen({
    required this.menuId,
    required this.nameOfMenu,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  late Future<dynamic> futureData;

  @override
  void initState() {
    super.initState();
    futureData = _fetchMenuData();
  }

  void _addItemToMenu() {
    Navigator.pushNamed(context, "/new-item-menu", arguments: {
      "menuCategoryId": widget.menuId,
      "menuCategoryName": widget.nameOfMenu,
      "itemId": ""
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
                                fontFamily: "Helvetica",
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 30,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight / 4),
                          CustomStrokedButton(
                            isAdding: false,
                            fontSize: 60,
                            borderRadius: 20,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              widget.nameOfMenu!,
                              style: const TextStyle(
                                fontFamily: "Helvetica",
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 30,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          ...response.data!.expand((datum) {
                            return [
                              MenuItemRow(
                                widthofButton:
                                    screenWidth - screenWidth * 0.0407,
                                heightofButton: 96,
                                itemName: datum.itemName,
                                onPressed: () => {
                                  Navigator.pushNamed(context, "/new-item-menu",
                                      arguments: {
                                        "menuCategoryId": widget.menuId,
                                        "menuCategoryName": widget.nameOfMenu,
                                        "itemId": datum.id
                                      })
                                },
                                quantity: datum.quantity,
                                currency: datum.currency,
                                price: datum.price,
                                borderRadius: 20,
                                imageUrl: datum.image,
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
                            borderRadius: 20,
                            onPressed: () {
                              _addItemToMenu();
                            },
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
