import 'package:flutter/material.dart';
import 'package:study_planner/constants/colors.dart';

class CustomAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  const CustomAppButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryColor),
        padding: WidgetStatePropertyAll(
          EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 30),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
