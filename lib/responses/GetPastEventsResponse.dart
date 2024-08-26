// To parse this JSON data, do
//
//     final getPastEventsResponse = getPastEventsResponseFromJson(jsonString);

import 'dart:convert';

GetPastEventsResponse getPastEventsResponseFromJson(String str) =>
    GetPastEventsResponse.fromJson(json.decode(str));

String getPastEventsResponseToJson(GetPastEventsResponse data) =>
    json.encode(data.toJson());

class GetPastEventsResponse {
  String message;
  List<GetPastEvents> data;

  GetPastEventsResponse({
    required this.message,
    required this.data,
  });

  factory GetPastEventsResponse.fromJson(Map<String, dynamic> json) =>
      GetPastEventsResponse(
        message: json["message"],
        data: List<GetPastEvents>.from(
            json["data"].map((x) => GetPastEvents.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetPastEvents {
  int year;
  int month;

  GetPastEvents({
    required this.year,
    required this.month,
  });

  factory GetPastEvents.fromJson(Map<String, dynamic> json) => GetPastEvents(
        year: json["year"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
      };
}
