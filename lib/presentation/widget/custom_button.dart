/*
  CustomButton is a reusable widget that can be used to create a button with a custom style.
  It takes two required parameters:
  1. function: VoidCallback
  2. text: String

  I didn't use it for now but in the future i will use it for search, add, delete, update, and other buttons.
 */

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.function,
    required this.text,
  }) : super(key: key);
  final VoidCallback function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(width: 1),
        ),
        shadowColor: const Color(0x3D40BFFF),
        elevation: 5,
      ),
      child: Container(
        height: 57,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.50,
          ),
        ),
      ),
    );
  }
}
