// To parse this JSON data, do
//
//     final getUpcomingEventsResponse = getUpcomingEventsResponseFromJson(jsonString);

import 'dart:convert';

GetUpcomingEventsResponse getUpcomingEventsResponseFromJson(String str) =>
    GetUpcomingEventsResponse.fromJson(json.decode(str));

String getUpcomingEventsResponseToJson(GetUpcomingEventsResponse data) =>
    json.encode(data.toJson());

class GetUpcomingEventsResponse {
  String message;
  List<UpcomingEvent> upcomingEvents;

  GetUpcomingEventsResponse({
    required this.message,
    required this.upcomingEvents,
  });

  factory GetUpcomingEventsResponse.fromJson(Map<String, dynamic> json) =>
      GetUpcomingEventsResponse(
        message: json["message"],
        upcomingEvents: List<UpcomingEvent>.from(
            json["upcomingEvents"].map((x) => UpcomingEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "upcomingEvents":
            List<dynamic>.from(upcomingEvents.map((x) => x.toJson())),
      };
}

class UpcomingEvent {
  bool isRepetitive;
  List<dynamic> repetitiveDays;
  List<String> counterIds;
  String id;
  String eventName;
  DateTime startingDate;
  DateTime endDate;
  DateTime from;
  DateTime to;
  int ageLimit;
  String ownerId;
  String entityId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  UpcomingEvent({
    required this.isRepetitive,
    required this.repetitiveDays,
    required this.counterIds,
    required this.id,
    required this.eventName,
    required this.startingDate,
    required this.endDate,
    required this.from,
    required this.to,
    required this.ageLimit,
    required this.ownerId,
    required this.entityId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UpcomingEvent.fromJson(Map<String, dynamic> json) => UpcomingEvent(
        isRepetitive: json["isRepetitive"],
        repetitiveDays:
            List<dynamic>.from(json["repetitiveDays"].map((x) => x)),
        counterIds: List<String>.from(json["counterIds"].map((x) => x)),
        id: json["_id"],
        eventName: json["eventName"],
        startingDate: DateTime.parse(json["startingDate"]),
        endDate: DateTime.parse(json["endDate"]),
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        ageLimit: json["ageLimit"],
        ownerId: json["ownerId"],
        entityId: json["entityId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "isRepetitive": isRepetitive,
        "repetitiveDays": List<dynamic>.from(repetitiveDays.map((x) => x)),
        "counterIds": List<dynamic>.from(counterIds.map((x) => x)),
        "_id": id,
        "eventName": eventName,
        "startingDate": startingDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "from": from.toIso8601String(),
        "to": to.toIso8601String(),
        "ageLimit": ageLimit,
        "ownerId": ownerId,
        "entityId": entityId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
