import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hinttext;
  final IconData? icon;
  final bool isPass;
  final bool isNum;
  final int maxLines;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.hinttext,
    this.icon,
    required this.controller,
    this.isPass = false,
    this.isNum = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLines: maxLines,
      keyboardType: isNum == true
          ? const TextInputType.numberWithOptions()
          : TextInputType.text,
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
        prefixIcon: icon == null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            color: Colors.black54,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
