// To parse this JSON data, do
//
//     final getPastEventsDetailsMonthsResponse = getPastEventsDetailsMonthsResponseFromJson(jsonString);

import 'dart:convert';

GetPastEventsDetailsMonthsResponse getPastEventsDetailsMonthsResponseFromJson(
        String str) =>
    GetPastEventsDetailsMonthsResponse.fromJson(json.decode(str));

String getPastEventsDetailsMonthsResponseToJson(
        GetPastEventsDetailsMonthsResponse data) =>
    json.encode(data.toJson());

class GetPastEventsDetailsMonthsResponse {
  String message;
  List<MonthlyEventDetail> monthlyEventDetails;

  GetPastEventsDetailsMonthsResponse({
    required this.message,
    required this.monthlyEventDetails,
  });

  factory GetPastEventsDetailsMonthsResponse.fromJson(
          Map<String, dynamic> json) =>
      GetPastEventsDetailsMonthsResponse(
        message: json["message"],
        monthlyEventDetails: List<MonthlyEventDetail>.from(
            json["monthlyEventDetails"]
                .map((x) => MonthlyEventDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "monthlyEventDetails":
            List<dynamic>.from(monthlyEventDetails.map((x) => x.toJson())),
      };
}

class MonthlyEventDetail {
  String id;
  String name;
  int totalOrders;
  DateTime eventDate;
  int totalAmount;
  List<Order> orders;

  MonthlyEventDetail(
      {required this.id,
      required this.name,
      required this.totalOrders,
      required this.totalAmount,
      required this.orders,
      required this.eventDate});

  factory MonthlyEventDetail.fromJson(Map<String, dynamic> json) =>
      MonthlyEventDetail(
        id: json["id"],
        name: json["name"],
        totalOrders: json["totalOrders"],
        totalAmount: json["totalAmount"],
        eventDate: DateTime.parse(json["eventDate"]),
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "totalOrders": totalOrders,
        "totalAmount": totalAmount,
        "eventDate": eventDate.toIso8601String(),
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  String id;
  String status;
  List<Item> items;
  int tokenNumber;
  String userId;
  String entityId;
  DateTime createdAt;
  DateTime updatedAt;
  int totalAmount;

  Order({
    required this.id,
    required this.status,
    required this.items,
    required this.tokenNumber,
    required this.userId,
    required this.entityId,
    required this.createdAt,
    required this.updatedAt,
    required this.totalAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        status: json["status"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        tokenNumber: json["tokenNumber"],
        userId: json["userId"],
        entityId: json["entityId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "tokenNumber": tokenNumber,
        "userId": userId,
        "entityId": entityId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "totalAmount": totalAmount,
      };
}

class Item {
  String id;
  String itemId;
  int quantity;

  Item({
    required this.id,
    required this.itemId,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        itemId: json["itemId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "itemId": itemId,
        "quantity": quantity,
      };
}
