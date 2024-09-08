// To parse this JSON data, do
//
//     final ongoingEventDetailsResponse = ongoingEventDetailsResponseFromJson(jsonString);

import 'dart:convert';

OngoingEventDetailsResponse ongoingEventDetailsResponseFromJson(String str) =>
    OngoingEventDetailsResponse.fromJson(json.decode(str));

String ongoingEventDetailsResponseToJson(OngoingEventDetailsResponse data) =>
    json.encode(data.toJson());

class OngoingEventDetailsResponse {
  String message;
  Map<String, OngoingEventDetail> ongoingEventDetails;

  OngoingEventDetailsResponse({
    required this.message,
    required this.ongoingEventDetails,
  });

  factory OngoingEventDetailsResponse.fromJson(Map<String, dynamic> json) =>
      OngoingEventDetailsResponse(
        message: json["message"],
        ongoingEventDetails: Map.from(json["ongoingEventDetails"]).map((k, v) =>
            MapEntry<String, OngoingEventDetail>(
                k, OngoingEventDetail.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "ongoingEventDetails": Map.from(ongoingEventDetails)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class OngoingEventDetail {
  String eventId;
  DateTime from;
  DateTime to;
  int totalOrders;
  String eventName;
  int activeUsers;

  OngoingEventDetail({
    required this.eventId,
    required this.from,
    required this.to,
    required this.totalOrders,
    required this.eventName,
    required this.activeUsers,
  });

  factory OngoingEventDetail.fromJson(Map<String, dynamic> json) =>
      OngoingEventDetail(
        eventId: json["eventId"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        totalOrders: json["totalOrders"],
        eventName: json["eventName"],
        activeUsers: json["activeUsers"],
      );

  Map<String, dynamic> toJson() => {
        "eventId": eventId,
        "from": from.toIso8601String(),
        "to": to.toIso8601String(),
        "totalOrders": totalOrders,
        "eventName": eventName,
        "activeUsers": activeUsers,
      };
}
