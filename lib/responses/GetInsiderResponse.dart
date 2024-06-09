// To parse this JSON data, do
//
//     final getInsiderResponse = getInsiderResponseFromJson(jsonString);

import 'dart:convert';

GetInsiderResponse getInsiderResponseFromJson(String str) =>
    GetInsiderResponse.fromJson(json.decode(str));

String getInsiderResponseToJson(GetInsiderResponse data) =>
    json.encode(data.toJson());

class GetInsiderResponse {
  String message;
  List<GetInsiderData> data;

  GetInsiderResponse({
    required this.message,
    required this.data,
  });

  factory GetInsiderResponse.fromJson(Map<String, dynamic> json) =>
      GetInsiderResponse(
        message: json["message"],
        data: List<GetInsiderData>.from(
            json["data"].map((x) => GetInsiderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetInsiderData {
  String id;
  String insiderName;
  String insiderType;
  DateTime updatedAt;

  GetInsiderData({
    required this.id,
    required this.insiderName,
    required this.insiderType,
    required this.updatedAt,
  });

  factory GetInsiderData.fromJson(Map<String, dynamic> json) => GetInsiderData(
        id: json["_id"],
        insiderName: json["insiderName"],
        insiderType: json["insiderType"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "insiderName": insiderName,
        "insiderType": insiderType,
        "updatedAt": updatedAt.toIso8601String(),
      };
}
