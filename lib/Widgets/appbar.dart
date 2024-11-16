import 'package:fk_toggle/fk_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/colors.dart';
import '../Provider/Cal_Provider.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isHomeScreen;
  const CommonAppBar({Key? key, this.isHomeScreen = false}) : super(key: key);

  @override
  _CommonAppBarState createState() => _CommonAppBarState();

  // Implement PreferredSizeWidget by providing preferredSize
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CommonAppBarState extends State<CommonAppBar> {
  int selectedIndex = 0;  // Default value for the toggle

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<CalculatorProvider>().isDarkTheme;

    return AppBar(
      title: Text(
        "AI Calculator",
        style: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.deepPurpleAccent,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      backgroundColor: isDarkTheme
          ? AppColors.darkAccentColor
          : AppColors.lightSecondaryColor,
      centerTitle: true,
      leading: widget.isHomeScreen
          ? null // No back arrow for Home screen
          : IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: isDarkTheme ? Colors.white : Colors.blue,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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
                  context.read<CalculatorProvider>().toggleTheme(); // Switch theme using the provider
                }
              });
            },
            selectedColor: selectedIndex == 0 ? Colors.blue : Colors.black,
            backgroundColor: selectedIndex == 0 ? Colors.black : Colors.black,
            enabledElementColor: Colors.white,
            disabledElementColor: Colors.white,
            cornerRadius: 50,
          ),
        ),
      ],
    );
  }
}
