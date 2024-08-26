// To parse this JSON data, do
//
//     final createEventResponse = createEventResponseFromJson(jsonString);

import 'dart:convert';

CreateEventResponse createEventResponseFromJson(String str) =>
    CreateEventResponse.fromJson(json.decode(str));

String createEventResponseToJson(CreateEventResponse data) =>
    json.encode(data.toJson());

class CreateEventResponse {
  String message;
  CreateEventData data;

  CreateEventResponse({
    required this.message,
    required this.data,
  });

  factory CreateEventResponse.fromJson(Map<String, dynamic> json) =>
      CreateEventResponse(
        message: json["message"],
        data: CreateEventData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class CreateEventData {
  String id;
  String locationName;
  String eventName;
  DateTime date;
  DateTime from;
  DateTime to;
  int ageLimit;
  String ownerId;
  List<Insider> insiders;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CreateEventData({
    required this.id,
    required this.locationName,
    required this.eventName,
    required this.date,
    required this.from,
    required this.to,
    required this.ageLimit,
    required this.ownerId,
    required this.insiders,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateEventData.fromJson(Map<String, dynamic> json) =>
      CreateEventData(
        id: json["_id"],
        locationName: json["locationName"],
        eventName: json["eventName"],
        date: DateTime.parse(json["date"]),
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        ageLimit: json["ageLimit"],
        ownerId: json["ownerId"],
        insiders: List<Insider>.from(
            json["insiders"].map((x) => Insider.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "locationName": locationName,
        "eventName": eventName,
        "date": date.toIso8601String(),
        "from": from.toIso8601String(),
        "to": to.toIso8601String(),
        "ageLimit": ageLimit,
        "ownerId": ownerId,
        "insiders": List<dynamic>.from(insiders.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Insider {
  bool isBar;
  bool isLounge;
  bool isFeedback;
  String id;
  String insiderId;

  Insider({
    required this.isBar,
    required this.isLounge,
    required this.isFeedback,
    required this.id,
    required this.insiderId,
  });

  factory Insider.fromJson(Map<String, dynamic> json) => Insider(
        isBar: json["isBar"],
        isLounge: json["isLounge"],
        isFeedback: json["isFeedback"],
        id: json["_id"],
        insiderId: json["insiderId"],
      );

  Map<String, dynamic> toJson() => {
        "isBar": isBar,
        "isLounge": isLounge,
        "isFeedback": isFeedback,
        "_id": id,
        "insiderId": insiderId,
      };
}
