import 'package:flutter/material.dart';

List<String> time = [
  "Daily",
  "Weekly",
  "Monthly",
];
void showSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 18,
            color: Colors.teal.shade400,
          ),
        ),
      ),
    ),
  );
}
