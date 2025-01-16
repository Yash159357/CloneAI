import 'package:clone_ai/consts/color_consts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    required this.obscure,
  });

  final String title;
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white24,
          fontSize: 16,
        ),
        filled: true,
        fillColor: colTextField,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white54,
            width: 0.75,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white70,
            // color: Colors.cyan.shade800,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
