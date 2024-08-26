import 'package:barfly/appConstants.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;

  const InputField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.isPassword,
      this.fontSize,
      this.height,
      this.fontWeight})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  // final TextEditingController controller;
  // final String hintText;
  bool obscureText = true;
  // final bool isPassword;

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
      child: TextField(
        controller: widget.controller,
        style: TextStyle(
          color: Colors.white,
          fontSize: widget.fontSize,
          height: widget.height,
          fontWeight: widget.fontWeight,
          fontFamily: "Helvetica",
        ),
        obscureText: widget.isPassword ? obscureText : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF4f5273),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixIcon: widget.isPassword
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: obscureText
                            ? Colors.grey
                            : APPCOLORS.backgroundColor,
                      ),
                      onPressed: _toggleObscureText),
                )
              : null,
          hintText: widget.hintText,

          hintStyle: TextStyle(
              color: Colors.white54,
              fontSize: widget.fontSize,
              fontFamily: "Helvetica",
              height: widget.height,
              fontWeight: widget.fontWeight),
          contentPadding: const EdgeInsets.only(
              left: 17.0, right: 17, top: 15.0, bottom: 0),

          // focusedBorder:
        ),
      ),
    );
  }
}
