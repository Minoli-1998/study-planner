import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          filled: true,
          fillColor: Colors.grey.withValues(alpha: 0.25),
        ),
        validator: validator,
      ),
    );
  }
}
