import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextEditingController controller;
  const CustomTextfield({
    super.key,
    required this.text,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 1.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter the values of $text field";
        }
        return null;
      },
    );
  }
}
