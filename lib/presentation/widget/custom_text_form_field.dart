import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  late bool colorFlag;
  final String? Function(String?)? validator;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
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
        prefixIcon: Icon(
          widget.prefixIcon,
          color: widget.colorFlag ? null : Colors.red,
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF9098B1),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.50,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: widget.colorFlag ? const Color(0xFFEAEFFF) : Colors.red,
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