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
import 'package:barfly/screens/setting_screen_counter.dart';
import 'package:barfly/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case '/entry-screen':
        return FadeRoute(
          page: EntryScreen(),
        );
      case '/splash-screen':
        return FadeRoute(
          page: SplashScreen(),
        );
      case '/login-screen':
        return FadeRoute(
          page: LoginScreen(),
        );
      case '/bussiness-details-screen':
        return FadeRoute(
          page: BussinessDetailsScreen(),
        );
      // case '/account-details-screen':
      //   return FadeRoute(page: AccountDetailsScreen());
      case '/account-details-screen':
        return MaterialPageRoute(
            builder: (_) => AccountDetailsScreen(
                  productType: args!["productType"],
                  // isOrderPage: args["isOrderPage"],
                ));
      case '/otp-screen':
        return MaterialPageRoute(
            builder: (_) => OtpverificationScreen(
                  productType: args!["productType"],
                  firstName: args["firstName"],
                  lastName: args["lastName"],
                  email: args["email"],
                  contactNumber: args["contactNumber"],
                  city: args["city"],
                  street: args["street"],
                  zipcode: args["zipcode"],
                  // productType: args!["productType"],
                  productName: args!["productName"],
                  // isOrderPage: args["isOrderPage"],
                ));
      case '/insider-screen':
        return FadeRoute(page: InsiderScreen());

      case '/insider-selector-screen':
      // return FadeRoute(
      //     page: InsiderSelectorScreen(
      //   insiderCount: args?["insiderCount"] ?? 1,
      // ));

      case '/add-quantity-screen':
        return FadeRoute(
            page: const AddQuantityItemsScreen(
          itemId: "66c1df98b19ea52d2989633a",
          nameOfItem: "French Fries",
        ));

      case '/counter-settings-screen':
        return FadeRoute(
            page: SettingScreenCounter(
          isFirstTime: args!["isFirstTime"],
          counterId: args["counterId"],
        ));
      case '/menu-screen':
        String? insiderId = args?["insiderId"] as String?;
        if (insiderId == null) {
          return FadeRoute(page: const MenuScreen());
        }
        return FadeRoute(
            page: MenuScreen(
          insiderId: args!["insiderId"],
          counterName: args!["counterName"],
        ));
      case '/menu-item-screen':
        return FadeRoute(
            page: MenuItemScreen(
          menuId: args!["menuId"],
          nameOfMenu: args["nameOfMenu"],
        ));

      case '/new-item-menu':
        return FadeRoute(
            page: AddNewItemInMenuScreen(
                menuCategoryId: args!["menuCategoryId"],
                menuCategoryName: args["menuCategoryName"],
                itemId: args["itemId"]));

      case '/home-screen':
        return FadeRoute(
            page: HomeScreen(
                // menuId: args!["menuId"],
                // menuName: args["menuName"],
                ));
      case '/past-events':
        return FadeRoute(
            page: PastEventsScreen(
                // menuId: args!["menuId"],
                // menuName: args["menuName"],
                ));

      case '/upcoming-events':
        return FadeRoute(page: UpcomingEventsScreen());
      // case '/add-quantity-menu-items':
      //   return FadeRoute(
      //       page: AddQuantityItemsScreen(
      //     menuId: 'args!["menuId"]',
      //     nameOfMenu: 'args["menuName"]',
      //   ));

      case '/event-creation':
        return FadeRoute(page: const EventCreationScreen());

      case '/live-orders':
        return FadeRoute(page: LiveOrdersScreen());
      // return FadeRoute(page: EventCreationScreen());
      case '/add-repetitive-day-screen':
        return FadeRoute(
            page: AddRepetitiveScreen(
          controller: args!["controller"],
        ));
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
