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
  String entityId;
  String counterName;
  int v;
  bool isSelfPickUp;
  bool isTableService;
  int totalTables;

  CreateInsiderData({
    required this.id,
    required this.entityId,
    required this.counterName,
    required this.v,
    required this.isSelfPickUp,
    required this.isTableService,
    required this.totalTables,
  });

  factory CreateInsiderData.fromJson(Map<String, dynamic> json) =>
      CreateInsiderData(
        id: json["_id"],
        entityId: json["entityId"],
        counterName: json["counterName"],
        v: json["__v"],
        isSelfPickUp: json["isSelfPickUp"],
        isTableService: json["isTableService"],
        totalTables: json["totalTables"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "entityId": entityId,
        "counterName": counterName,
        "__v": v,
        "isSelfPickUp": isSelfPickUp,
        "isTableService": isTableService,
        "totalTables": totalTables,
      };
}
