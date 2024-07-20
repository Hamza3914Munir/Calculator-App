import 'package:calculator/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/Cal_Provider.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeScreen()
      ),
    );
  }
}
