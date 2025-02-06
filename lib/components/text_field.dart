import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(// Add a placeholder if needed
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          borderSide: const BorderSide(color: Colors.blueGrey), // White border by default
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          borderSide: const BorderSide(color: Colors.black, width: 1), // Black border when focused
        ),
        fillColor: Colors.white, // Background color of the text field
        filled: true,
        hintText: hintText,// Fills the background with the specified color
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding inside the text field
      ),
    );
  }
}
