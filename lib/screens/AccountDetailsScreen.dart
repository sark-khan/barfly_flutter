import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatefulWidget {
  final String? accountName;
  // final bool? isOrderPage;
  AccountDetailsScreen({this.accountName, Key? key}) : super(key: key);
  @override
  State createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController mainBar = TextEditingController();
    final TextEditingController name = TextEditingController();
    final TextEditingController firstName = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController mobileNumber = TextEditingController();
    final TextEditingController city = TextEditingController();
    final TextEditingController street = TextEditingController();
    final TextEditingController zipCode = TextEditingController();

    return PopScope(
        canPop: true,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(color: Color(0xFF292c4c)),
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
                          text: TextSpan(
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      child: TextField(
                        controller: mainBar,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),

                          hintText: 'Name of your ${widget.accountName}',
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
                        controller: name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),

                          hintText: 'Name',
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
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),

                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),

                          // focusedBorder:
                        ),
                      ),
                    ),
                    SizedBox(
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
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4f5273),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),

                          hintText: 'Zip Code',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),

                          // focusedBorder:
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                            // shape: CircleBorder(eccentricity: 0.),
                            side: const BorderSide(
                                strokeAlign: 2, color: Colors.white),
                            backgroundColor: Color(0xFF292c4c)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
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
              )
            ],
          ),
        ));
  }
}
