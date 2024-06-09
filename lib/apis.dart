import 'dart:convert';

import 'package:barfly/Storage.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/responses/CreateInsiderResponse.dart';
import 'package:barfly/responses/GetInsiderResponse.dart';
import 'package:barfly/responses/LoginResponse.dart';
import 'package:dio/dio.dart';

class apis {
  static Dio dio = Dio();
  static String APIURL = "http://192.168.10.10:2000";
  // static String APIURL = "http://43.204.181.73";
  // static String APIURL = "https://eager-rain-80700.pktriot.net";
  static var headers = {'Content-Type': 'application/json'};

  Future<ReturnObj> sendOtp(String email) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "email": email.toLowerCase(),
      });
      var dio = Dio();
      var response = await dio.request(
        '$APIURL/api/auth/send-otp',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        return ReturnObj(status: true, message: response.data["message"]);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      if (e.response != null) {
        return ReturnObj(status: false, message: e.response!.data["message"]);
      } else {
        return ReturnObj(status: false, message: e.message!);
      }
    } catch (error) {
      print("Error in Sending Otp $error");
      return ReturnObj(status: false, message: "Error in Sending Otp $error");
    }
  }

  Future<ReturnObj> register(
      String email,
      String firstName,
      String lastName,
      String password,
      String contactNumber,
      String city,
      String street,
      String zipcode,
      String productName,
      String productType,
      String otp) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      print("${ROLES.OWNER} qwaszx");
      var data = json.encode({
        "email": email.toLowerCase(),
        "role": ROLES.OWNER,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "contactNumber": contactNumber,
        "city": city,
        "street": street,
        "zipcode": zipcode,
        "productName": productName,
        "productType": productType,
        "otp": otp,
      });
      var dio = Dio();
      var response = await dio.request(
        '$APIURL/api/auth/register',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        return ReturnObj(status: true, message: response.data["message"]);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      if (e.response != null) {
        return ReturnObj(status: false, message: e.response!.data["message"]);
      } else {
        return ReturnObj(status: false, message: e.message!);
      }
    } catch (error) {
      print("Error in registration $error");
      return ReturnObj(status: false, message: "Error in Registration $error");
    }
  }

  Future<ReturnObj> login(String emailOrContactNumber, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "emailOrContactNumber": emailOrContactNumber.toLowerCase(),
        "password": password,
      });
      var dio = Dio();
      var response = await dio.request(
        '$APIURL/api/auth/login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Storage.addJwtToken(loginResponse.token);
        Storage.setUser(loginResponse.userDetails);
        return ReturnObj(status: true, message: response.data["message"]);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      return ReturnObj(status: false, message: e.response!.data["message"]);
    } catch (error) {
      print("Error in Login $error");
      return ReturnObj(status: false, message: "Error in Login $error");
    }
  }

  Future<ReturnObj<List<GetInsiderData>>> getInsiderList() async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      // headers['token'] = Storage.getJwtToken();
      headers['token'] =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response = await dio.request(
        '$APIURL/api/owner/get-insider',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        GetInsiderResponse getInsiderResponse =
            GetInsiderResponse.fromJson(response.data);
        return ReturnObj<List<GetInsiderData>>(
            message: getInsiderResponse.message,
            status: true,
            data: getInsiderResponse.data);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      if (e.response != null) {
        return ReturnObj(status: false, message: e.response!.data["message"]);
      } else {
        return ReturnObj(status: false, message: e.message!);
      }
    } catch (error) {
      print("Error in Login $error");
      return ReturnObj(status: false, message: "Error in Login $error");
    }
  }

  Future<ReturnObj<CreateInsiderData>> createInsider(
      String insiderName, String insiderType) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      // headers['token'] = Storage.getJwtToken();
      var data =
          json.encode({"insiderName": insiderName, "insiderType": insiderType});
      headers['token'] =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response = await dio.request('$APIURL/api/owner/insider',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data);

      if (response.statusCode == 200) {
        CreateInsiderResponse createInsiderResponse =
            CreateInsiderResponse.fromJson(response.data);
        return ReturnObj<CreateInsiderData>(
            message: createInsiderResponse.message,
            status: true,
            data: createInsiderResponse.data);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      if (e.response != null) {
        return ReturnObj(status: false, message: e.response!.data["message"]);
      } else {
        return ReturnObj(status: false, message: e.message!);
      }
    } catch (error) {
      print("Error in Login $error");
      return ReturnObj(status: false, message: "Error in Login $error");
    }
  }
}

class ReturnObj<T> {
  bool status;
  String message;
  T? data;
  ReturnObj({required this.message, required this.status, this.data});
}
