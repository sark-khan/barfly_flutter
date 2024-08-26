// To parse this JSON data, do
//
//     final getOrdersEntityResponse = getOrdersEntityResponseFromJson(jsonString);

import 'dart:convert';

GetOrdersEntityResponse getOrdersEntityResponseFromJson(String str) =>
    GetOrdersEntityResponse.fromJson(json.decode(str));

String getOrdersEntityResponseToJson(GetOrdersEntityResponse data) =>
    json.encode(data.toJson());

class GetOrdersEntityResponse {
  String message;
  List<OrderDetail> orderDetails;
  int totalCount;

  GetOrdersEntityResponse({
    required this.message,
    required this.orderDetails,
    required this.totalCount,
  });

  factory GetOrdersEntityResponse.fromJson(Map<String, dynamic> json) =>
      GetOrdersEntityResponse(
        message: json["message"],
        orderDetails: List<OrderDetail>.from(
            json["orderDetails"].map((x) => OrderDetail.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "orderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class OrderDetail {
  String id;
  String status;
  List<Item> items;
  int tokenNumber;

  OrderDetail({
    required this.id,
    required this.status,
    required this.items,
    required this.tokenNumber,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["_id"],
        status: json["status"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        tokenNumber: json["tokenNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "tokenNumber": tokenNumber,
      };
}

class Item {
  String id;
  ItemItemId itemId;
  int quantity;

  Item({
    required this.id,
    required this.itemId,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        itemId: ItemItemId.fromJson(json["itemId"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "itemId": itemId.toJson(),
        "quantity": quantity,
      };
}

class ItemItemId {
  String id;
  String currency;
  ItemIdItemId itemId;

  ItemItemId({
    required this.id,
    required this.currency,
    required this.itemId,
  });

  factory ItemItemId.fromJson(Map<String, dynamic> json) => ItemItemId(
        id: json["_id"],
        currency: json["currency"],
        itemId: ItemIdItemId.fromJson(json["itemId"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "currency": currency,
        "itemId": itemId.toJson(),
      };
}

class ItemIdItemId {
  String id;
  String itemName;
  String quantity;
  String description;
  String type;
  String image;

  ItemIdItemId({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.description,
    required this.type,
    required this.image,
  });

  factory ItemIdItemId.fromJson(Map<String, dynamic> json) => ItemIdItemId(
        id: json["_id"],
        itemName: json["itemName"],
        quantity: json["quantity"],
        description: json["description"],
        type: json["type"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "itemName": itemName,
        "quantity": quantity,
        "description": description,
        "type": type,
        "image": image,
      };
}
