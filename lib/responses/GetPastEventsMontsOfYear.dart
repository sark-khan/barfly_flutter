// // To parse this JSON data, do
// //
// //     final getPastEventsMonthsYearResponse = getPastEventsMonthsYearResponseFromJson(jsonString);

import 'dart:convert';

GetPastEventsMonthsResponse getPastEventsMonthsResponseFromJson(String str) =>
    GetPastEventsMonthsResponse.fromJson(json.decode(str));

String getPastEventsMonthsResponseToJson(GetPastEventsMonthsResponse data) =>
    json.encode(data.toJson());

class GetPastEventsMonthsResponse {
  String message;
  List<PastEventsMonths> pastEventsMonths;

  GetPastEventsMonthsResponse({
    required this.message,
    required this.pastEventsMonths,
  });

  factory GetPastEventsMonthsResponse.fromJson(Map<String, dynamic> json) =>
      GetPastEventsMonthsResponse(
        message: json["message"],
        pastEventsMonths: List<PastEventsMonths>.from(
            json["pastEventsMonths"].map((x) => PastEventsMonths.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "pastEventsMonths":
            List<dynamic>.from(pastEventsMonths.map((x) => x.toJson())),
      };
}

class PastEventsMonths {
  dynamic year;
  dynamic month;

  PastEventsMonths({
    required this.year,
    required this.month,
  });

  factory PastEventsMonths.fromJson(Map<String, dynamic> json) =>
      PastEventsMonths(
        year: json["year"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
      };
}





// To parse this JSON data, do
//
//     final getPastEventsMonthsResponse = getPastEventsMonthsResponseFromJson(jsonString);

// import 'dart:convert';

// GetPastEventsMonthsResponse getPastEventsMonthsResponseFromJson(String str) =>
//     GetPastEventsMonthsResponse.fromJson(json.decode(str));

// String getPastEventsMonthsResponseToJson(GetPastEventsMonthsResponse data) =>
//     json.encode(data.toJson());

// class GetPastEventsMonthsResponse {
//   String message;
//   List<PastEventsMonths> pastEventsMonths;

//   GetPastEventsMonthsResponse({
//     required this.message,
//     required this.pastEventsMonths,
//   });

//   factory GetPastEventsMonthsResponse.fromJson(Map<String, dynamic> json) =>
//       GetPastEventsMonthsResponse(
//         message: json["message"],
//         pastEventsMonths: List<PastEventsMonths>.from(
//             json["pastEventsMonths"].map((x) => PastEventsMonths.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "pastEventsMonths":
//             List<dynamic>.from(pastEventsMonths.map((x) => x.toJson())),
//       };
// }

// class PastEventsMonths {
//   int year;

//   PastEventsMonths({
//     required this.year,
//   });

//   factory PastEventsMonths.fromJson(Map<String, dynamic> json) =>
//       PastEventsMonths(
//         year: json["year"],
//       );

//   Map<String, dynamic> toJson() => {
//         "year": year,
//       };
// }

