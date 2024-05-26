import 'package:barfly/screens/AccountDetailsScreen.dart';
import 'package:barfly/screens/BussinessDetailsScreen.dart';
import 'package:barfly/screens/EntryScreen.dart';
import 'package:barfly/screens/InsiderScreen.dart';
import 'package:barfly/screens/InsiderSelectorScreen.dart';
import 'package:flutter/material.dart';
// import 'package:tsf/components/background.dart';
// import 'package:tsf/screens/ForgotPassword.dart';
// import 'package:tsf/screens/HomeScreen.dart';
// import 'package:tsf/screens/Login.dart';
// import 'package:tsf/screens/Notifications.dart';
// import 'package:tsf/screens/OrderDetails.dart';
// import 'package:tsf/screens/ResetPassword.dart';
// import 'package:tsf/screens/ResetPasswordSuccess.dart';
// import 'package:tsf/screens/adminDashboard.dart';
// import 'package:tsf/screens/adminScreens/NotificationScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case '/entry-screen':
        return FadeRoute(
          page: EntryScreen(),
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
                  accountName: args!["accountName"],
                  // isOrderPage: args["isOrderPage"],
                ));
      case '/insider-screen':
        return FadeRoute(page: InsiderScreen());

      case '/insider-selector-screen':
        return FadeRoute(page: Insiderselectorscreen());
      // case '/notification':
      //   return FadeRoute(page: const Notifications());
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
