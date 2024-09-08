import 'dart:convert';
import 'dart:io' as io;
import 'dart:html' as html;
import 'package:barfly/Storage.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/responses/CreateInsiderResponse.dart';
import 'package:barfly/responses/CreateMenuOfInsiderResponse.dart';
import 'package:barfly/responses/GetCounterResponse.dart';
import 'package:barfly/responses/GetCounterSettings.dart';
import 'package:barfly/responses/GetEventMonthlyDetailsResponse.dart';
import 'package:barfly/responses/GetItemsOfMenuResponse.dart';
import 'package:barfly/responses/GetMenuCategoryResponse.dart';
import 'package:barfly/responses/GetOngoingEventDetails.dart';
import 'package:barfly/responses/GetOrderDetails.dart';
import 'package:barfly/responses/GetPastEventsMontsOfYear.dart';
import 'package:barfly/responses/GetPastEventsResponse.dart';
import 'package:barfly/responses/GetUpcomingEventsResponse.dart';
import 'package:barfly/responses/LoginResponse.dart';
import 'package:barfly/responses/get_particular_order_resposne.dart';
import 'package:barfly/screens/GetCounterListQuantity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
        '$APIURL/api/owner/auth/login',
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

  Future<ReturnObj<List<Counter>>> getInsiderList() async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTdjNTAyZDBjMjgxMmU0ZTFhYTU1MyIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiZGVlcGFrMTIzNEBvd25lci5jb20iLCJjb250YWN0TnVtYmVyIjoiMTIzNDU2Nzg5MCIsImVudGl0eU5hbWUiOiJZb3VyIEVudGl0eSBOYW1lIiwiZW50aXR5VHlwZSI6IkJhciIsImVudGl0eUlkIjoiNjY5N2M1MDJkMGMyODEyZTRlMWFhNTU0IiwiaWF0IjoxNzIyNzU4MjIzfQ.Gz6kIes_elkvlJvrSWDTkjMaiSKcUtyackeTICzdU-0";
      var dio = Dio();
      var response = await dio.request(
        '$APIURL/api/owner/get-counter',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        GetCounterResponse getInsiderResponse =
            GetCounterResponse.fromJson(response.data);
        return ReturnObj<List<Counter>>(
            message: getInsiderResponse.message,
            status: true,
            data: getInsiderResponse.counter);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      if (e.response != null) {
        return ReturnObj(status: false, message: e.response!.data["message"]);
      } else {
        return ReturnObj(status: false, message: e.message!);
      }
    } catch (error) {
      print("Error in get Insider List $error");
      return ReturnObj(
          status: false, message: "Error in get Insider List $error");
    }
  }

  Future<ReturnObj<CreateInsiderData>> createCounter(
      CounterSettings counterSettings) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      var data = json.encode({
        'counterName': counterSettings.counterName,
        'isSelfPickUp': counterSettings.isSelfPickUp,
        'isTableService': counterSettings.isTableService,
        'totalTables': counterSettings.totalTables,
      });
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response =
          await dio.request('$APIURL/api/owner/create-counter-with-settings',
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
      print("Error in create Counter $error");
      return ReturnObj(status: false, message: "Error in Login $error");
    }
  }

  Future<ReturnObj<List<MenuCategory>>> getMenuList(counterId) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      Map<String, dynamic> data = {"counterId": counterId};
      var response = await dio.request('$APIURL/api/owner/get-menu-category',
          options: Options(
            method: 'GET',
            headers: headers,
          ),
          queryParameters: data);

      if (response.statusCode == 200) {
        GetMenuCategoryResponse getMenuofInsiderResponse =
            GetMenuCategoryResponse.fromJson(response.data);
        return ReturnObj<List<MenuCategory>>(
            message: getMenuofInsiderResponse.message,
            status: true,
            data: getMenuofInsiderResponse.menuCategory);
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

  Future<ReturnObj<CreateMenuOfInsiderData>> createMenuOfInsider(
      String menuName, String menuIcon, String insiderId) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      var data = json
          .encode({"name": menuName, "icon": menuIcon, "counterId": insiderId});
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response =
          await dio.request('$APIURL/api/owner/create-counter-menu-category',
              options: Options(
                method: 'POST',
                headers: headers,
              ),
              data: data);

      if (response.statusCode == 200) {
        CreateMenuOfInsiderResponse createMenuOfInsiderResponse =
            CreateMenuOfInsiderResponse.fromJson(response.data);
        return ReturnObj<CreateMenuOfInsiderData>(
            message: createMenuOfInsiderResponse.message,
            status: true,
            data: createMenuOfInsiderResponse.data);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      if (e.response != null) {
        return ReturnObj(status: false, message: e.response!.data["message"]);
      } else {
        return ReturnObj(status: false, message: e.message!);
      }
    } catch (error) {
      print("Error in create menu of Insider $error");
      return ReturnObj(
          status: false, message: "Error in create menu of Insider $error");
    }
  }

  Future<ReturnObj<List<MenuCategoryItem>>> getItemsOfMenu(
      String menuCategoryId) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      headers['token'] =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTdjNTAyZDBjMjgxMmU0ZTFhYTU1MyIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiZGVlcGFrMTIzNEBvd25lci5jb20iLCJjb250YWN0TnVtYmVyIjoiMTIzNDU2Nzg5MCIsImVudGl0eU5hbWUiOiJZb3VyIEVudGl0eSBOYW1lIiwiZW50aXR5VHlwZSI6IkJhciIsImVudGl0eUlkIjoiNjY5N2M1MDJkMGMyODEyZTRlMWFhNTU0IiwiaWF0IjoxNzI0MDgyNjAzfQ.EdDBMcLe8Rvb6XK2_8zKAW-N-d8M6ua9cmacGgonLYM";
      var dio = Dio();
      Map<String, dynamic> data = {"menuCategoryId": menuCategoryId};
      var response =
          await dio.request('$APIURL/api/owner/get-menu-category-items',
              options: Options(
                method: 'GET',
                headers: headers,
              ),
              queryParameters: data);

      if (response.statusCode == 200) {
        GetMenuItemsResponse getItemsOfMenuResponse =
            GetMenuItemsResponse.fromJson(response.data);
        return ReturnObj<List<MenuCategoryItem>>(
            message: getItemsOfMenuResponse.message,
            status: true,
            data: getItemsOfMenuResponse.menuCategoryItems);
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

  Future<ReturnObj> createItemOfMenu(
    String itemName,
    String type,
    String quantity,
    String price,
    String description,
    String currency,
    String menuCategoryId,
    String availableQuantity,
    bool isNew,
    String itemId,
    html.File imageFile,
  ) async {
    try {
      headers['token'] = Storage.getJwtToken();
      String uri = '$APIURL/api/owner/create-menu-items';
      if (!isNew) uri = '$APIURL/api/owner/update-menu-item';

      var dio = Dio();
      print("reached erhererererererer 1");
      if (true) {
        // Uint8List fileBytes = await imageFile.readAsBytes();

        // // Create a Blob from the bytes
        // html.Blob blob = html.Blob([fileBytes]);
        // Web-specific code
        print("reached ehrer");
        var formData = html.FormData();
        formData.append('itemName', itemName);
        formData.append('description', description);
        formData.append('quantity', "100 $quantity");
        formData.append('price', price);
        formData.append('menuCategoryId', menuCategoryId);
        formData.append('availableQuantity', availableQuantity);
        formData.append('type', type);
        formData.append('currency', currency);
        formData.append('itemId', itemId);
        formData.appendBlob('file', imageFile, '$itemName.png');

        // Send request using Html HttpRequest
        var request = html.HttpRequest();
        request.open('POST', uri);
        request.setRequestHeader('token', Storage.getJwtToken());
        request.send(formData);

        await request.onLoadEnd.first;

        if (request.status == 200) {
          return ReturnObj(message: "Item Created Successfully", status: true);
        } else {
          return ReturnObj(status: false, message: "Error in here");
        }
      } else if (!kIsWeb && imageFile is io.File) {
        // Mobile-specific code
        //   var formData = FormData.fromMap({
        //     "itemName": itemName,
        //     "description": description,
        //     "quantity": "100 $quantity",
        //     "price": price,
        //     "menuCategoryId": menuCategoryId,
        //     "availableQuantity": availableQuantity,
        //     "type": type,
        //     "currency": currency,
        //     "itemId": itemId,
        //     "file": await MultipartFile.fromFile(imageFile.path,
        //         filename: "$itemName.png"),
        //   });

        //   var response = await dio.post(uri,
        //       options: Options(headers: headers), data: formData);

        //   if (response.statusCode == 200) {
        //     return ReturnObj(message: "Item Created Successfully", status: true);
        //   } else {
        //     return ReturnObj(status: false, message: response.data["message"]);
        //   }
        // } else {
        return ReturnObj(
            status: false, message: "Unsupported platform or file type");
      }
    } on DioException catch (e) {
      return ReturnObj(
          status: false, message: e.response?.data["message"] ?? e.message!);
    } catch (error) {
      return ReturnObj(
          status: false, message: "Error in create menu of Insider $error");
    }
  }

  Future<ReturnObj> createEvent(var data) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // var data = json.encode({
      // "itemName": itemName,
      // "quantity": quantity,
      // "price": price,
      // "barId": barId,
      //   "image": "hehe",
      //   "type": "Drink"
      // });
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response = await dio.request('$APIURL/api/owner/create-event',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data);

      if (response.statusCode == 200) {
        return ReturnObj(message: "Event Created Successfully", status: true);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      if (e.response != null) {
        return ReturnObj(status: false, message: e.response!.data["message"]);
      } else {
        return ReturnObj(status: false, message: e.message!);
      }
    } catch (error) {
      print("Error in create menu of Insider $error");
      return ReturnObj(
          status: false, message: "Error in create menu of Insider $error");
    }
  }

  Future<ReturnObj<List<UpcomingEvent>>> GetUpcomingEventsApi() async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response = await dio.request(
        '$APIURL/api/owner/get-upcoming-events',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        GetUpcomingEventsResponse getUpcomingEventsResponse =
            GetUpcomingEventsResponse.fromJson(response.data);
        return ReturnObj<List<UpcomingEvent>>(
            message: getUpcomingEventsResponse.message,
            status: true,
            data: getUpcomingEventsResponse.upcomingEvents);
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

  Future<ReturnObj<List<PastEventsYear>>> GetPastEventsApi() async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response = await dio.request(
        '$APIURL/api/owner/get-past-events-years',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        GetPastEventsYearResponse getPastEventsResponse =
            GetPastEventsYearResponse.fromJson(response.data);
        return ReturnObj<List<PastEventsYear>>(
            message: getPastEventsResponse.message,
            status: true,
            data: getPastEventsResponse.pastEventsYear);
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

  Future<ReturnObj<List<PastEventsMonths>>> getPastEventsMonths(
      String year) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response =
          await dio.request('$APIURL/api/owner/get-past-events-year-month',
              options: Options(
                method: 'GET',
                headers: headers,
              ),
              queryParameters: {"year": year});

      if (response.statusCode == 200) {
        GetPastEventsMonthsResponse getPastEventsResponse =
            GetPastEventsMonthsResponse.fromJson(response.data);
        return ReturnObj<List<PastEventsMonths>>(
            message: getPastEventsResponse.message,
            status: true,
            data: getPastEventsResponse.pastEventsMonths);
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

  Future<ReturnObj<List<MonthlyEventDetail>>> getEventsMonthlyDetails(
      String year, String month) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      var response =
          await dio.request('$APIURL/api/owner/get-event-details-monthly',
              options: Options(
                method: 'GET',
                headers: headers,
              ),
              queryParameters: {"year": year, "month": month});

      if (response.statusCode == 200) {
        GetPastEventsDetailsMonthsResponse getPastEventsResponse =
            GetPastEventsDetailsMonthsResponse.fromJson(response.data);
        return ReturnObj<List<MonthlyEventDetail>>(
            message: getPastEventsResponse.message,
            status: true,
            data: getPastEventsResponse.monthlyEventDetails);
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

  Future<ReturnObj<List<CounterListQuantity>>> GetCounterListQuantityApi(
      String itemId) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTdjNTAyZDBjMjgxMmU0ZTFhYTU1MyIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiZGVlcGFrMTIzNEBvd25lci5jb20iLCJjb250YWN0TnVtYmVyIjoiMTIzNDU2Nzg5MCIsImVudGl0eU5hbWUiOiJZb3VyIEVudGl0eSBOYW1lIiwiZW50aXR5VHlwZSI6IkJhciIsImVudGl0eUlkIjoiNjY5N2M1MDJkMGMyODEyZTRlMWFhNTU0IiwiaWF0IjoxNzIyNzU4MjIzfQ.Gz6kIes_elkvlJvrSWDTkjMaiSKcUtyackeTICzdU-0";
      var dio = Dio();
      var response =
          await dio.request('$APIURL/api/owner/get-counter-list-quantity',
              options: Options(
                method: 'GET',
                headers: headers,
              ),
              queryParameters: {"itemId": itemId});

      if (response.statusCode == 200) {
        GetCounterListQuantity getCounterListQuantity =
            GetCounterListQuantity.fromJson(response.data);
        return ReturnObj<List<CounterListQuantity>>(
            message: getCounterListQuantity.message,
            status: true,
            data: getCounterListQuantity.counterListQuantity);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } on DioException catch (e) {
      if (e.response != null) {
        return ReturnObj(status: false, message: e.response!.data["message"]);
      } else {
        return ReturnObj(status: false, message: e.message!);
      }
    } catch (error) {
      print("Error in gt counter list quantity ${error.toString()}");
      return ReturnObj(status: false, message: "Error in Login $error");
    }
  }

  Future<ReturnObj<CounterSettings>> getCounterSettings(
      String counterId) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTdjNTAyZDBjMjgxMmU0ZTFhYTU1MyIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiZGVlcGFrMTIzNEBvd25lci5jb20iLCJjb250YWN0TnVtYmVyIjoiMTIzNDU2Nzg5MCIsImVudGl0eU5hbWUiOiJZb3VyIEVudGl0eSBOYW1lIiwiZW50aXR5VHlwZSI6IkJhciIsImVudGl0eUlkIjoiNjY5N2M1MDJkMGMyODEyZTRlMWFhNTU0IiwiaWF0IjoxNzIyNzU4MjIzfQ.Gz6kIes_elkvlJvrSWDTkjMaiSKcUtyackeTICzdU-0";
      var dio = Dio();
      var response = await dio.request('$APIURL/api/owner/get-counter-settings',
          options: Options(
            method: 'GET',
            headers: headers,
          ),
          queryParameters: {"counterId": counterId});

      if (response.statusCode == 200) {
        GetCounterSettings getCounterSettings =
            GetCounterSettings.fromJson(response.data);
        return ReturnObj<CounterSettings>(
            message: getCounterSettings.message,
            status: true,
            data: getCounterSettings.counterSettings);
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

  Future<ReturnObj> updateCounterSettings(
      CounterSettings counterSettings) async {
    try {
      headers['token'] = Storage.getJwtToken();
      headers['token'] =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTdjNTAyZDBjMjgxMmU0ZTFhYTU1MyIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiZGVlcGFrMTIzNEBvd25lci5jb20iLCJjb250YWN0TnVtYmVyIjoiMTIzNDU2Nzg5MCIsImVudGl0eU5hbWUiOiJZb3VyIEVudGl0eSBOYW1lIiwiZW50aXR5VHlwZSI6IkJhciIsImVudGl0eUlkIjoiNjY5N2M1MDJkMGMyODEyZTRlMWFhNTU0IiwiaWF0IjoxNzIyNzU4MjIzfQ.Gz6kIes_elkvlJvrSWDTkjMaiSKcUtyackeTICzdU-0";
      var dio = Dio();
      var data = {
        'counterId': counterSettings.id,
        'counterName': counterSettings.counterName,
        'isSelfPickUp': counterSettings.isSelfPickUp,
        'isTableService': counterSettings.isTableService,
        'totalTables': counterSettings.totalTables,
      };
      var response =
          await dio.request('$APIURL/api/owner/update-counter-settings',
              options: Options(
                method: 'POST',
                headers: headers,
              ),
              data: data);

      if (response.statusCode == 200) {
        return ReturnObj(
          message: response.data["message"],
          status: true,
        );
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

  Future<ReturnObj<ParticularItemDetails>> getParticularOrder(
      menuItemId) async {
    try {
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ3OTllODY5ZmViOGU0NjY4ZWIxZCIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiam9obkBjZW5hLmNvbSIsImNvbnRhY3ROdW1iZXIiOiIxMjM0NTY3ODkwIiwicHJvZHVjdE5hbWUiOiJjbHViIGhvdXNlIiwicHJvZHVjdFR5cGUiOiJDbHViIiwiaWF0IjoxNzE3OTQ0MjEwfQ.GmhSDjtb3ksiMwTvGSKYUEq5SWC88Dzs7ilpCAFo7Q0";
      var dio = Dio();
      Map<String, dynamic> data = {"menuItemId": menuItemId};
      var response =
          await dio.request('$APIURL/api/owner/get-menu-particular-item',
              options: Options(
                method: 'GET',
                headers: headers,
              ),
              queryParameters: data);

      if (response.statusCode == 200) {
        GetParticularOrderResponse getMenuofInsiderResponse =
            GetParticularOrderResponse.fromJson(response.data);
        return ReturnObj<ParticularItemDetails>(
            message: getMenuofInsiderResponse.message,
            status: true,
            data: getMenuofInsiderResponse.particularItemDetails);
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

  Future<ReturnObj<List<OrderDetail>>> getLiveOrderDetails() async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTdjNTAyZDBjMjgxMmU0ZTFhYTU1MyIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiZGVlcGFrMTIzNEBvd25lci5jb20iLCJjb250YWN0TnVtYmVyIjoiMTIzNDU2Nzg5MCIsImVudGl0eU5hbWUiOiJZb3VyIEVudGl0eSBOYW1lIiwiZW50aXR5VHlwZSI6IkJhciIsImVudGl0eUlkIjoiNjY5N2M1MDJkMGMyODEyZTRlMWFhNTU0IiwiaWF0IjoxNzI0MDgyNjAzfQ.EdDBMcLe8Rvb6XK2_8zKAW-N-d8M6ua9cmacGgonLYM";
      var dio = Dio();
      // Map<String, dynamic> data = {"status": "Waiting"};
      var response = await dio.request(
        '$APIURL/api/orders/get-entity-orders',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        // queryParameters: data
      );

      if (response.statusCode == 200) {
        GetOrdersEntityResponse getOrdersEntityResponse =
            GetOrdersEntityResponse.fromJson(response.data);
        return ReturnObj<List<OrderDetail>>(
            message: getOrdersEntityResponse.message,
            status: true,
            data: getOrdersEntityResponse.orderDetails);
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

  Future<ReturnObj<Map<String, OngoingEventDetail>>>
      getOngoingEventDetails() async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTdjNTAyZDBjMjgxMmU0ZTFhYTU1MyIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiZGVlcGFrMTIzNEBvd25lci5jb20iLCJjb250YWN0TnVtYmVyIjoiMTIzNDU2Nzg5MCIsImVudGl0eU5hbWUiOiJZb3VyIEVudGl0eSBOYW1lIiwiZW50aXR5VHlwZSI6IkJhciIsImVudGl0eUlkIjoiNjY5N2M1MDJkMGMyODEyZTRlMWFhNTU0IiwiaWF0IjoxNzI0MDgyNjAzfQ.EdDBMcLe8Rvb6XK2_8zKAW-N-d8M6ua9cmacGgonLYM";
      var dio = Dio();
      // Map<String, dynamic> data = {"status": "Waiting"};
      var response = await dio.request(
        '$APIURL/api/owner/get-ongoing-event-details',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        // queryParameters: data
      );

      if (response.statusCode == 200) {
        OngoingEventDetailsResponse ongoingEventDetailsResponse =
            OngoingEventDetailsResponse.fromJson(response.data);
        return ReturnObj<Map<String, OngoingEventDetail>>(
            message: ongoingEventDetailsResponse.message,
            status: true,
            data: ongoingEventDetailsResponse.ongoingEventDetails);
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

  Future<ReturnObj> updateStatusOfOrder(String status, String orderId) async {
    try {
      headers['token'] = Storage.getJwtToken();
      // headers['token'] =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2OTdjNTAyZDBjMjgxMmU0ZTFhYTU1MyIsInJvbGUiOiJPd25lciIsImVtYWlsIjoiZGVlcGFrMTIzNEBvd25lci5jb20iLCJjb250YWN0TnVtYmVyIjoiMTIzNDU2Nzg5MCIsImVudGl0eU5hbWUiOiJZb3VyIEVudGl0eSBOYW1lIiwiZW50aXR5VHlwZSI6IkJhciIsImVudGl0eUlkIjoiNjY5N2M1MDJkMGMyODEyZTRlMWFhNTU0IiwiaWF0IjoxNzIyNzU4MjIzfQ.Gz6kIes_elkvlJvrSWDTkjMaiSKcUtyackeTICzdU-0";
      var dio = Dio();
      var data = {
        'orderId': orderId,
        "status": status
        // 'counterName': counterSettings.counterName,
        // 'isSelfPickUp': counterSettings.isSelfPickUp,
        // 'isTableService': counterSettings.isTableService,
        // 'totalTables': counterSettings.totalTables,
      };
      var response =
          await dio.request('$APIURL/api/orders/update-status-of-order',
              options: Options(
                method: 'POST',
                headers: headers,
              ),
              data: data);

      if (response.statusCode == 200) {
        return ReturnObj(
          message: response.data["message"],
          status: true,
        );
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
