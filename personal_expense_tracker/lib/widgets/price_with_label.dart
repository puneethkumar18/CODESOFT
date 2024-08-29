import 'package:flutter/material.dart';

class PriceWithLabel extends StatelessWidget {
  final String label;
  final double price;
  const PriceWithLabel({
    super.key,
    required this.label,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          "\$$price",
          style: TextStyle(
            fontSize: 18,
            color: price > -1 ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
