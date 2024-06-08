// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

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
  String productName;
  String productType;

  UserDetails({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.productName,
    required this.productType,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["_id"],
        role: json["role"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        productName: json["productName"],
        productType: json["productType"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "contactNumber": contactNumber,
        "productName": productName,
        "productType": productType,
      };
}
