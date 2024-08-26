// To parse this JSON data, do
//
//     final loginResposne = loginResposneFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResposneFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResposneToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String message;
  String token;
  UserDetails userDetails;

  LoginResponse({
    required this.message,
    required this.token,
    required this.userDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        token: json["token"],
        userDetails: UserDetails.fromJson(json["userDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "userDetails": userDetails.toJson(),
      };
}

class UserDetails {
  String id;
  String role;
  String firstName;
  String lastName;
  String email;
  String contactNumber;
  EntityDetails entityDetails;

  UserDetails({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.entityDetails,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["_id"],
        role: json["role"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        entityDetails: EntityDetails.fromJson(json["entityDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "contactNumber": contactNumber,
        "entityDetails": entityDetails.toJson(),
      };
}

class EntityDetails {
  String id;
  String entityName;
  String entityType;

  EntityDetails({
    required this.id,
    required this.entityName,
    required this.entityType,
  });

  factory EntityDetails.fromJson(Map<String, dynamic> json) => EntityDetails(
        id: json["_id"],
        entityName: json["entityName"],
        entityType: json["entityType"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "entityName": entityName,
        "entityType": entityType,
      };
}
