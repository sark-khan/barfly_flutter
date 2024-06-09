// To parse this JSON data, do
//
//     final getMenuOfInsiderResponse = getMenuOfInsiderResponseFromJson(jsonString);

import 'dart:convert';

GetMenuOfInsiderResponse getMenuOfInsiderResponseFromJson(String str) =>
    GetMenuOfInsiderResponse.fromJson(json.decode(str));

String getMenuOfInsiderResponseToJson(GetMenuOfInsiderResponse data) =>
    json.encode(data.toJson());

class GetMenuOfInsiderResponse {
  String message;
  List<Datum> data;

  GetMenuOfInsiderResponse({
    required this.message,
    required this.data,
  });

  factory GetMenuOfInsiderResponse.fromJson(Map<String, dynamic> json) =>
      GetMenuOfInsiderResponse(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String name;
  String icon;
  String insiderId;
  List<dynamic> items;
  int v;

  Datum({
    required this.id,
    required this.name,
    required this.icon,
    required this.insiderId,
    required this.items,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
