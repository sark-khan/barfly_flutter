import 'package:barfly/Storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => navigateToNextPage());
  }

  void navigateToNextPage() {
    String token = Storage.getJwtToken();
    Future.delayed(const Duration(seconds: 1), () {
      if (token.isEmpty) {
        Navigator.of(context).pushReplacementNamed("/login-screen");
      } else {
        Navigator.pushNamed(context, "/insider-screen");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
            body: Center(
          child: Image.asset(
            "barfly.png",
            width: 200,
            height: 300,
          ),
        )));
  }
}
