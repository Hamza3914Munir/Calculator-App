import 'package:calculator/Provider/Cal_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/colors.dart';

class Button1 extends StatelessWidget {
  const Button1(
      {super.key, required this.label, this.textColor = Colors.white});

  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    Color buttonTextColor = provider.isDarkTheme
        ? AppColors.darkSecondaryColor
        : AppColors.lightPrimaryColor;

    return InkWell(
      onTap: () {
        provider.setValue(label);
      },
      child: Material(
        elevation: 3,
        color: provider.isDarkTheme
            ? AppColors.darkSecondaryColor
            : AppColors.lightSecondaryColor,
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          backgroundColor: provider.isDarkTheme
              ? Colors.black
              : AppColors.lightAccentColor,
          radius: 36,
          child: Text(
            label,
            style: TextStyle(fontSize: 32, color: buttonTextColor),
          ),
        ),
      ),
    );
  }
}
