import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorProvider extends ChangeNotifier {
  final calController = TextEditingController();

  setValue(String value) {
    String str = calController.text;

    switch (value) {
      case "C":
        calController.clear();
        break;

      case "AC":
        calController.text = str.substring(0, str.length - 1);
        break;

      case "X":
        calController.text += "*";
        break;

      case "=":
        compute();
        break;
      default:
        calController.text += value;
    }

    calController.selection = TextSelection.fromPosition(
        TextPosition(offset: calController.text.length));
  }

  compute() {
    String text = calController.text;
    calController.text = text.interpret().toString();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


}