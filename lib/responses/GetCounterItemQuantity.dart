// To parse this JSON data, do
//
//     final getCounterListQuantity = getCounterListQuantityFromJson(jsonString);

import 'dart:convert';

GetCounterListQuantity getCounterListQuantityFromJson(String str) =>
    GetCounterListQuantity.fromJson(json.decode(str));

String getCounterListQuantityToJson(GetCounterListQuantity data) =>
    json.encode(data.toJson());

class GetCounterListQuantity {
  String message;
  List<CounterListQuantity> counterListQuantity;

  GetCounterListQuantity({
    required this.message,
    required this.counterListQuantity,
  });

  factory GetCounterListQuantity.fromJson(Map<String, dynamic> json) =>
      GetCounterListQuantity(
        message: json["message"],
        counterListQuantity: List<CounterListQuantity>.from(
            json["counterListQuantity"]
                .map((x) => CounterListQuantity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "counterListQuantity":
            List<dynamic>.from(counterListQuantity.map((x) => x.toJson())),
      };
}

class CounterListQuantity {
  String counterName;
  int availableQuantity;

  CounterListQuantity({
    required this.counterName,
    required this.availableQuantity,
  });

  factory CounterListQuantity.fromJson(Map<String, dynamic> json) =>
      CounterListQuantity(
        counterName: json["counterName"],
        availableQuantity: json["availableQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "counterName": counterName,
        "availableQuantity": availableQuantity,
      };
}
