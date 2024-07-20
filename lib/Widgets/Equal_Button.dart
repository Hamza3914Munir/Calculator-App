import 'package:calculator/Provider/Cal_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/colors.dart';

class EqualButton extends StatelessWidget {
  const EqualButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      Provider.of<CalculatorProvider>(context, listen: false).setValue("=");
      },
      child: Container(
        height: 160,
        width: 70,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Text(
            "=",
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }
}
