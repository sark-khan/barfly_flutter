// To parse this JSON data, do
//
//     final getParticularOrderResponse = getParticularOrderResponseFromJson(jsonString);

import 'dart:convert';

GetParticularOrderResponse getParticularOrderResponseFromJson(String str) =>
    GetParticularOrderResponse.fromJson(json.decode(str));

String getParticularOrderResponseToJson(GetParticularOrderResponse data) =>
    json.encode(data.toJson());

class GetParticularOrderResponse {
  String message;
  ParticularItemDetails particularItemDetails;

  GetParticularOrderResponse({
    required this.message,
    required this.particularItemDetails,
  });

  factory GetParticularOrderResponse.fromJson(Map<String, dynamic> json) =>
      GetParticularOrderResponse(
        message: json["message"],
        particularItemDetails:
            ParticularItemDetails.fromJson(json["particularItemDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "particularItemDetails": particularItemDetails.toJson(),
      };
}

class ParticularItemDetails {
  String id;
  int price;
  int availableQuantity;
  String currency;
  String menuCategoryId;
  String entityId;
  String counterId;
  ItemId itemId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ParticularItemDetails({
    required this.id,
    required this.price,
    required this.availableQuantity,
    required this.currency,
    required this.menuCategoryId,
    required this.entityId,
    required this.counterId,
    required this.itemId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ParticularItemDetails.fromJson(Map<String, dynamic> json) =>
      ParticularItemDetails(
        id: json["_id"],
        price: json["price"],
        availableQuantity: json["availableQuantity"],
        currency: json["currency"],
        menuCategoryId: json["menuCategoryId"],
        entityId: json["entityId"],
        counterId: json["counterId"],
        itemId: ItemId.fromJson(json["itemId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "price": price,
        "availableQuantity": availableQuantity,
        "currency": currency,
        "menuCategoryId": menuCategoryId,
        "entityId": entityId,
        "counterId": counterId,
        "itemId": itemId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class ItemId {
  String id;
  String itemName;
  String quantity;
  String description;
  String type;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ItemId({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.description,
    required this.type,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ItemId.fromJson(Map<String, dynamic> json) => ItemId(
        id: json["_id"],
        itemName: json["itemName"],
        quantity: json["quantity"],
        description: json["description"],
        type: json["type"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "itemName": itemName,
        "quantity": quantity,
        "description": description,
        "type": type,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
