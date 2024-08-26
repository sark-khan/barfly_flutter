// To parse this JSON data, do
//
//     final getCounterSettings = getCounterSettingsFromJson(jsonString);

import 'dart:convert';

GetCounterSettings getCounterSettingsFromJson(String str) =>
    GetCounterSettings.fromJson(json.decode(str));

String getCounterSettingsToJson(GetCounterSettings data) =>
    json.encode(data.toJson());

class GetCounterSettings {
  String message;
  CounterSettings counterSettings;

  GetCounterSettings({
    required this.message,
    required this.counterSettings,
  });

  factory GetCounterSettings.fromJson(Map<String, dynamic> json) =>
      GetCounterSettings(
        message: json["message"],
        counterSettings: CounterSettings.fromJson(json["counterSettings"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "counterSettings": counterSettings.toJson(),
      };
}

class CounterSettings {
  String id;
  String counterName;
  bool isSelfPickUp;
  bool isTableService;
  int totalTables;

  CounterSettings({
    required this.id,
    required this.counterName,
    required this.isSelfPickUp,
    required this.isTableService,
    required this.totalTables,
  });

  factory CounterSettings.fromJson(Map<String, dynamic> json) =>
      CounterSettings(
        id: json["_id"],
        counterName: json["counterName"],
        isSelfPickUp: json["isSelfPickUp"],
        isTableService: json["isTableService"],
        totalTables: json["totalTables"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "counterName": counterName,
        "isSelfPickUp": isSelfPickUp,
        "isTableService": isTableService,
        "totalTables": totalTables,
      };
}
