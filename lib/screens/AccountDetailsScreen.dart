import 'package:barfly/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountDetailsScreen extends StatefulWidget {
  final String? productType;
  // final bool? isOrderPage;
  AccountDetailsScreen({this.productType, Key? key}) : super(key: key);
  @override
  State createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController productName = TextEditingController();
    final TextEditingController name = TextEditingController();
    final TextEditingController firstName = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController mobileNumber = TextEditingController();
    final TextEditingController city = TextEditingController();
    final TextEditingController street = TextEditingController();
    final TextEditingController zipCode = TextEditingController();

    void _otpSent() async {
      if (productName.text.isEmpty ||
          name.text.isEmpty ||
          firstName.text.isEmpty ||
          email.text.isEmpty ||
          mobileNumber.text.isEmpty ||
          city.text.isEmpty ||
          street.text.isEmpty ||
          zipCode.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please Enter all the Details");
        return;
      }
      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(email.text)) {
        Fluttertoast.showToast(msg: "Please Enter a valid Email Address");
        return;
      }
      ReturnObj response = await apis().sendOtp(email.text);
      if (response.status) {
        Navigator.pushNamed(context, "/otp-screen", arguments: {
          "firstName": firstName.text,
          "lastName": name.text,
          "email": email.text,
          "contactNumber": mobileNumber.text,
          "city": city.text,
          "street": street.text,
          "zipcode": zipCode.text,
          "productName": productName.text,
          "productType": widget.productType
        });
        Fluttertoast.showToast(msg: response.message);
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
      return;
    }

    return PopScope(
        canPop: true,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(color: Color(0xFF292c4c)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80.0,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 40.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Account ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30.0),
                                  ),
                                  TextSpan(
                                    text: 'Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextField(
                            controller: productName,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF4f5273),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              hintText: 'Name of your ${widget.productType}',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),

                              // focusedBorder:
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextField(
                            controller: name,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF4f5273),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              hintText: 'Name',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),

                              // focusedBorder:
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextField(
                            controller: firstName,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF4f5273),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              hintText: 'First Name',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),

                              // focusedBorder:
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextField(
                            controller: email,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF4f5273),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              hintText: 'E-Mail',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),

                              // focusedBorder:
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextField(
                            controller: mobileNumber,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF4f5273),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              hintText: 'Mobile Number',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),

                              // focusedBorder:
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextField(
                            controller: city,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF4f5273),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              hintText: 'City',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),

                              // focusedBorder:
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextField(
                            controller: street,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF4f5273),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              hintText: 'Street',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),

                              // focusedBorder:
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextField(
                            controller: zipCode,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF4f5273),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              hintText: 'Zip Code',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),

                              // focusedBorder:
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 60,
                          width: 220,
                          child: ElevatedButton(
                            onPressed: _otpSent,
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    strokeAlign: 2, color: Colors.white),
                                backgroundColor: Color(0xFF292c4c)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Text(
                                "Set up Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300,
                                  // backgroundColor: Color(0xFF2ac4aa)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
