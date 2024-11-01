import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/colors.dart';
import '../Provider/Cal_Provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    Color textFieldColor = provider.isDarkTheme
        ? AppColors.darkAccentColor
        : AppColors.lightSecondaryColor;
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: TextField(
          style: TextStyle(
            fontSize: 50,color: provider.isDarkTheme ? Colors.white : Colors.blue
          ),
          readOnly: true,showCursor: true,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: textFieldColor,filled: true)),
    );
  }
}
