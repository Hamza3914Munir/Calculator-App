import 'package:calculator/Provider/Cal_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/colors.dart';

class EqualButton extends StatelessWidget {
  const EqualButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    Color buttonColor = provider.isDarkTheme
        ? Colors.black
        : AppColors.lightAccentColor;

    return InkWell(
      onTap: () {
        provider.setValue("=");
      },
      child: Container(
        height: 160,
        width: 70,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            "=",
            style: TextStyle(fontSize: 35, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
