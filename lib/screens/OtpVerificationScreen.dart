import 'package:barfly/apis.dart';
import 'package:barfly/appConstants.dart';
import 'package:barfly/components/Buttons.dart';
import 'package:barfly/components/InputFields.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpverificationScreen extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? contactNumber;
  final String? city;
  final String? street;
  final String? zipcode;
  final String? productName;
  final String? productType;

  OtpverificationScreen({
    this.firstName,
    this.lastName,
    this.email,
    this.contactNumber,
    this.city,
    this.street,
    this.zipcode,
    this.productType,
    this.productName,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _OtpverificationScreenState();
}

class _OtpverificationScreenState extends State<OtpverificationScreen> {
  final TextEditingController otp = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  void _onSubmit() async {
    if (password.text.isEmpty || rePassword.text.isEmpty || otp.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please Enter all the fields");
      return;
    }
    if (password.text != rePassword.text) {
      Fluttertoast.showToast(msg: "Password do not match");
      return;
    }
    if (password.text.length < 6) {
      Fluttertoast.showToast(
          msg: "Password length should be greater than 6 characters");
      return;
    }
    ReturnObj response = await apis().register(
        widget.email!,
        widget.firstName!,
        widget.lastName!,
        password.text,
        widget.contactNumber!,
        widget.city!,
        widget.street!,
        widget.zipcode!,
        widget.productName!,
        widget.productType!,
        otp.text);

    if (response.status) {
      Fluttertoast.showToast(msg: "Registration Successfull");
      Navigator.pushNamed(context, "/login-screen");
      return;
    } else {
      Fluttertoast.showToast(msg: response.message);
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
                                APP_TEXT_CONSTANTS.REGISTRATION,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 60.0,
                              ),
                              InputField(
                                controller: otp,
                                hintText: "OTP",
                                isPassword: false,
                              ),
                              InputField(
                                controller: password,
                                hintText: "Enter your Password",
                                isPassword: true,
                              ),
                              InputField(
                                controller: rePassword,
                                hintText: "Enter your Password again",
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
