// To parse this JSON data, do
//
//     final getMenuItemsResponse = getMenuItemsResponseFromJson(jsonString);

import 'dart:convert';

GetMenuItemsResponse getMenuItemsResponseFromJson(String str) =>
    GetMenuItemsResponse.fromJson(json.decode(str));

String getMenuItemsResponseToJson(GetMenuItemsResponse data) =>
    json.encode(data.toJson());

class GetMenuItemsResponse {
  String message;
  List<MenuCategoryItem> menuCategoryItems;

  GetMenuItemsResponse({
    required this.message,
    required this.menuCategoryItems,
  });

  factory GetMenuItemsResponse.fromJson(Map<String, dynamic> json) =>
      GetMenuItemsResponse(
        message: json["message"],
        menuCategoryItems: List<MenuCategoryItem>.from(
            json["menuCategoryItems"].map((x) => MenuCategoryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "menuCategoryItems":
            List<dynamic>.from(menuCategoryItems.map((x) => x.toJson())),
      };
}

class MenuCategoryItem {
  String id;
  String itemName;
  int price;
  String quantity;
  String description;
  String type;
  int availableQuantity;
  String currency;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MenuCategoryItem({
    required this.id,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.description,
    required this.type,
    required this.availableQuantity,
    required this.currency,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MenuCategoryItem.fromJson(Map<String, dynamic> json) =>
      MenuCategoryItem(
        id: json["_id"],
        itemName: json["itemName"],
        price: json["price"],
        quantity: json["quantity"],
        description: json["description"],
        type: json["type"],
        availableQuantity: json["availableQuantity"],
        currency: json["currency"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "itemName": itemName,
        "price": price,
        "quantity": quantity,
        "description": description,
        "type": type,
        "availableQuantity": availableQuantity,
        "currency": currency,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
