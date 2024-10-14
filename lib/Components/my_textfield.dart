
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_provider.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;
  final Icon prefixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: label,
        labelStyle: const TextStyle(fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: (Provider.of<ThemeController>(context).isDark)
                ? Colors.white
                : Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
