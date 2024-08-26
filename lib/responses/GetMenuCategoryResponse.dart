// To parse this JSON data, do
//
//     final getMenuCategoryResponse = getMenuCategoryResponseFromJson(jsonString);

import 'dart:convert';

GetMenuCategoryResponse getMenuCategoryResponseFromJson(String str) =>
    GetMenuCategoryResponse.fromJson(json.decode(str));

String getMenuCategoryResponseToJson(GetMenuCategoryResponse data) =>
    json.encode(data.toJson());

class GetMenuCategoryResponse {
  String message;
  List<MenuCategory> menuCategory;

  GetMenuCategoryResponse({
    required this.message,
    required this.menuCategory,
  });

  factory GetMenuCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetMenuCategoryResponse(
        message: json["message"],
        menuCategory: List<MenuCategory>.from(
            json["menuCategory"].map((x) => MenuCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "menuCategory": List<dynamic>.from(menuCategory.map((x) => x.toJson())),
      };
}

class MenuCategory {
  String id;
  String counterId;
  String name;
  String icon;
  int v;

  MenuCategory({
    required this.id,
    required this.counterId,
    required this.name,
    required this.icon,
    required this.v,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
        id: json["_id"],
        counterId: json["counterId"],
        name: json["name"],
        icon: json["icon"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "counterId": counterId,
        "name": name,
        "icon": icon,
        "__v": v,
      };
}
