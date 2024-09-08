import 'package:barfly/components/Buttons.dart';
import 'package:barfly/responses/GetCounterSettings.dart';
import 'package:barfly/screens/AccountDetailsScreen.dart';
import 'package:barfly/screens/AddNewItemsInMenu.dart';
import 'package:barfly/screens/BussinessDetailsScreen.dart';
import 'package:barfly/screens/EntryScreen.dart';
import 'package:barfly/screens/EventsCreationFormScreen.dart';
import 'package:barfly/screens/HomeScreen.dart';
import 'package:barfly/screens/InsiderScreen.dart';
import 'package:barfly/screens/InsiderSelectorScreen.dart';
import 'package:barfly/screens/LoginScreen.dart';
import 'package:barfly/screens/MenuItemScreen.dart';
import 'package:barfly/screens/MenuScreen.dart';
import 'package:barfly/screens/OtpVerificationScreen.dart';
import 'package:barfly/screens/PastEventsScreen.dart';
import 'package:barfly/screens/UpcomingEventsScreen.dart';
import 'package:barfly/screens/add_quantity_items_screen.dart';
import 'package:barfly/screens/add_repetitive_screen.dart';
import 'package:barfly/screens/event_creation_screen.dart';
import 'package:barfly/screens/item_list_stock.dart';
import 'package:barfly/screens/live_orders_screen.dart';
import 'package:barfly/screens/past_event_monthly.dart';
import 'package:barfly/screens/past_event_monthly_details_screen.dart';
import 'package:barfly/screens/setting_screen_counter.dart';
import 'package:barfly/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/entry-screen',
      page: () => EntryScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/splash-screen',
      page: () => SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/login-screen',
      page: () => LoginScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/bussiness-details-screen',
      page: () => BussinessDetailsScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/account-details-screen',
      page: () => AccountDetailsScreen(
        productType: Get.arguments["productType"],
        // Uncomment or add any additional parameters if needed
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/otp-screen',
      page: () => OtpverificationScreen(
        productType: Get.arguments["productType"],
        firstName: Get.arguments["firstName"],
        lastName: Get.arguments["lastName"],
        email: Get.arguments["email"],
        contactNumber: Get.arguments["contactNumber"],
        city: Get.arguments["city"],
        street: Get.arguments["street"],
        zipcode: Get.arguments["zipcode"],
        productName: Get.arguments["productName"],
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/insider-screen',
      page: () => InsiderScreen(),
      transition: Transition.fade,
    ),
    // GetPage(
    //   name: '/insider-selector-screen',
    //   page: () => InsiderSelectorScreen(
    //     insiderCount: Get.arguments?["insiderCount"] ?? 1,
    //   ),
    //   transition: Transition.fade,
    // ),
    GetPage(
      name: '/add-quantity-screen',
      page: () => AddQuantityItemsScreen(
        itemId: "66c1df98b19ea52d2989633a",
        nameOfItem: "French Fries",
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/counter-settings-screen',
      page: () => SettingScreenCounter(
        isFirstTime: Get.arguments["isFirstTime"],
        counterId: Get.arguments["counterId"],
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/menu-screen',
      page: () => MenuScreen(
        insiderId: Get.arguments?["insiderId"],
        counterName: Get.arguments?["counterName"],
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/menu-item-screen',
      page: () => MenuItemScreen(
        menuId: Get.arguments["menuId"],
        nameOfMenu: Get.arguments["nameOfMenu"],
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/new-item-menu',
      page: () => AddNewItemInMenuScreen(
        menuCategoryId: Get.arguments["menuCategoryId"],
        menuCategoryName: Get.arguments["menuCategoryName"],
        itemId: Get.arguments["itemId"],
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/home-screen',
      page: () => HomeScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/past-events',
      page: () => PastEventsScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/upcoming-events',
      page: () => UpcomingEventsScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/event-creation',
      page: () => EventCreationScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/live-orders',
      page: () => LiveOrdersScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/add-repetitive-day-screen',
      page: () => AddRepetitiveScreen(
        controller: Get.arguments["controller"],
        date: Get.arguments["date"],
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/past-event-month-screen',
      page: () => PastEventMonthly(
        year: Get.arguments["year"],
      ),
      transition: Transition.fade,
    ),

    GetPage(
      name: '/past-event-monthly-details-screen',
      page: () => PastEventMonthlyDetailsScreen(
          year: Get.arguments["year"], month: Get.arguments["month"]),
      transition: Transition.fade,
    ),
  ];

  static GetPage<dynamic> unknownRoute = GetPage(
    name: '/error',
    page: () => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR: Page not found'),
      ),
    ),
  );
}
