import 'package:barfly/screens/AccountDetailsScreen.dart';
import 'package:barfly/screens/BussinessDetailsScreen.dart';
import 'package:barfly/screens/EntryScreen.dart';
import 'package:barfly/screens/InsiderScreen.dart';
import 'package:barfly/screens/InsiderSelectorScreen.dart';
import 'package:barfly/screens/LoginScreen.dart';
import 'package:barfly/screens/MenuScreen.dart';
import 'package:barfly/screens/OtpVerificationScreen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case '/entry-screen':
        return FadeRoute(
          page: EntryScreen(),
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
        return FadeRoute(
            page: InsiderSelectorScreen(
          insiderCount: args!["insiderCount"],
        ));
      case '/menu-screen':
        return FadeRoute(
            page: MenuScreen(
          insiderId: args!["insiderId"],
        ));
      // case '/admin-notifications':
      //   return MaterialPageRoute(builder: (_) => AdminNotifications());
      // case '/reset-password':
      //   return MaterialPageRoute(builder: (_) => ResetPassword());
      // case "/reset-password-success":
      //   return MaterialPageRoute(builder: (_) => const ResetPasswordSuccess());
      // case '/splash-screen':
      //   return FadeRoute(page: SplashScreen());
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
