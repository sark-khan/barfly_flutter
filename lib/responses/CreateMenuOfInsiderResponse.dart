// To parse this JSON data, do
//
//     final createMenuOfInsiderResponse = createMenuOfInsiderResponseFromJson(jsonString);

import 'dart:convert';

CreateMenuOfInsiderResponse createMenuOfInsiderResponseFromJson(String str) =>
    CreateMenuOfInsiderResponse.fromJson(json.decode(str));

String createMenuOfInsiderResponseToJson(CreateMenuOfInsiderResponse data) =>
    json.encode(data.toJson());

class CreateMenuOfInsiderResponse {
  String message;
  CreateMenuOfInsiderData data;

  CreateMenuOfInsiderResponse({
    required this.message,
    required this.data,
  });

  factory CreateMenuOfInsiderResponse.fromJson(Map<String, dynamic> json) =>
      CreateMenuOfInsiderResponse(
        message: json["message"],
        data: CreateMenuOfInsiderData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class CreateMenuOfInsiderData {
  String id;
  String name;
  String icon;
  String insiderId;
  List<dynamic> items;
  int v;

  CreateMenuOfInsiderData({
    required this.id,
    required this.name,
    required this.icon,
    required this.insiderId,
    required this.items,
    required this.v,
  });

  factory CreateMenuOfInsiderData.fromJson(Map<String, dynamic> json) =>
      CreateMenuOfInsiderData(
        id: json["_id"],
        name: json["name"],
        icon: json["icon"],
        insiderId: json["insiderId"],
        items: List<dynamic>.from(json["items"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "icon": icon,
        "insiderId": insiderId,
        "items": List<dynamic>.from(items.map((x) => x)),
        "__v": v,
      };
}
