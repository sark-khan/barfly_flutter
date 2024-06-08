import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/components/InputFields.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailOrContactNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  void _onSubmit() async {
    if (password.text.isEmpty || emailOrContactNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please Enter all the fields");
      return;
    }
    ReturnObj response =
        await apis().login(emailOrContactNumber.text, password.text);

    if (response.status) {
      Fluttertoast.showToast(msg: "Login Successfull");
      Navigator.pushNamed(context, "/insider-screen");
      return;
    } else {
      Fluttertoast.showToast(msg: response.message);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = constraints.maxHeight;
            double screenWidth = constraints.maxWidth;

            return Stack(
              children: [
                Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration:
                      const BoxDecoration(color: APPCOLORS.backgroundColor),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: screenHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // const SizedBox(height: 20.0),
                              const Text(
                                APP_TEXT_CONSTANTS.LOGIN,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 60.0,
                              ),
                              InputField(
                                controller: emailOrContactNumber,
                                hintText: "Enter Email/Contact Number",
                                isPassword: false,
                              ),
                              InputField(
                                controller: password,
                                hintText: "Enter your Password",
                                isPassword: true,
                              ),
                              const SizedBox(height: 40.0),
                              CustomButtonStroked(
                                text: "Submit",
                                onPressed: _onSubmit,
                                widthofButton: screenWidth / 2,
                                borderRadius: 30,
                                heightofButton: 60,
                                fontSize: 24,
                                verticalPadding: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
