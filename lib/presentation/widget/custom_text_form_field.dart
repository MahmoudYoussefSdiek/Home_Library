/*
  CustomTextField is a custom widget that is used to create a text field with a custom design.
  It takes a TextEditingController, hintText, colorFlag, and validator as required parameters.
  The colorFlag is used to change the color of the border of the text field.
  The validator is used to validate the text field.
*/

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  late bool colorFlag;
  final String? Function(String?)? validator;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.colorFlag,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Color(0xFF9098B1),
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.50,
      ),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF9098B1),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.50,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: widget.colorFlag ? Colors.black12 : Colors.red,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
      onChanged: (value) {
        setState(() {
          widget.colorFlag = true;
        });
      },
      validator: widget.validator,
    );
  }
}
