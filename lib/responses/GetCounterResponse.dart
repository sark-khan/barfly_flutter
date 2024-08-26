// To parse this JSON data, do
//
//     final getCounterResponse = getCounterResponseFromJson(jsonString);

import 'dart:convert';

GetCounterResponse getCounterResponseFromJson(String str) =>
    GetCounterResponse.fromJson(json.decode(str));

String getCounterResponseToJson(GetCounterResponse data) =>
    json.encode(data.toJson());

class GetCounterResponse {
  String message;
  List<Counter> counter;

  GetCounterResponse({
    required this.message,
    required this.counter,
  });

  factory GetCounterResponse.fromJson(Map<String, dynamic> json) =>
      GetCounterResponse(
        message: json["message"],
        counter:
            List<Counter>.from(json["counter"].map((x) => Counter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "counter": List<dynamic>.from(counter.map((x) => x.toJson())),
      };
}

class Counter {
  String id;
  String counterName;
  DateTime updatedAt;

  Counter({
    required this.id,
    required this.counterName,
    required this.updatedAt,
  });

  factory Counter.fromJson(Map<String, dynamic> json) => Counter(
        id: json["_id"],
        counterName: json["counterName"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "counterName": counterName,
        "updatedAt": updatedAt.toIso8601String(),
      };
}
