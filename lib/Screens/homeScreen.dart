import 'package:calculator/Screens/Gallery.dart';
import 'package:calculator/Screens/voice.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Widgets/Equal_Button.dart';
import '../Widgets/appbar.dart';
import '../Widgets/textField.dart';
import 'package:calculator/Provider/Cal_Provider.dart';
import 'package:provider/provider.dart';
import 'package:fk_toggle/fk_toggle.dart';
import 'Data.dart';
import 'Permissions.dart';
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
        return Scaffold(
          backgroundColor: context.watch<CalculatorProvider>().isDarkTheme
            ? AppColors.darkPrimaryColor
            : Colors.lightBlueAccent,
            appBar:  CommonAppBar(isHomeScreen: true),
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
                        child: InkWell(
                            onTap: () async {
                              if (await PermissionsHandler.requestMicrophonePermission(context)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MicrophonePermissionScreen()),
                                );
                              }
                            },
                         child: Icon(Icons.mic_rounded, color: Colors.white)),
                      )),
                  Material(
                      borderRadius: BorderRadius.circular(50),
                      elevation: 3,
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                            onTap: () async {
                              if (await PermissionsHandler.requestGalleryPermission(context)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GalleryCaptureScreen()),
                                );
                              }
                            },
                            child:
                            Icon(Icons.photo_library, color: Colors.white)),
                      )),
                  Material(
                      borderRadius: BorderRadius.circular(50),
                      elevation: 3,
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                            onTap: () async {
                              if (await PermissionsHandler.requestCameraPermission(context)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CameraCaptureScreen()),
                                );
                              }
                            },
                            child: Icon(Icons.camera_alt_rounded,
                                color: Colors.white)),
                      )),
                ],
              ),
              Spacer(),
              Container(
                height: MediaQuery
                    .sizeOf(context)
                    .height * 0.6,
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
                                        (index) =>
                                    ButtonList(context)[index + 12]),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: List.generate(3,
                                        (index) =>
                                    ButtonList(context)[index + 15]),
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


