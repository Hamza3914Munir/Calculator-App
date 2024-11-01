import 'package:calculator/Constants/colors.dart';
import 'package:calculator/Widgets/Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Provider/Cal_Provider.dart';

List<Widget> ButtonList(BuildContext context) {
  final isDarkTheme = Provider.of<CalculatorProvider>(context).isDarkTheme;

  return [
    Button1(
      label: "C",
      textColor: isDarkTheme ? AppColors.darkSecondaryColor : AppColors.lightSecondaryColor,
    ),
    Button1(
      label: "/",
      textColor: isDarkTheme ? AppColors.darkSecondaryColor : AppColors.lightSecondaryColor,
    ),
    Button1(
      label: "X",
      textColor: isDarkTheme ? AppColors.darkSecondaryColor : AppColors.lightSecondaryColor,
    ),
    Button1(
      label: "AC",
      textColor: isDarkTheme ? AppColors.darkSecondaryColor : AppColors.lightSecondaryColor,
    ),
    Button1(label: "7"),
    Button1(label: "8"),
    Button1(label: "9"),
    Button1(
      label: "-",
      textColor: isDarkTheme ? AppColors.darkSecondaryColor : AppColors.lightSecondaryColor,
    ),
    Button1(label: "4"),
    Button1(label: "5"),
    Button1(label: "6"),
    Button1(
      label: "+",
      textColor: isDarkTheme ? AppColors.darkSecondaryColor : AppColors.lightSecondaryColor,
    ),
    Button1(label: "1"),
    Button1(label: "2"),
    Button1(label: "3"),
    Button1(label: "%"),
    Button1(label: "0"),
    Button1(label: "."),
  ];
}
