import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: TextField(
          style: TextStyle(
            fontSize: 50,
          ),
          readOnly: true,showCursor: true,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: AppColors.primaryColor,filled: true)),
    );
  }
}
