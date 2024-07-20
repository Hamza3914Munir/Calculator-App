import 'package:calculator/Constants/colors.dart';
import 'package:calculator/Provider/Cal_Provider.dart';
import 'package:calculator/Widgets/Equal_Button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/textField.dart';
import 'Data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, value , _ ){
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("Calculator App",style: Theme.of(context).textTheme.headlineMedium,),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          body: Column(
            children: [
              CustomTextField(controller: value.calController,),
              Spacer(),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) => ButtonList[index]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) => ButtonList[index + 4]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) => ButtonList[index + 8]),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    3, (index) => ButtonList[index + 12]),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    3, (index) => ButtonList[index + 15]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        EqualButton()
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
