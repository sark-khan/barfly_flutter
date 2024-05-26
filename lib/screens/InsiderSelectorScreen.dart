import 'package:barfly/appConstants.dart';
import 'package:flutter/material.dart';

class Insiderselectorscreen extends StatefulWidget {
  @override
  State createState() => _InsiderSelectorScreenState();
}

class _InsiderSelectorScreenState extends State<Insiderselectorscreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: AppColors.backgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Color(0xFF4f5273),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Text("Insider 1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                            fontSize: 20)),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
