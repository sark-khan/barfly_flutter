import 'dart:convert';

GetPastEventsYearResponse getPastEventsYearResponseFromJson(String str) =>
    GetPastEventsYearResponse.fromJson(json.decode(str));

String getPastEventsYearResponseToJson(GetPastEventsYearResponse data) =>
    json.encode(data.toJson());

class GetPastEventsYearResponse {
  String message;
  List<PastEventsYear> pastEventsYear;

  GetPastEventsYearResponse({
    required this.message,
    required this.pastEventsYear,
  });

  factory GetPastEventsYearResponse.fromJson(Map<String, dynamic> json) =>
      GetPastEventsYearResponse(
        message: json["message"],
        pastEventsYear: List<PastEventsYear>.from(
            json["pastEventsYear"].map((x) => PastEventsYear.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "pastEventsYear":
            List<dynamic>.from(pastEventsYear.map((x) => x.toJson())),
      };
}

class PastEventsYear {
  int year;

  PastEventsYear({
    required this.year,
  });

  factory PastEventsYear.fromJson(Map<String, dynamic> json) => PastEventsYear(
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
      };
}
