import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/responses/GetMenuCategoryResponse.dart';
import 'package:barfly/responses/GetMenuOfInsiderResponse.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final String? insiderId;
  final String? counterName;

  const MenuScreen({
    this.insiderId,
    this.counterName,
    super.key,
  });

  @override
  State createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<dynamic> futureData;
  bool isAddingNewItem = false;
  bool isIconSelected = false;
  List<MenuCategory> menuItems = [];
  TextEditingController menuName = TextEditingController();
  int? icon;

  @override
  void initState() {
    super.initState();
    if (widget.insiderId != null) {
      futureData = _fetchMenuData();
    } else {
      futureData = Future.value(null);
    }
  }

  Future<ReturnObj<List<MenuCategory>>> _fetchMenuData() async {
    final response = await apis().getMenuList(widget.insiderId);
    if (response.data != null && response.data!.isNotEmpty) {
      menuItems = response.data!;
    }
    return response;
  }

  void _menuItemsList(String menuId, String nameOfMenu) {
    Navigator.pushNamed(context, "/menu-item-screen",
        arguments: {"menuId": menuId, "nameOfMenu": nameOfMenu});
  }

  void _iconPressed(int index) {
    icon = index;
    print(icon);
    isIconSelected = true;
    setState(() {});
  }

  void _addNewItem() {
    setState(() {
      isAddingNewItem = true;
      menuItems.add(MenuCategory(
        id: "-1",
        name: "Enter Text...",
        icon: "",
        counterId: widget.insiderId == null ? "dummy" : widget.insiderId!,
        // items: [],
        v: -1,
      ));
    });
  }

  Future _saveNewItem() async {
    await apis()
        .createMenuOfInsider(menuName.text, icon.toString(), widget.insiderId!);
    // Refresh the data after saving the new item
    final updatedData = await _fetchMenuData();
    setState(() {
      isAddingNewItem = false;
      futureData = Future.value(updatedData);
      menuName.clear();
    });
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
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1017),
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(color: APPCOLORS.backgroundColor),
            child: FutureBuilder(
              future: futureData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (menuItems.isEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: 200,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: const Color(0x727E83A3),
                                ),
                                child: Center(
                                    child: Text(
                                  textAlign: TextAlign.center,
                                  widget.counterName!,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                    decoration: TextDecoration.none,
                                  ),
                                )),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 29),
                                child: const Icon(
                                  color: Color(0x727E83A3),
                                  Icons.settings,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight / 4),
                        CustomStrokedButton(
                          isAdding: isAddingNewItem,
                          onPressed: () {
                            _addNewItem();
                          },
                          borderRadius: 20,
                          fontSize: 80,
                          backgroundColor: const Color(0xFF292c4c),
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
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: 200,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color: const Color(0x727E83A3),
                                  ),
                                  child: Center(
                                      child: Text(
                                    textAlign: TextAlign.center,
                                    widget.counterName!,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 23,
                                      decoration: TextDecoration.none,
                                    ),
                                  )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/counter-settings-screen",
                                        arguments: {
                                          "isFirstTime": false,
                                          "counterId": widget.insiderId
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 29),
                                    child: const Icon(
                                      color: Color(0x727E83A3),
                                      Icons.settings,
                                      size: 36,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 40),
                        ...menuItems.expand((datum) {
                          return [
                            MenuButtonNew(
                              text: datum.name,
                              onPressed: () =>
                                  {_menuItemsList(datum.id, datum.name)},
                              heightofButton: screenWidth < 600
                                  ? (screenWidth - screenWidth * 0.1017) * 0.430
                                  : (screenWidth - screenWidth * 0.1017) *
                                      0.250,
                              widthofButton: screenWidth - screenWidth * 0.1017,
                              borderRadius: 22,
                              iconIndex: datum.icon == ""
                                  ? icon.toString()
                                  : datum.icon,
                              menuNameController: menuName,
                              onIconPressed: (index) => _iconPressed(index!),
                              isIconSelected: isIconSelected,
                              isEditable: datum.id == "-1" ? true : false,
                            ),
                            const SizedBox(height: 20),
                          ];
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomStrokedButton(
                          isAdding: isAddingNewItem,
                          fontSize: isAddingNewItem ? 40 : 60,
                          borderRadius: 20,
                          onPressed: () {
                            if (isAddingNewItem) {
                              _saveNewItem();
                            } else {
                              _addNewItem();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
