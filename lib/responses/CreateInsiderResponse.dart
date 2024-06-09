// To parse this JSON data, do
//
//     final createInsiderResponse = createInsiderResponseFromJson(jsonString);

import 'dart:convert';

CreateInsiderResponse createInsiderResponseFromJson(String str) =>
    CreateInsiderResponse.fromJson(json.decode(str));

String createInsiderResponseToJson(CreateInsiderResponse data) =>
    json.encode(data.toJson());

class CreateInsiderResponse {
  String message;
  CreateInsiderData data;

  CreateInsiderResponse({
    required this.message,
    required this.data,
  });

  factory CreateInsiderResponse.fromJson(Map<String, dynamic> json) =>
      CreateInsiderResponse(
        message: json["message"],
        data: CreateInsiderData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class CreateInsiderData {
  String id;
  String insiderName;
  String insiderType;
  String ownerId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CreateInsiderData({
    required this.id,
    required this.insiderName,
    required this.insiderType,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateInsiderData.fromJson(Map<String, dynamic> json) =>
      CreateInsiderData(
        id: json["_id"],
        insiderName: json["insiderName"],
        insiderType: json["insiderType"],
        ownerId: json["ownerId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "insiderName": insiderName,
        "insiderType": insiderType,
        "ownerId": ownerId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
