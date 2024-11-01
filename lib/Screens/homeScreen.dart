import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Widgets/Equal_Button.dart';
import '../Widgets/textField.dart';
import 'package:calculator/Provider/Cal_Provider.dart';
import 'package:provider/provider.dart';
import 'package:fk_toggle/fk_toggle.dart';
import 'Data.dart';
import 'camera.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, value, _) {
        // Determine the selected index based on the theme
        int selectedIndex = value.isDarkTheme ? 0 : 1;

        return Scaffold(
          backgroundColor: value.isDarkTheme
              ? AppColors.darkPrimaryColor
              : Colors.lightBlueAccent,
          appBar: AppBar(
            title: Text(
              "AI Calculator",
              style: TextStyle(
                  color: value.isDarkTheme
                      ? Colors.white
                      : Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            backgroundColor: value.isDarkTheme
                ? AppColors.darkAccentColor
                : AppColors.lightSecondaryColor,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 10),
                child: FkToggle(
                  width: 50,
                  height: 35,
                  labels: const ['', ''],
                  icons: const [
                    Icon(Icons.nights_stay, color: Colors.white),
                    Icon(Icons.wb_sunny, color: Colors.white),
                  ],
                  onSelected: (int index, FkToggle toggle) {
                    setState(() {
                      if (index != selectedIndex) {
                        selectedIndex = index;
                        value.toggleTheme(); // Switch theme
                      }
                    });
                  },
                  selectedColor: selectedIndex == 0 ? Colors.blue : Colors.black,
                  backgroundColor: selectedIndex == 0 ? Colors.black : Colors.black,
                  enabledElementColor: Colors.white,
                  disabledElementColor: Colors.white,
                  cornerRadius: 50,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              CustomTextField(
                controller: value.calController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                      borderRadius: BorderRadius.circular(50),
                      elevation: 3,
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Icons.mic_rounded, color: Colors.white),
                      )),
                  Material(
                      borderRadius: BorderRadius.circular(50),
                      elevation: 3,
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Icons.photo_library, color: Colors.white),
                      )),
                  Material(
                      borderRadius: BorderRadius.circular(50),
                      elevation: 3,
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CameraCaptureScreen()));
                            },
                            child: Icon(Icons.camera_alt_rounded,
                                color: Colors.white)),
                      )),
                ],
              ),
              Spacer(),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                decoration: BoxDecoration(
                  color: value.isDarkTheme
                      ? AppColors.darkAccentColor
                      : AppColors.lightSecondaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          4, (index) => ButtonList(context)[index]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          4, (index) => ButtonList(context)[index + 4]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          4, (index) => ButtonList(context)[index + 8]),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: List.generate(3,
                                        (index) => ButtonList(context)[index + 12]),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: List.generate(3,
                                        (index) => ButtonList(context)[index + 15]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        EqualButton()
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
